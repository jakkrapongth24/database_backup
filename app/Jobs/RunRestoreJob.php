<?php

namespace App\Jobs;

use App\Models\RestoreJob;
use App\Services\DatabaseRestoreService;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Foundation\Queue\Queueable;

class RunRestoreJob implements ShouldQueue
{
    use Dispatchable, Queueable;

    public function __construct(public int $restoreJobId) {}

    public function handle(DatabaseRestoreService $restoreService): void
    {
        $job = RestoreJob::query()->with(['target', 'backupJob'])->find($this->restoreJobId);

        if (! $job || ! $job->target) {
            return;
        }

        $restoreService->runQueuedJob($job);
    }
}
