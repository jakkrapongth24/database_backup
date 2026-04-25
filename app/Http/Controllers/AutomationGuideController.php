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
            'dailySummaryCommand' => 'php artisan backup:send-daily-summary --dry-run',
            'restoreDrillCommand' => 'php artisan backup:restore-drill --dry-run',
            'restoreBinaryPath' => env('BACKUP_RESTORE_BINARY_PATH') ?: 'Auto detect from target dump path, mariadb.exe, or mysql.exe',
            'restoreDrillActualRestore' => filter_var(env('BACKUP_RESTORE_DRILL_ACTUAL_RESTORE', false), FILTER_VALIDATE_BOOLEAN) ? 'Enabled' : 'Disabled',
            'restoreDrillDatabase' => env('BACKUP_RESTORE_DRILL_DATABASE') ?: '{target_database}'.(env('BACKUP_RESTORE_DRILL_DATABASE_SUFFIX') ?: '_restore_drill'),
            'offsitePath' => env('BACKUP_OFFSITE_PATH') ?: 'Not configured. Offsite copy will be skipped.',
            'offsiteCopyCommand' => 'php artisan backup:copy-offsite --dry-run',
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
