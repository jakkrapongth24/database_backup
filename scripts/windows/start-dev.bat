@echo off
setlocal

set "ROOT=%~dp0\..\.."
cd /d "%ROOT%"

echo Launching DB Backup development tools...
echo Project: %cd%

start "DB Backup Server" cmd /k "cd /d \"%ROOT%\" && php artisan serve --host=127.0.0.1 --port=8081"
start "DB Backup Queue Worker" cmd /k "cd /d \"%ROOT%\" && php artisan queue:work --tries=1"
start "DB Backup Vite" cmd /k "cd /d \"%ROOT%\" && npm run dev"

endlocal
