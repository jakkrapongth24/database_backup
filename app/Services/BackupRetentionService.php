<?php

namespace App\Services;

use App\Models\BackupJob;
use App\Models\BackupTarget;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\Schema;

class BackupRetentionService
{
    /**
     * @return array{checked:int, deleted_files:int, deleted_offsite_files:int, deleted_records:int, freed_bytes:int, items:Collection<int, array<string, mixed>>}
     */
    public function cleanup(?BackupTarget $target = null, bool $dryRun = false): array
    {
        $items = collect();
        $checked = 0;
        $deletedFiles = 0;
        $deletedOffsiteFiles = 0;
        $deletedRecords = 0;
        $freedBytes = 0;

        if (! Schema::hasTable('backup_targets') || ! Schema::hasTable('backup_jobs')) {
            return [
                'checked' => 0,
                'deleted_files' => 0,
                'deleted_offsite_files' => 0,
                'deleted_records' => 0,
                'freed_bytes' => 0,
                'items' => $items,
            ];
        }

        $targets = BackupTarget::query()
            ->when($target, fn ($query) => $query->whereKey($target->id))
            ->where('retention_days', '>', 0)
            ->get();

        foreach ($targets as $backupTarget) {
            $cutoff = now()->subDays($backupTarget->retention_days)->startOfDay();

            BackupJob::query()
                ->where('backup_target_id', $backupTarget->id)
                ->where('status', 'success')
                ->whereNotNull('finished_at')
                ->where('finished_at', '<', $cutoff)
                ->orderBy('finished_at')
                ->chunkById(100, function ($jobs) use ($backupTarget, $dryRun, &$checked, &$deletedFiles, &$deletedOffsiteFiles, &$deletedRecords, &$freedBytes, $items): void {
                    foreach ($jobs as $job) {
                        $checked++;
                        $fileExists = $job->file_path && is_file($job->file_path);
                        $fileSize = $fileExists ? (int) filesize($job->file_path) : 0;
                        $offsiteFileExists = $this->offsiteFileExists($job);
                        $offsiteFileSize = $offsiteFileExists ? (int) filesize((string) $job->offsite_path) : 0;

                        $items->push([
                            'target' => $backupTarget->name,
                            'job_id' => $job->id,
                            'finished_at' => $job->finished_at?->format('Y-m-d H:i:s'),
                            'file_path' => $job->file_path,
                            'file_exists' => $fileExists,
                            'file_size' => $fileSize,
                            'offsite_path' => $job->offsite_path,
                            'offsite_file_exists' => $offsiteFileExists,
                            'offsite_file_size' => $offsiteFileSize,
                        ]);

                        if ($dryRun) {
                            continue;
                        }

                        if ($fileExists && @unlink($job->file_path)) {
                            $deletedFiles++;
                            $freedBytes += $fileSize;
                        }

                        if ($offsiteFileExists && @unlink($job->offsite_path)) {
                            $deletedOffsiteFiles++;
                            $freedBytes += $offsiteFileSize;
                        }

                        $job->delete();
                        $deletedRecords++;
                    }
                });
        }

        if (! $dryRun && ($deletedFiles > 0 || $deletedOffsiteFiles > 0 || $deletedRecords > 0)) {
            app(AuditLogger::class)->log('retention.cleaned', 'Expired backup files were cleaned up.', $target, [
                'checked' => $checked,
                'deleted_files' => $deletedFiles,
                'deleted_offsite_files' => $deletedOffsiteFiles,
                'deleted_records' => $deletedRecords,
                'freed_bytes' => $freedBytes,
                'target_id' => $target?->id,
            ]);
        }

        return [
            'checked' => $checked,
            'deleted_files' => $deletedFiles,
            'deleted_offsite_files' => $deletedOffsiteFiles,
            'deleted_records' => $deletedRecords,
            'freed_bytes' => $freedBytes,
            'items' => $items,
        ];
    }

    private function offsiteFileExists(BackupJob $job): bool
    {
        if (! $job->offsite_path || ! is_file($job->offsite_path)) {
            return false;
        }

        $root = $this->offsiteRootDirectory();

        if ($root === null) {
            return false;
        }

        $realRoot = realpath($root);
        $realPath = realpath($job->offsite_path);

        if ($realRoot === false || $realPath === false) {
            return false;
        }

        return str_starts_with($realPath, rtrim($realRoot, DIRECTORY_SEPARATOR).DIRECTORY_SEPARATOR);
    }

    private function offsiteRootDirectory(): ?string
    {
        $path = trim((string) env('BACKUP_OFFSITE_PATH'));

        if ($path === '') {
            return null;
        }

        return $this->isAbsolutePath($path) ? $path : base_path($path);
    }

    private function isAbsolutePath(string $path): bool
    {
        return preg_match('/^[A-Za-z]:[\\\\\\/]/', $path) === 1 || str_starts_with($path, '/') || str_starts_with($path, '\\\\');
    }
}
