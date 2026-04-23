<?php

namespace App\Services;

use App\Models\BackupJob;
use App\Models\BackupTarget;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\Schema;

class BackupScheduleService
{
    /**
     * @return Collection<int, BackupTarget>
     */
    public function dueTargets(?BackupTarget $target = null): Collection
    {
        if (! Schema::hasTable('backup_targets') || ! Schema::hasTable('backup_jobs')) {
            return collect();
        }

        return BackupTarget::query()
            ->where('is_active', true)
            ->where('schedule_frequency', '!=', 'manual')
            ->when($target, fn ($query) => $query->whereKey($target->id))
            ->get()
            ->filter(fn (BackupTarget $backupTarget): bool => $this->isDue($backupTarget))
            ->values();
    }

    public function isDue(BackupTarget $target): bool
    {
        if (! $target->is_active || $target->schedule_frequency === 'manual') {
            return false;
        }

        if (! $this->scheduleTimeReached($target)) {
            return false;
        }

        $hasRunningJob = BackupJob::query()
            ->where('backup_target_id', $target->id)
            ->where('status', 'running')
            ->exists();

        if ($hasRunningJob) {
            return false;
        }

        $lastSuccessfulJob = BackupJob::query()
            ->where('backup_target_id', $target->id)
            ->where('status', 'success')
            ->latest('started_at')
            ->first();

        if (! $lastSuccessfulJob?->started_at) {
            return true;
        }

        return match ($target->schedule_frequency) {
            'daily' => $lastSuccessfulJob->started_at->lt(now()->startOfDay()->setTimeFromTimeString($this->scheduleTime($target))),
            'weekly' => $lastSuccessfulJob->started_at->lte(now()->subWeek()),
            'monthly' => $lastSuccessfulJob->started_at->lte(now()->subMonthNoOverflow()),
            default => false,
        };
    }

    public function nextRunLabel(BackupTarget $target): string
    {
        if (! $target->is_active) {
            return 'Inactive';
        }

        if ($target->schedule_frequency === 'manual') {
            return 'Manual only';
        }

        return ucfirst($target->schedule_frequency).' at '.$this->scheduleTime($target);
    }

    private function scheduleTimeReached(BackupTarget $target): bool
    {
        return now()->format('H:i') >= $this->scheduleTime($target);
    }

    private function scheduleTime(BackupTarget $target): string
    {
        return substr((string) ($target->schedule_time ?: '00:00'), 0, 5);
    }
}
