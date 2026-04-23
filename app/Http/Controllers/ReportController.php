<?php

namespace App\Http\Controllers;

use App\Models\BackupJob;
use App\Models\BackupTarget;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\View\View;

class ReportController extends Controller
{
    public function __invoke(Request $request): View
    {
        $filters = $request->validate([
            'date_from' => ['nullable', 'date'],
            'date_to' => ['nullable', 'date'],
        ]);

        $dateFrom = ($filters['date_from'] ?? null)
            ? Carbon::parse($filters['date_from'])->startOfDay()
            : now()->subDays(29)->startOfDay();
        $dateTo = ($filters['date_to'] ?? null)
            ? Carbon::parse($filters['date_to'])->endOfDay()
            : now()->endOfDay();

        $baseQuery = BackupJob::query()
            ->whereBetween('started_at', [$dateFrom, $dateTo]);

        $total = (clone $baseQuery)->count();
        $success = (clone $baseQuery)->where('status', 'success')->count();
        $failed = (clone $baseQuery)->where('status', 'failed')->count();
        $running = (clone $baseQuery)->where('status', 'running')->count();
        $totalBytes = (int) (clone $baseQuery)->where('status', 'success')->sum('file_size');
        $avgDuration = (int) (clone $baseQuery)->whereNotNull('duration_seconds')->avg('duration_seconds');

        $daily = (clone $baseQuery)
            ->selectRaw('DATE(started_at) as backup_date')
            ->selectRaw('COUNT(*) as total')
            ->selectRaw("SUM(CASE WHEN status = 'success' THEN 1 ELSE 0 END) as success")
            ->selectRaw("SUM(CASE WHEN status = 'failed' THEN 1 ELSE 0 END) as failed")
            ->selectRaw('COALESCE(SUM(file_size), 0) as total_bytes')
            ->groupBy(DB::raw('DATE(started_at)'))
            ->orderBy('backup_date', 'desc')
            ->limit(14)
            ->get()
            ->map(fn ($row): array => [
                'date' => $row->backup_date,
                'total' => (int) $row->total,
                'success' => (int) $row->success,
                'failed' => (int) $row->failed,
                'size' => $this->humanBytes((int) $row->total_bytes),
            ]);

        $targetSummaries = BackupTarget::query()
            ->withCount([
                'jobs as total_jobs' => fn ($query) => $query->whereBetween('started_at', [$dateFrom, $dateTo]),
                'jobs as success_jobs' => fn ($query) => $query->whereBetween('started_at', [$dateFrom, $dateTo])->where('status', 'success'),
                'jobs as failed_jobs' => fn ($query) => $query->whereBetween('started_at', [$dateFrom, $dateTo])->where('status', 'failed'),
            ])
            ->withSum(['jobs as total_file_size' => fn ($query) => $query->whereBetween('started_at', [$dateFrom, $dateTo])->where('status', 'success')], 'file_size')
            ->orderBy('name')
            ->get()
            ->map(function (BackupTarget $target): array {
                $latestSuccess = $target->jobs()
                    ->where('status', 'success')
                    ->latest('started_at')
                    ->first();

                $latestFailed = $target->jobs()
                    ->where('status', 'failed')
                    ->latest('started_at')
                    ->first();

                $latestSuccessAt = $latestSuccess?->started_at;
                $isStale = $target->is_active && (! $latestSuccessAt || $latestSuccessAt->lt(now()->subDays($target->retention_days)));

                return [
                    'target' => $target,
                    'total' => (int) $target->total_jobs,
                    'success' => (int) $target->success_jobs,
                    'failed' => (int) $target->failed_jobs,
                    'success_rate' => $target->total_jobs > 0 ? round(($target->success_jobs / $target->total_jobs) * 100, 1) : 0,
                    'size' => $this->humanBytes((int) $target->total_file_size),
                    'latest_success_at' => $latestSuccessAt,
                    'latest_failed_at' => $latestFailed?->started_at,
                    'is_stale' => $isStale,
                ];
            });

        $stats = [
            'total' => $total,
            'success' => $success,
            'failed' => $failed,
            'running' => $running,
            'success_rate' => $total > 0 ? round(($success / $total) * 100, 1) : 0,
            'total_size' => $this->humanBytes($totalBytes),
            'avg_duration' => $avgDuration,
            'targets' => BackupTarget::count(),
            'stale_targets' => $targetSummaries->where('is_stale', true)->count(),
        ];

        return view('reports.index', [
            'daily' => $daily,
            'dateFrom' => $dateFrom->toDateString(),
            'dateTo' => $dateTo->toDateString(),
            'stats' => $stats,
            'targetSummaries' => $targetSummaries,
        ]);
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
