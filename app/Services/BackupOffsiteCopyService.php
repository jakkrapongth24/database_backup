<?php

namespace App\Services;

use App\Models\BackupJob;
use RuntimeException;
use Throwable;

class BackupOffsiteCopyService
{
    public function enabled(): bool
    {
        return trim((string) env('BACKUP_OFFSITE_PATH')) !== '';
    }

    public function copy(BackupJob $job): BackupJob
    {
        if (! $this->enabled()) {
            $job->update([
                'offsite_status' => 'skipped',
                'offsite_copied_at' => null,
                'offsite_path' => null,
                'offsite_message' => 'BACKUP_OFFSITE_PATH is not configured.',
            ]);

            return $job->refresh();
        }

        try {
            $destinationPath = $this->copyFile($job);

            $job->update([
                'offsite_status' => 'copied',
                'offsite_copied_at' => now(),
                'offsite_path' => $destinationPath,
                'offsite_message' => 'Backup file copied to offsite storage.',
            ]);

            app(AuditLogger::class)->log('backup.offsite_copied', "Backup copied offsite for {$job->target?->name}.", $job, [
                'backup_job_id' => $job->id,
                'file_name' => $job->file_name,
                'offsite_path' => $destinationPath,
            ], $job->created_by);
        } catch (Throwable $exception) {
            $job->update([
                'offsite_status' => 'failed',
                'offsite_copied_at' => null,
                'offsite_message' => $exception->getMessage(),
            ]);

            app(AuditLogger::class)->log('backup.offsite_failed', "Backup offsite copy failed for {$job->target?->name}.", $job, [
                'backup_job_id' => $job->id,
                'file_name' => $job->file_name,
                'error' => $exception->getMessage(),
            ], $job->created_by);

            if ($job->target) {
                app(BackupHealthAlertService::class)->send(
                    'Offsite copy',
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

    private function copyFile(BackupJob $job): string
    {
        if (! $job->file_path || ! is_file($job->file_path)) {
            throw new RuntimeException('Source backup file does not exist.');
        }

        if (! is_readable($job->file_path)) {
            throw new RuntimeException('Source backup file is not readable.');
        }

        $root = $this->resolveRootDirectory();
        $targetDirectory = $root.DIRECTORY_SEPARATOR.$this->safeSegment($job->target?->name ?? 'deleted-target');

        if (! is_dir($targetDirectory) && ! mkdir($targetDirectory, 0775, true) && ! is_dir($targetDirectory)) {
            throw new RuntimeException("Cannot create offsite target directory: {$targetDirectory}");
        }

        $fileName = $job->file_name ?: basename($job->file_path);
        $destinationPath = $targetDirectory.DIRECTORY_SEPARATOR.$fileName;

        if (! @copy($job->file_path, $destinationPath)) {
            throw new RuntimeException("Cannot copy backup file to offsite path: {$destinationPath}");
        }

        $sourceSize = filesize($job->file_path);
        $destinationSize = filesize($destinationPath);

        if ($sourceSize === false || $destinationSize === false || $sourceSize !== $destinationSize) {
            @unlink($destinationPath);

            throw new RuntimeException('Offsite copy size does not match source backup file.');
        }

        return $destinationPath;
    }

    private function resolveRootDirectory(): string
    {
        $path = trim((string) env('BACKUP_OFFSITE_PATH'));

        if ($path === '') {
            throw new RuntimeException('BACKUP_OFFSITE_PATH is not configured.');
        }

        $directory = $this->isAbsolutePath($path) ? $path : base_path($path);

        if (! is_dir($directory) && ! @mkdir($directory, 0775, true) && ! is_dir($directory)) {
            throw new RuntimeException("Cannot create offsite directory: {$directory}");
        }

        return rtrim($directory, '\\/');
    }

    private function safeSegment(string $value): string
    {
        return preg_replace('/[^A-Za-z0-9_-]+/', '_', $value) ?: 'backup-target';
    }

    private function isAbsolutePath(string $path): bool
    {
        return preg_match('/^[A-Za-z]:[\\\\\\/]/', $path) === 1 || str_starts_with($path, '/') || str_starts_with($path, '\\\\');
    }
}
