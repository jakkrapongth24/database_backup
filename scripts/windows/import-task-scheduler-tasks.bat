@echo off
setlocal

set "ROOT=%~dp0\..\.."
set "SCRIPT=%ROOT%\scripts\windows\import-task-scheduler-tasks.ps1"

cd /d "%ROOT%"

title Import DB Backup Task Scheduler Tasks
echo Importing DB Backup Task Scheduler tasks...
echo Project: %cd%
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
 "Start-Process PowerShell -Verb RunAs -Wait -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""%SCRIPT%""'"

if errorlevel 1 (
    echo.
    echo Import failed.
    pause
    exit /b 1
)

echo.
echo Import completed successfully.
pause

endlocal
