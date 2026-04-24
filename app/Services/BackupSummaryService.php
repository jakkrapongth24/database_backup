<?php

namespace App\Services;

use App\Models\BackupJob;
use App\Models\BackupTarget;
use Carbon\CarbonInterface;
use Illuminate\Support\Collection;

class BackupSummaryService
{
    /**
     * @return array{
     *     period_start: CarbonInterface,
     *     period_end: CarbonInterface,
     *     stats: array<string, int|float|string>,
     *     failed_targets: Collection<int, array<string, mixed>>,
     *     missing_targets: Collection<int, array<string, mixed>>
     * }
     */
    public function build(CarbonInterface $periodStart, CarbonInterface $periodEnd): array
    {
        $baseQuery = BackupJob::query()
            ->whereBetween('started_at', [$periodStart, $periodEnd]);

        $total = (clone $baseQuery)->count();
        $queued = (clone $baseQuery)->where('status', 'queued')->count();
        $running = (clone $baseQuery)->where('status', 'running')->count();
        $success = (clone $baseQuery)->where('status', 'success')->count();
        $failed = (clone $baseQuery)->where('status', 'failed')->count();
        $totalBytes = (int) (clone $baseQuery)->where('status', 'success')->sum('file_size');
        $avgDuration = (int) round((float) ((clone $baseQuery)->whereNotNull('duration_seconds')->avg('duration_seconds') ?? 0));

        $failedTargets = BackupTarget::query()
            ->where('is_active', true)
            ->withCount([
                'jobs as failed_jobs_count' => fn ($query) => $query
                    ->whereBetween('started_at', [$periodStart, $periodEnd])
                    ->where('status', 'failed'),
                'jobs as success_jobs_count' => fn ($query) => $query
                    ->whereBetween('started_at', [$periodStart, $periodEnd])
                    ->where('status', 'success'),
            ])
            ->get()
            ->filter(fn (BackupTarget $target): bool => $target->failed_jobs_count > 0)
            ->sortByDesc('failed_jobs_count')
            ->values()
            ->map(fn (BackupTarget $target): array => [
                'target' => $target,
                'failed_jobs_count' => (int) $target->failed_jobs_count,
                'success_jobs_count' => (int) $target->success_jobs_count,
            ]);

        $missingTargets = BackupTarget::query()
            ->where('is_active', true)
            ->where('schedule_frequency', '!=', 'manual')
            ->get()
            ->filter(function (BackupTarget $target) use ($periodStart, $periodEnd): bool {
                return ! BackupJob::query()
                    ->where('backup_target_id', $target->id)
                    ->whereBetween('started_at', [$periodStart, $periodEnd])
                    ->exists();
            })
            ->values()
            ->map(fn (BackupTarget $target): array => [
                'target' => $target,
                'schedule_label' => ucfirst($target->schedule_frequency).' '.substr((string) ($target->schedule_time ?: '00:00'), 0, 5),
            ]);

        return [
            'period_start' => $periodStart,
            'period_end' => $periodEnd,
            'stats' => [
                'total' => $total,
                'queued' => $queued,
                'running' => $running,
                'success' => $success,
                'failed' => $failed,
                'success_rate' => $total > 0 ? round(($success / $total) * 100, 1) : 0,
                'total_size' => $this->humanBytes($totalBytes),
                'avg_duration' => $avgDuration,
            ],
            'failed_targets' => $failedTargets,
            'missing_targets' => $missingTargets,
        ];
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
}
