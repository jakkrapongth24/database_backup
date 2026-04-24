<?php

namespace App\Http\Controllers;

use App\Models\BackupJob;
use App\Models\BackupTarget;
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

        return view('restore.index', compact('targets', 'selectedTarget', 'backupJobs'));
    }

    public function store(Request $request, DatabaseRestoreService $restoreService, AuditLogger $audit): RedirectResponse
    {
        $data = $request->validate([
            'backup_target_id' => ['required', 'integer', 'exists:backup_targets,id'],
            'source_type' => ['required', 'in:backup_job,upload'],
            'backup_job_id' => ['required_if:source_type,backup_job', 'nullable', 'integer', 'exists:backup_jobs,id'],
            'restore_file' => ['required_if:source_type,upload', 'nullable', 'file', 'max:512000'],
            'confirmation_database' => ['required', 'string', 'max:191'],
            'confirm_understand' => ['accepted'],
            'create_safety_backup' => ['nullable', 'boolean'],
        ]);

        $target = BackupTarget::query()->findOrFail($data['backup_target_id']);

        if (! $target->is_active) {
            return back()->withInput()->with('error', "{$target->name} is inactive. Activate it before restore.");
        }

        if ($data['confirmation_database'] !== $target->database_name) {
            return back()
                ->withInput()
                ->with('error', "Please type the exact database name ({$target->database_name}) to confirm restore.");
        }

        $createSafetyBackup = $request->has('create_safety_backup');

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

                $result = $restoreService->restoreFromBackupJob($target, $backupJob, $createSafetyBackup);
            } else {
                $result = $restoreService->restoreFromUpload($target, $request->file('restore_file'), $createSafetyBackup);
            }

            $message = "Restore {$target->name} completed.";

            if ($result['safety_backup_job_id']) {
                $message .= " Safety backup job #{$result['safety_backup_job_id']} was created first.";
            }

            return redirect()
                ->route('restore.index', ['target_id' => $target->id])
                ->with('status', $message);
        } catch (Throwable $exception) {
            return back()
                ->withInput()
                ->with('error', "Restore failed: {$exception->getMessage()}");
        }
    }
}
