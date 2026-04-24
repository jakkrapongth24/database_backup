<?php

namespace App\Http\Controllers;

use App\Models\BackupJob;
use App\Models\BackupTarget;
use App\Models\RestoreJob;
use App\Services\AuditLogger;
use App\Services\DatabaseRestoreService;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\View\View;
use Throwable;

class RestoreController extends Controller
{
    public function index(Request $request): View
    {
        $targetId = $request->integer('target_id') ?: null;
        $targets = BackupTarget::query()
            ->where('is_active', true)
            ->orderBy('name')
            ->get();

        $selectedTarget = $targetId
            ? $targets->firstWhere('id', $targetId)
            : $targets->first();

        $backupJobs = BackupJob::query()
            ->with('target')
            ->where('status', 'success')
            ->when($selectedTarget, fn ($query) => $query->where('backup_target_id', $selectedTarget->id))
            ->whereNotNull('file_path')
            ->latest('started_at')
            ->limit(50)
            ->get();
        $recentRestoreJobs = RestoreJob::query()
            ->with(['target', 'backupJob', 'safetyBackupJob'])
            ->when($selectedTarget, fn ($query) => $query->where('backup_target_id', $selectedTarget->id))
            ->latest('started_at')
            ->limit(8)
            ->get();

        return view('restore.index', compact('targets', 'selectedTarget', 'backupJobs', 'recentRestoreJobs'));
    }

    public function history(Request $request): View
    {
        $filters = $request->validate([
            'q' => ['nullable', 'string', 'max:100'],
            'status' => ['nullable', 'in:queued,running,success,failed'],
            'source_type' => ['nullable', 'in:backup_job,upload'],
            'target_id' => ['nullable', 'integer', 'exists:backup_targets,id'],
            'date_from' => ['nullable', 'date'],
            'date_to' => ['nullable', 'date'],
        ]);

        $query = RestoreJob::query()
            ->with(['target', 'backupJob', 'safetyBackupJob'])
            ->when($filters['q'] ?? null, function ($query, string $keyword): void {
                $query->where(function ($query) use ($keyword): void {
                    $query->where('source_name', 'like', "%{$keyword}%")
                        ->orWhere('source_path', 'like', "%{$keyword}%")
                        ->orWhere('error_message', 'like', "%{$keyword}%")
                        ->orWhereHas('target', fn ($query) => $query->where('name', 'like', "%{$keyword}%"));
                });
            })
            ->when($filters['status'] ?? null, fn ($query, string $status) => $query->where('status', $status))
            ->when($filters['source_type'] ?? null, fn ($query, string $sourceType) => $query->where('source_type', $sourceType))
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
            'running' => (clone $summaryQuery)->where('status', 'running')->count(),
            'success' => (clone $summaryQuery)->where('status', 'success')->count(),
            'failed' => (clone $summaryQuery)->where('status', 'failed')->count(),
        ];

        return view('restore.history', compact('jobs', 'targets', 'filters', 'summary'));
    }

    public function store(Request $request, DatabaseRestoreService $restoreService, AuditLogger $audit): RedirectResponse
    {
        $isPrecheck = $request->input('intent') === 'precheck';
        $data = $request->validate([
            'backup_target_id' => ['required', 'integer', 'exists:backup_targets,id'],
            'source_type' => ['required', 'in:backup_job,upload'],
            'backup_job_id' => ['required_if:source_type,backup_job', 'nullable', 'integer', 'exists:backup_jobs,id'],
            'restore_file' => ['required_if:source_type,upload', 'nullable', 'file', 'max:512000'],
            'confirmation_database' => [$isPrecheck ? 'nullable' : 'required', 'string', 'max:191'],
            'confirm_understand' => [$isPrecheck ? 'nullable' : 'accepted'],
            'create_safety_backup' => ['nullable', 'boolean'],
            'intent' => ['nullable', 'in:restore,precheck'],
        ]);

        $target = BackupTarget::query()->findOrFail($data['backup_target_id']);
        $createSafetyBackup = $request->has('create_safety_backup');

        if ($isPrecheck) {
            return $this->precheck($request, $restoreService, $audit, $target, $data, $createSafetyBackup);
        }

        if (! $target->is_active) {
            return back()->withInput()->with('error', "{$target->name} is inactive. Activate it before restore.");
        }

        if ($data['confirmation_database'] !== $target->database_name) {
            return back()
                ->withInput()
                ->with('error', "Please type the exact database name ({$target->database_name}) to confirm restore.");
        }

        $audit->log('restore.requested', "Restore requested for {$target->name}.", $target, [
            'target' => $target->name,
            'database_name' => $target->database_name,
            'source_type' => $data['source_type'],
            'backup_job_id' => $data['backup_job_id'] ?? null,
            'create_safety_backup' => $createSafetyBackup,
        ]);

        try {
            if ($data['source_type'] === 'backup_job') {
                $backupJob = BackupJob::query()->findOrFail($data['backup_job_id']);

                if ($backupJob->backup_target_id !== $target->id) {
                    return back()
                        ->withInput()
                        ->with('error', 'Selected backup job does not belong to this target.');
                }

                $restoreJob = $restoreService->queueFromBackupJob($target, $backupJob, $createSafetyBackup);
            } else {
                $restoreJob = $restoreService->queueFromUpload($target, $request->file('restore_file'), $createSafetyBackup);
            }

            $message = "Restore {$target->name} queued successfully. Restore job #{$restoreJob->id} is waiting for queue worker.";

            return redirect()
                ->route('restore.index', ['target_id' => $target->id])
                ->with('status', $message);
        } catch (Throwable $exception) {
            return back()
                ->withInput()
                ->with('error', "Restore failed: {$exception->getMessage()}");
        }
    }

    /**
     * @param  array<string, mixed>  $data
     */
    private function precheck(Request $request, DatabaseRestoreService $restoreService, AuditLogger $audit, BackupTarget $target, array $data, bool $createSafetyBackup): RedirectResponse
    {
        try {
            if ($data['source_type'] === 'backup_job') {
                $backupJob = BackupJob::query()->findOrFail($data['backup_job_id']);
                $checks = $restoreService->precheckBackupJob($target, $backupJob, $createSafetyBackup);
            } else {
                $checks = $restoreService->precheckUpload($target, $request->file('restore_file'), $createSafetyBackup);
            }

            $passed = collect($checks)->every(fn (array $check): bool => $check['status'] === 'passed');

            $audit->log('restore.prechecked', "Restore pre-check completed for {$target->name}.", $target, [
                'target' => $target->name,
                'database_name' => $target->database_name,
                'source_type' => $data['source_type'],
                'backup_job_id' => $data['backup_job_id'] ?? null,
                'passed' => $passed,
                'checks' => $checks,
            ]);

            return back()
                ->withInput()
                ->with('restore_precheck', [
                    'passed' => $passed,
                    'checks' => $checks,
                ])
                ->with($passed ? 'status' : 'error', $passed ? 'Restore pre-check passed.' : 'Restore pre-check found issues.');
        } catch (Throwable $exception) {
            return back()
                ->withInput()
                ->with('error', "Restore pre-check failed: {$exception->getMessage()}");
        }
    }
}
