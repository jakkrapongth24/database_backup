<?php

namespace App\Services;

use App\Models\BackupJob;
use RuntimeException;
use Throwable;

class BackupVerificationService
{
    public function verify(BackupJob $job): BackupJob
    {
        try {
            $this->assertBackupFileIsUsable($job);

            $job->update([
                'verification_status' => 'passed',
                'verified_at' => now(),
                'verification_message' => 'Backup file exists, is readable, is not empty, and gzip content can be opened.',
            ]);

            app(AuditLogger::class)->log('backup.verified', "Backup verified for {$job->target?->name}.", $job, [
                'backup_job_id' => $job->id,
                'file_name' => $job->file_name,
                'file_size' => $job->file_size,
            ], $job->created_by);
        } catch (Throwable $exception) {
            $job->update([
                'verification_status' => 'failed',
                'verified_at' => now(),
                'verification_message' => $exception->getMessage(),
            ]);

            app(AuditLogger::class)->log('backup.verification_failed', "Backup verification failed for {$job->target?->name}.", $job, [
                'backup_job_id' => $job->id,
                'file_name' => $job->file_name,
                'error' => $exception->getMessage(),
            ], $job->created_by);

            if ($job->target) {
                app(BackupHealthAlertService::class)->send(
                    'Backup verification',
                    $job->target,
                    $exception->getMessage(),
                    backupJob: $job->refresh()->load('target'),
                    userId: $job->created_by,
                );
            }

            throw $exception;
        }

        return $job->refresh();
    }

    private function assertBackupFileIsUsable(BackupJob $job): void
    {
        if (! $job->file_path) {
            throw new RuntimeException('Backup file path is empty.');
        }

        if (! is_file($job->file_path)) {
            throw new RuntimeException("Backup file does not exist: {$job->file_path}");
        }

        if (! is_readable($job->file_path)) {
            throw new RuntimeException("Backup file is not readable: {$job->file_path}");
        }

        $size = filesize($job->file_path);

        if ($size === false || $size <= 0) {
            throw new RuntimeException('Backup file is empty.');
        }

        if (str_ends_with(strtolower($job->file_path), '.gz')) {
            $this->assertGzipCanBeRead($job->file_path);
        }
    }

    private function assertGzipCanBeRead(string $filePath): void
    {
        $gzip = @gzopen($filePath, 'rb');

        if ($gzip === false) {
            throw new RuntimeException('Backup gzip file cannot be opened.');
        }

        try {
            $chunk = gzread($gzip, 1024);

            if ($chunk === false || $chunk === '') {
                throw new RuntimeException('Backup gzip file is empty or unreadable.');
            }
        } finally {
            gzclose($gzip);
        }
    }
}
