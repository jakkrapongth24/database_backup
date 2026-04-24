<?php

namespace App\Http\Controllers;

use App\Models\BackupTarget;
use App\Services\AuditLogger;
use App\Services\BackupScheduleService;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\View\View;
use Throwable;

class BackupTargetController extends Controller
{
    public function index(BackupScheduleService $scheduleService): View
    {
        $targets = BackupTarget::query()
            ->latest()
            ->paginate(10);
        $dueTargetIds = $scheduleService->dueTargets()
            ->pluck('id')
            ->all();

        return view('backup-targets.index', compact('targets', 'dueTargetIds'));
    }

    public function create(): View
    {
        return view('backup-targets.create', [
            'target' => new BackupTarget([
                'db_type' => 'mariadb',
                'port' => 3306,
                'backup_path' => env('BACKUP_DEFAULT_PATH', 'storage/app/backups'),
                'notification_emails' => env('BACKUP_ALERT_EMAILS'),
                'schedule_frequency' => 'manual',
                'retention_days' => 14,
                'is_active' => true,
            ]),
        ]);
    }

    public function store(Request $request, AuditLogger $audit): RedirectResponse
    {
        $data = $this->validatedData($request);
        $data['created_by'] = Auth::id();
        $data['updated_by'] = Auth::id();

        $target = BackupTarget::create($data);
        $audit->log('target.created', "Created backup target {$target->name}.", $target, [
            'target' => $this->safeTargetPayload($target),
        ]);

        return redirect()
            ->route('backup-targets.index')
            ->with('status', "เพิ่มระบบ {$target->name} แล้ว");
    }

    public function edit(BackupTarget $backupTarget): View
    {
        return view('backup-targets.edit', [
            'target' => $backupTarget,
        ]);
    }

    public function show(BackupTarget $backupTarget): View
    {
        $jobsQuery = $backupTarget->jobs();
        $latestSuccess = (clone $jobsQuery)->where('status', 'success')->latest('started_at')->first();
        $latestFailed = (clone $jobsQuery)->where('status', 'failed')->latest('started_at')->first();

        $summary = [
            'total' => (clone $jobsQuery)->count(),
            'queued' => (clone $jobsQuery)->where('status', 'queued')->count(),
            'running' => (clone $jobsQuery)->where('status', 'running')->count(),
            'success' => (clone $jobsQuery)->where('status', 'success')->count(),
            'failed' => (clone $jobsQuery)->where('status', 'failed')->count(),
            'total_size' => $this->humanBytes((int) (clone $jobsQuery)->where('status', 'success')->sum('file_size')),
            'last_success_at' => $latestSuccess?->started_at,
            'last_failed_at' => $latestFailed?->started_at,
        ];

        return view('backup-targets.show', [
            'target' => $backupTarget,
            'jobs' => $backupTarget->jobs()->latest('started_at')->paginate(10),
            'summary' => $summary,
        ]);
    }

    public function update(Request $request, BackupTarget $backupTarget, AuditLogger $audit): RedirectResponse
    {
        $before = $this->safeTargetPayload($backupTarget);
        $data = $this->validatedData($request, updating: true);
        $data['updated_by'] = Auth::id();

        if (($data['password'] ?? null) === null) {
            unset($data['password']);
        }

        $backupTarget->update($data);
        $backupTarget->refresh();

        $audit->log('target.updated', "Updated backup target {$backupTarget->name}.", $backupTarget, [
            'before' => $before,
            'after' => $this->safeTargetPayload($backupTarget),
        ]);

        return redirect()
            ->route('backup-targets.edit', $backupTarget)
            ->with('status', "บันทึก {$backupTarget->name} แล้ว");
    }

    public function destroy(BackupTarget $backupTarget, AuditLogger $audit): RedirectResponse
    {
        $name = $backupTarget->name;
        $payload = $this->safeTargetPayload($backupTarget);
        $backupTarget->delete();
        $audit->log('target.deleted', "Deleted backup target {$name}.", metadata: [
            'target' => $payload,
        ]);

        return redirect()
            ->route('backup-targets.index')
            ->with('status', "ลบระบบ {$name} แล้ว");
    }

