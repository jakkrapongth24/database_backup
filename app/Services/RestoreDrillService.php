<?php

namespace App\Services;

use App\Models\BackupJob;
use App\Models\BackupTarget;
use App\Models\RestoreDrill;
use RuntimeException;
use Throwable;

class RestoreDrillService
{
    public function runForTarget(BackupTarget $target, ?BackupJob $backupJob = null, ?int $userId = null): RestoreDrill
    {
        $startedAt = now();
        $backupJob ??= $this->latestRestorableBackup($target);

        $drill = RestoreDrill::create([
            'backup_target_id' => $target->id,
            'backup_job_id' => $backupJob?->id,
            'status' => 'running',
            'started_at' => $startedAt,
            'source_name' => $backupJob?->file_name,
            'source_path' => $backupJob?->file_path,
            'created_by' => $userId,
        ]);

        try {
            if (! $backupJob) {
                throw new RuntimeException('No successful backup job found for restore drill.');
            }

            $checks = $this->checks($target, $backupJob);
            $failed = collect($checks)->firstWhere('status', 'failed');
            $finishedAt = now();

            $drill->update([
                'status' => $failed ? 'failed' : 'success',
                'finished_at' => $finishedAt,
                'duration_seconds' => $startedAt->diffInSeconds($finishedAt),
                'checks' => $checks,
                'error_message' => $failed['message'] ?? null,
            ]);

            app(AuditLogger::class)->log($failed ? 'restore_drill.failed' : 'restore_drill.completed', "Restore drill {$drill->status} for {$target->name}.", $drill, [
                'target' => $target->name,
                'backup_job_id' => $backupJob->id,
                'source_name' => $backupJob->file_name,
                'failed_check' => $failed['label'] ?? null,
            ], $userId);

            if ($failed) {
                app(BackupHealthAlertService::class)->send(
                    'Restore drill',
                    $target,
                    $failed['message'],
                    backupJob: $backupJob,
                    restoreDrill: $drill->refresh()->load(['target', 'backupJob']),
                    userId: $userId,
                );
            }
        } catch (Throwable $exception) {
            $finishedAt = now();

            $drill->update([
                'status' => 'failed',
                'finished_at' => $finishedAt,
                'duration_seconds' => $startedAt->diffInSeconds($finishedAt),
                'error_message' => $exception->getMessage(),
                'checks' => $drill->checks ?: [],
            ]);

            app(AuditLogger::class)->log('restore_drill.failed', "Restore drill failed for {$target->name}.", $drill, [
                'target' => $target->name,
                'backup_job_id' => $backupJob?->id,
                'error' => $exception->getMessage(),
            ], $userId);

            app(BackupHealthAlertService::class)->send(
                'Restore drill',
                $target,
                $exception->getMessage(),
                backupJob: $backupJob,
                restoreDrill: $drill->refresh()->load(['target', 'backupJob']),
                userId: $userId,
            );
        }

        return $drill->refresh();
    }

    public function latestRestorableBackup(BackupTarget $target): ?BackupJob
    {
        return BackupJob::query()
            ->where('backup_target_id', $target->id)
            ->where('status', 'success')
            ->latest('finished_at')
            ->latest('id')
            ->first();
    }

    /**
     * @return array<int, array{label: string, status: string, message: string}>
     */
    private function checks(BackupTarget $target, BackupJob $backupJob): array
    {
        $checks = [
            $this->check('Backup job status', $backupJob->status === 'success', 'Backup job is successful.', 'Backup job is not successful.'),
            $this->check('Backup job target', $backupJob->backup_target_id === $target->id, 'Backup job belongs to target.', 'Backup job belongs to another target.'),
            $this->check('Backup verification', $backupJob->verification_status === 'passed', 'Backup verification passed.', 'Backup verification has not passed.'),
            $this->check('Backup file path', (bool) $backupJob->file_path, 'Backup file path is present.', 'Backup file path is empty.'),
        ];

        if (! $backupJob->file_path) {
            return $checks;
        }

        $checks[] = $this->check('Backup file exists', is_file($backupJob->file_path), 'Backup file exists.', 'Backup file does not exist.');
        $checks[] = $this->check('Backup file readable', is_readable($backupJob->file_path), 'Backup file is readable.', 'Backup file is not readable.');
        $checks[] = $this->check('Backup file not empty', is_file($backupJob->file_path) && filesize($backupJob->file_path) > 0, 'Backup file has content.', 'Backup file is empty.');

        if (str_ends_with(strtolower($backupJob->file_path), '.gz')) {
            $checks[] = $this->gzipCheck($backupJob->file_path);
        }

        return $checks;
    }

    /**
     * @return array{label: string, status: string, message: string}
     */
    private function gzipCheck(string $filePath): array
    {
        $gzip = @gzopen($filePath, 'rb');

        if ($gzip === false) {
            return $this->check('Gzip readable', false, '', 'Cannot open gzip backup file.');
        }

        try {
            $chunk = gzread($gzip, 1024);

            return $this->check('Gzip readable', $chunk !== false && $chunk !== '', 'Gzip backup file can be read.', 'Gzip backup file is empty or unreadable.');
        } finally {
            gzclose($gzip);
        }
    }

    /**
     * @return array{label: string, status: string, message: string}
     */
    private function check(string $label, bool $passed, string $successMessage, string $failureMessage): array
    {
        return [
            'label' => $label,
            'status' => $passed ? 'passed' : 'failed',
            'message' => $passed ? $successMessage : $failureMessage,
        ];
    }
}
