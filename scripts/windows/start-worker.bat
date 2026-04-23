@echo off
setlocal

cd /d "%~dp0\..\.."

title DB Backup Queue Worker
echo Starting Laravel queue worker...
echo Project: %cd%
echo.

php artisan queue:work --tries=1

endlocal
