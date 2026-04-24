<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\AuditLogController;
use App\Http\Controllers\AutomationGuideController;
use App\Http\Controllers\BackupJobController;
use App\Http\Controllers\BackupTargetController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\QueueMonitorController;
use App\Http\Controllers\ReportController;
use Illuminate\Support\Facades\Route;

Route::middleware('guest')->group(function () {
    Route::get('/', [AuthController::class, 'showLogin'])->name('login');
    Route::get('/login', [AuthController::class, 'showLogin']);
    Route::post('/login', [AuthController::class, 'login'])->name('login.store');
});

Route::middleware('auth')->group(function () {
    Route::get('/dashboard', DashboardController::class)->name('dashboard');
    Route::resource('backup-targets', BackupTargetController::class);
    Route::post('/backup-targets/{backup_target}/test-connection', [BackupTargetController::class, 'testConnection'])
        ->name('backup-targets.test-connection');
    Route::post('/backup-targets/{backup_target}/backup-now', [BackupJobController::class, 'run'])
        ->name('backup-targets.backup-now');
    Route::get('/backup-history', [BackupJobController::class, 'index'])->name('backup-jobs.index');
    Route::get('/backup-history/{backup_job}/download', [BackupJobController::class, 'download'])
        ->name('backup-jobs.download');
    Route::get('/queue-monitor', QueueMonitorController::class)->name('queue-monitor.index');
    Route::post('/queue-monitor/failed-jobs/{failedJobId}/retry', [QueueMonitorController::class, 'retryFailedJob'])
        ->name('queue-monitor.retry');
    Route::get('/reports', ReportController::class)->name('reports.index');
    Route::get('/reports/export/csv', [ReportController::class, 'exportCsv'])->name('reports.export.csv');
    Route::get('/reports/export/excel', [ReportController::class, 'exportExcel'])->name('reports.export.excel');
    Route::get('/reports/export/pdf', [ReportController::class, 'exportPdf'])->name('reports.export.pdf');
    Route::get('/audit-logs', [AuditLogController::class, 'index'])->name('audit-logs.index');
    Route::get('/automation-guide', AutomationGuideController::class)->name('automation-guide');
    Route::post('/logout', [AuthController::class, 'logout'])->name('logout');
});
