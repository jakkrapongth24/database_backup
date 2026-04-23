<?php

namespace App\Jobs;

use App\Models\BackupJob;
use App\Services\DatabaseBackupService;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Foundation\Queue\Queueable;

class RunBackupJob implements ShouldQueue
{
    use Dispatchable, Queueable;

    public function __construct(public int $backupJobId)
    {
    }

    public function handle(DatabaseBackupService $backupService): void
    {
        $job = BackupJob::query()->with('target')->find($this->backupJobId);

        if (! $job || ! $job->target) {
            return;
        }

        $backupService->runQueuedJob($job);
    }
}