    public function testConnection(BackupTarget $backupTarget, AuditLogger $audit): RedirectResponse
    {
        try {
            config([
                'database.connections.backup_probe' => [
                    'driver' => $backupTarget->db_type,
                    'host' => $this->normalizeHost($backupTarget->host),
                    'port' => $backupTarget->port,
                    'database' => $backupTarget->database_name,
                    'username' => $backupTarget->username,
                    'password' => $backupTarget->password ?? '',
                    'charset' => 'utf8mb4',
                    'collation' => 'utf8mb4_unicode_ci',
                    'prefix' => '',
                    'strict' => false,
                ],
            ]);

            DB::purge('backup_probe');
            DB::connection('backup_probe')->select('select 1');
            DB::disconnect('backup_probe');

            $backupTarget->markConnectionResult(true);
            $audit->log('target.connection_tested', "Connection test passed for {$backupTarget->name}.", $backupTarget, [
                'success' => true,
                'endpoint' => $backupTarget->endpoint,
            ]);

            return back()->with('status', "เชื่อมต่อ {$backupTarget->name} สำเร็จ");
        } catch (Throwable $exception) {
            DB::disconnect('backup_probe');
            $backupTarget->markConnectionResult(false, $exception->getMessage());
            $audit->log('target.connection_tested', "Connection test failed for {$backupTarget->name}.", $backupTarget, [
                'success' => false,
                'endpoint' => $backupTarget->endpoint,
                'error' => $exception->getMessage(),
            ]);

            return back()->with('error', "เชื่อมต่อ {$backupTarget->name} ไม่สำเร็จ: {$exception->getMessage()}");
        }
    }

    /**
     * @return array<string, mixed>
     */
    private function validatedData(Request $request, bool $updating = false): array
    {
        $data = $request->validate([
            'name' => ['required', 'string', 'max:255'],
            'description' => ['nullable', 'string'],
            'db_type' => ['required', 'in:mariadb,mysql'],
            'host' => ['required', 'string', 'max:191'],
            'port' => ['required', 'integer', 'between:1,65535'],
            'database_name' => ['required', 'string', 'max:191'],
            'username' => ['required', 'string', 'max:255'],
            'password' => ['nullable', 'string'],
            'dump_binary_path' => ['nullable', 'string', 'max:255'],
            'backup_path' => ['nullable', 'string', 'max:255'],
            'notification_emails' => ['nullable', 'string', 'max:2000'],
            'schedule_frequency' => ['required', 'in:manual,daily,weekly,monthly'],
            'schedule_time' => ['nullable', 'date_format:H:i'],
            'retention_days' => ['required', 'integer', 'between:1,3650'],
            'is_active' => ['nullable', 'boolean'],
        ]);

        $data['is_active'] = $request->boolean('is_active');
        $data['password'] = $data['password'] !== '' ? $data['password'] : null;

        return $data;
    }

    private function normalizeHost(string $host): string
    {
        return strtolower(trim($host)) === 'localhost' ? '127.0.0.1' : $host;
    }

    private function humanBytes(int $bytes): string
    {
        if ($bytes <= 0) {
            return '-';
        }

        $units = ['B', 'KB', 'MB', 'GB', 'TB'];
        $size = (float) $bytes;

        foreach ($units as $unit) {
            if ($size < 1024 || $unit === 'TB') {
                return number_format($size, $unit === 'B' ? 0 : 2).' '.$unit;
            }

            $size /= 1024;
        }

        return '-';
    }

    /**
     * @return array<string, mixed>
     */
    private function safeTargetPayload(BackupTarget $target): array
    {
        return [
            'id' => $target->id,
            'name' => $target->name,
            'db_type' => $target->db_type,
            'host' => $target->host,
            'port' => $target->port,
            'database_name' => $target->database_name,
            'username' => $target->username,
            'backup_path' => $target->backup_path,
            'notification_emails' => $target->notification_emails,
            'schedule_frequency' => $target->schedule_frequency,
            'schedule_time' => $target->schedule_time,
            'retention_days' => $target->retention_days,
            'is_active' => $target->is_active,
        ];
    }
}
