Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$currentIdentity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal($currentIdentity)
$isAdministrator = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdministrator) {
    throw 'This script must be run as Administrator.'
}

$projectRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path
$taskDirectory = Join-Path $projectRoot 'scripts\windows\task-scheduler'

$tasks = @(
    @{
        Name = 'DB Backup Scheduler'
        XmlPath = Join-Path $taskDirectory 'db-backup-scheduler.xml'
    },
    @{
        Name = 'DB Backup Queue Worker'
        XmlPath = Join-Path $taskDirectory 'db-backup-queue-worker.xml'
    }
)

foreach ($task in $tasks) {
    if (-not (Test-Path -LiteralPath $task.XmlPath)) {
        throw "XML file not found: $($task.XmlPath)"
    }
}

$service = New-Object -ComObject 'Schedule.Service'
$service.Connect()
$rootFolder = $service.GetFolder('\')

foreach ($task in $tasks) {
    try {
        $null = $rootFolder.GetTask($task.Name)
        Write-Host "Removing existing task: $($task.Name)" -ForegroundColor Yellow
        $rootFolder.DeleteTask($task.Name, 0)
    } catch {
        Write-Host "Task not found, creating new: $($task.Name)" -ForegroundColor DarkGray
    }

    $xml = Get-Content -LiteralPath $task.XmlPath -Raw
    $rootFolder.RegisterTask($task.Name, $xml, 6, $null, $null, 3, $null) | Out-Null
    Write-Host "Imported task: $($task.Name)" -ForegroundColor Green
}

Write-Host ''
Write-Host 'Done.' -ForegroundColor Cyan
Write-Host 'Open Task Scheduler to review triggers and credentials if needed.' -ForegroundColor Cyan
