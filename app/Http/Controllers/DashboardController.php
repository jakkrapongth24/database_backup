<?php

namespace App\Http\Controllers;

use App\Models\BackupTarget;
use App\Models\BackupJob;
use App\Services\BackupScheduleService;
use Illuminate\Support\Facades\Schema;
use Illuminate\View\View;

class DashboardController extends Controller
{
    public function __invoke(BackupScheduleService $scheduleService): View
    {
        $stats = [
            'targets' => 0,
            'activeTargets' => 0,
            'connectionOk' => 0,
            'connectionFailed' => 0,
            'successfulBackups' => 0,
            'failedBackups' => 0,
            'queuedBackups' => 0,
            'scheduledTargets' => 0,
            'dueTargets' => 0,
            'runningBackups' => 0,
        ];
        $dueTargets = collect();

        if (Schema::hasTable('backup_targets')) {
            $dueTargets = Schema::hasTable('backup_jobs') ? $scheduleService->dueTargets() : collect();

            $stats = [
                'targets' => BackupTarget::count(),
                'activeTargets' => BackupTarget::where('is_active', true)->count(),
                'connectionOk' => BackupTarget::where('last_connection_status', true)->count(),
                'connectionFailed' => BackupTarget::where('last_connection_status', false)->count(),
                'successfulBackups' => Schema::hasTable('backup_jobs') ? BackupJob::where('status', 'success')->count() : 0,
                'failedBackups' => Schema::hasTable('backup_jobs') ? BackupJob::where('status', 'failed')->count() : 0,
                'queuedBackups' => Schema::hasTable('backup_jobs') ? BackupJob::where('status', 'queued')->count() : 0,
                'scheduledTargets' => BackupTarget::where('is_active', true)->where('schedule_frequency', '!=', 'manual')->count(),
                'dueTargets' => $dueTargets->count(),
                'runningBackups' => Schema::hasTable('backup_jobs') ? BackupJob::where('status', 'running')->count() : 0,
            ];
        }

        return view('dashboard', compact('stats', 'dueTargets'));
    }
}
