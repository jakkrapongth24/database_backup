<?php

use Illuminate\Console\Scheduling\Schedule;
use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__.'/../routes/web.php',
        commands: __DIR__.'/../routes/console.php',
        health: '/up',
    )
    ->withSchedule(function (Schedule $schedule): void {
        $schedule->command('backup:run-scheduled')
            ->everyMinute()
            ->withoutOverlapping();

        $schedule->command('backup:cleanup')
            ->hourly()
            ->withoutOverlapping();

        $schedule->command('backup:send-daily-summary')
            ->dailyAt('07:00')
            ->withoutOverlapping();

        $schedule->command('backup:restore-drill')
            ->monthlyOn(1, '08:00')
            ->withoutOverlapping();
    })
    ->withMiddleware(function (Middleware $middleware): void {
        //
    })
    ->withExceptions(function (Exceptions $exceptions): void {
        //
    })->create();
