<?php

namespace App\Http\Controllers;

use Illuminate\View\View;

class AutomationGuideController extends Controller
{
    public function __invoke(): View
    {
        return view('automation-guide', [
            'phpPath' => PHP_BINARY,
            'projectPath' => base_path(),
            'schedulerCommand' => 'artisan schedule:run',
            'queueWorkCommand' => 'php artisan queue:work --tries=1',
            'scheduleWorkCommand' => 'php artisan schedule:work',
            'scheduledBackupCommand' => 'php artisan backup:run-scheduled --dry-run',
            'cleanupCommand' => 'php artisan backup:cleanup --dry-run',
            'workerBatPath' => base_path('scripts/windows/start-worker.bat'),
            'schedulerBatPath' => base_path('scripts/windows/start-scheduler.bat'),
            'devBatPath' => base_path('scripts/windows/start-dev.bat'),
            'importTasksBatPath' => base_path('scripts/windows/import-task-scheduler-tasks.bat'),
            'schedulerXmlPath' => base_path('scripts/windows/task-scheduler/db-backup-scheduler.xml'),
            'workerXmlPath' => base_path('scripts/windows/task-scheduler/db-backup-queue-worker.xml'),
            'importTasksScriptPath' => base_path('scripts/windows/import-task-scheduler-tasks.ps1'),
        ]);
    }
}
