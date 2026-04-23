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
            'scheduledBackupCommand' => 'php artisan backup:run-scheduled --dry-run',
            'cleanupCommand' => 'php artisan backup:cleanup --dry-run',
        ]);
    }
}
