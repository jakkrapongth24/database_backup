<?php

namespace App\Http\Controllers;

use App\Models\BackupJob;
use App\Models\BackupTarget;
use App\Services\AuditLogger;
use App\Services\DatabaseBackupService;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Illuminate\View\View;
use Symfony\Component\HttpFoundation\BinaryFileResponse;

class BackupJobController extends Controller
{
    public function index(Request $request): View
    {
        $filters = $request->validate([
            'q' => ['nullable', 'string', 'max:100'],
            'status' => ['nullable', 'in:queued,running,success,failed'],
            'target_id' => ['nullable', 'integer', 'exists:backup_targets,id'],
            'date_from' => ['nullable', 'date'],
            'date_to' => ['nullable', 'date'],
        ]);

        $query = BackupJob::query()
            ->with('target')
            ->when($filters['q'] ?? null, function ($query, string $keyword): void {
                $query->where(function ($query) use ($keyword): void {
                    $query->where('file_name', 'like', "%{$keyword}%")
                        ->orWhere('error_message', 'like', "%{$keyword}%")
                        ->orWhereHas('target', fn ($query) => $query->where('name', 'like', "%{$keyword}%"));
                });
            })
            ->when($filters['status'] ?? null, fn ($query, string $status) => $query->where('status', $status))
            ->when($filters['target_id'] ?? null, fn ($query, string $targetId) => $query->where('backup_target_id', $targetId))
            ->when($filters['date_from'] ?? null, fn ($query, string $date) => $query->whereDate('started_at', '>=', $date))
            ->when($filters['date_to'] ?? null, fn ($query, string $date) => $query->whereDate('started_at', '<=', $date));

        $summaryQuery = clone $query;

        $jobs = $query
            ->latest('started_at')
            ->paginate(15)
            ->withQueryString();

        $targets = BackupTarget::query()
            ->orderBy('name')
            ->get(['id', 'name']);

        $summary = [
            'total' => (clone $summaryQuery)->count(),
            'queued' => (clone $summaryQuery)->where('status', 'queued')->count(),
            'success' => (clone $summaryQuery)->where('status', 'success')->count(),
            'failed' => (clone $summaryQuery)->where('status', 'failed')->count(),
            'running' => (clone $summaryQuery)->where('status', 'running')->count(),
        ];

        return view('backup-jobs.index', compact('jobs', 'targets', 'filters', 'summary'));
    }

    public function run(BackupTarget $backupTarget, DatabaseBackupService $backupService, AuditLogger $audit): RedirectResponse
    {
        if (! $backupTarget->is_active) {
            return back()->with('error', "{$backupTarget->name} is inactive. Please activate it before backup.");
        }

        $audit->log('backup.requested', "Manual backup requested for {$backupTarget->name}.", $backupTarget);

        $job = $backupService->queue($backupTarget, Auth::id());

        return back()
            ->with('status', "Backup {$backupTarget->name} queued successfully. Job #{$job->id} is waiting for queue worker.");
    }

    public function download(BackupJob $backupJob, AuditLogger $audit): BinaryFileResponse|RedirectResponse
    {
        $backupJob->load('target');

        if ($backupJob->status !== 'success') {
            return back()->with('error', 'ดาวน์โหลดได้เฉพาะ backup ที่สำเร็จแล้วเท่านั้น');
        }

        if (! $backupJob->file_path || ! is_file($backupJob->file_path)) {
            return back()->with('error', 'ไม่พบไฟล์ backup ในเครื่องแล้ว อาจถูกลบตาม retention หรือ path ถูกย้าย');
        }

        if (! $this->isDownloadAllowed($backupJob)) {
            Log::warning('Blocked backup download outside allowed directory.', [
                'backup_job_id' => $backupJob->id,
                'file_path' => $backupJob->file_path,
                'user_id' => Auth::id(),
            ]);

            return back()->with('error', 'ไม่สามารถดาวน์โหลดไฟล์นี้ได้ เพราะ path ไม่อยู่ในโฟลเดอร์ backup ที่ระบบอนุญาต');
        }

        $audit->log('backup.downloaded', "Downloaded backup {$backupJob->file_name}.", $backupJob, [
            'file_name' => $backupJob->file_name,
            'file_size' => $backupJob->file_size,
            'target' => $backupJob->target?->name,
        ]);

        return response()->download(
            $backupJob->file_path,
            $backupJob->file_name ?: basename($backupJob->file_path),
            ['Content-Type' => 'application/gzip'],
        );
    }

    private function isDownloadAllowed(BackupJob $job): bool
    {
        $filePath = realpath($job->file_path);

        if ($filePath === false) {
            return false;
        }

        foreach ($this->allowedBackupDirectories($job) as $directory) {
            $realDirectory = realpath($directory);

            if ($realDirectory === false) {
                continue;
            }

            $normalizedFilePath = rtrim(str_replace('\\', '/', $filePath), '/');
            $normalizedDirectory = rtrim(str_replace('\\', '/', $realDirectory), '/');

            if ($normalizedFilePath === $normalizedDirectory || str_starts_with($normalizedFilePath, $normalizedDirectory.'/')) {
                return true;
            }
        }

        return false;
    }

    /**
     * @return array<int, string>
     */
    private function allowedBackupDirectories(BackupJob $job): array
    {
        $paths = [
            $job->target?->backup_path,
            env('BACKUP_DEFAULT_PATH', 'storage/app/backups'),
        ];

        return collect($paths)
            ->filter()
            ->map(fn (string $path): string => $this->isAbsolutePath($path) ? $path : base_path($path))
            ->unique()
            ->values()
            ->all();
    }

    private function isAbsolutePath(string $path): bool
    {
        return preg_match('/^[A-Za-z]:[\\\\\\/]/', $path) === 1 || str_starts_with($path, '/') || str_starts_with($path, '\\\\');
    }
}
