@echo off
setlocal

cd /d "%~dp0\..\.."

title DB Backup Scheduler Worker
echo Starting Laravel scheduler worker...
echo Project: %cd%
echo.

php artisan schedule:work

endlocal
