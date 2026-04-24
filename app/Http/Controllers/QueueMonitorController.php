<?php

namespace App\Http\Controllers;

use App\Services\AuditLogger;
use Illuminate\Http\RedirectResponse;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use Illuminate\View\View;

class QueueMonitorController extends Controller
{
    public function __invoke(): View
    {
        $pendingJobsCount = Schema::hasTable('jobs') ? DB::table('jobs')->count() : 0;
        $failedJobsCount = Schema::hasTable('failed_jobs') ? DB::table('failed_jobs')->count() : 0;
        $reservedJobsCount = Schema::hasTable('jobs')
            ? DB::table('jobs')->whereNotNull('reserved_at')->count()
            : 0;

        $oldestPending = Schema::hasTable('jobs')
            ? DB::table('jobs')->orderBy('created_at')->value('created_at')
            : null;

        $pendingJobs = Schema::hasTable('jobs')
            ? DB::table('jobs')
                ->orderByDesc('id')
                ->limit(10)
                ->get()
                ->map(fn (object $job): array => [
                    'id' => $job->id,
                    'queue' => $job->queue,
                    'attempts' => $job->attempts,
                    'reserved_at' => $job->reserved_at,
                    'available_at' => $job->available_at,
                    'created_at' => $job->created_at,
                    'display_name' => $this->displayNameFromPayload($job->payload),
                ])
            : collect();

        $failedJobs = Schema::hasTable('failed_jobs')
            ? DB::table('failed_jobs')
                ->orderByDesc('id')
                ->limit(10)
                ->get()
                ->map(fn (object $job): array => [
                    'id' => $job->id,
                    'uuid' => $job->uuid,
                    'connection' => $job->connection,
                    'queue' => $job->queue,
                    'failed_at' => $job->failed_at,
                    'display_name' => $this->displayNameFromPayload($job->payload),
                    'exception_excerpt' => $this->exceptionExcerpt($job->exception),
                ])
            : collect();

        $backupQueueSummary = Schema::hasTable('backup_jobs')
            ? [
                'queued' => DB::table('backup_jobs')->where('status', 'queued')->count(),
                'running' => DB::table('backup_jobs')->where('status', 'running')->count(),
                'failed' => DB::table('backup_jobs')->where('status', 'failed')->count(),
                'success' => DB::table('backup_jobs')->where('status', 'success')->count(),
            ]
            : [
                'queued' => 0,
                'running' => 0,
                'failed' => 0,
                'success' => 0,
            ];

        return view('queue-monitor.index', [
            'backupQueueSummary' => $backupQueueSummary,
            'failedJobs' => $failedJobs,
            'failedJobsCount' => $failedJobsCount,
            'oldestPending' => $oldestPending,
            'pendingJobs' => $pendingJobs,
            'pendingJobsCount' => $pendingJobsCount,
            'queueWorkCommand' => 'php artisan queue:work --tries=1',
            'reservedJobsCount' => $reservedJobsCount,
            'retryFailedCommand' => 'php artisan queue:retry {id}',
        ]);
    }

    public function retryFailedJob(int $failedJobId, AuditLogger $audit): RedirectResponse
    {
        if (! Schema::hasTable('failed_jobs')) {
            return back()->with('error', 'Failed jobs table is not available.');
        }

        $failedJob = DB::table('failed_jobs')->where('id', $failedJobId)->first();

        if (! $failedJob) {
            return back()->with('error', 'Failed job not found.');
        }

        Artisan::call('queue:retry', [
            'id' => [(string) $failedJobId],
        ]);

        $audit->log('queue.failed_job_retried', "Retried failed queue job #{$failedJobId}.", metadata: [
            'failed_job_id' => $failedJobId,
            'queue' => $failedJob->queue,
            'connection' => $failedJob->connection,
            'display_name' => $this->displayNameFromPayload($failedJob->payload),
        ]);

        return back()->with('status', "Retried failed queue job #{$failedJobId}.");
    }

    private function displayNameFromPayload(string $payload): string
    {
        $decoded = json_decode($payload, true);

        if (! is_array($decoded)) {
            return 'Unknown job';
        }

        return $decoded['displayName']
            ?? $decoded['data']['commandName']
            ?? $decoded['job']
            ?? 'Unknown job';
    }

    private function exceptionExcerpt(string $exception): string
    {
        $lines = preg_split("/\r\n|\n|\r/", trim($exception)) ?: [];

        return $lines[0] ?? 'Unknown error';
    }
}
