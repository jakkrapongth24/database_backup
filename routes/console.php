<?php

use Illuminate\Foundation\Inspiring;
use App\Models\BackupTarget;
use App\Services\DatabaseBackupService;
use App\Services\BackupRetentionService;
use App\Services\BackupScheduleService;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Schema;
use App\Mail\DailyBackupSummaryMail;
use App\Services\AuditLogger;
use App\Services\BackupSummaryService;

Artisan::command('inspire', function () {
    $this->comment(Inspiring::quote());
})->purpose('Display an inspiring quote');

Artisan::command('personel:import-sql {path=bp_webapp.sql} {--fresh : Truncate personel before importing}', function (string $path): int {
    $fullPath = base_path($path);

    if (! is_file($fullPath)) {
        $this->error("SQL file not found: {$fullPath}");

        return 1;
    }

    if (! Schema::hasTable('personel')) {
        $this->error('Table personel does not exist. Please run php artisan migrate first.');

        return 1;
    }

    if ($this->option('fresh')) {
        DB::table('personel')->truncate();
    }

    $imported = 0;
    $file = new SplFileObject($fullPath);

    while (! $file->eof()) {
        $line = trim((string) $file->fgets());

        if (! str_starts_with($line, 'INSERT INTO `personel` VALUES')) {
            continue;
        }

        DB::unprepared($line);
        $imported++;
    }

    $this->info("Imported {$imported} personel records.");

    return 0;
})->purpose('Import only personel records from a SQL dump');

Artisan::command('personel:sync-remote {--fresh : Truncate local personel before syncing} {--chunk=200 : Number of records per batch}', function (): int {
    $sourceConnection = 'bp_webapp';
    $table = 'personel';
    $chunkSize = max(1, (int) $this->option('chunk'));

    try {
        DB::connection($sourceConnection)->getPdo();
    } catch (Throwable $exception) {
        $this->error('Cannot connect to bp_webapp database: '.$exception->getMessage());

        return 1;
    }

    if (! Schema::connection($sourceConnection)->hasTable($table)) {
        $this->error("Source table {$table} does not exist on bp_webapp connection.");

        return 1;
    }

    if (! Schema::hasTable($table)) {
        $this->error("Local table {$table} does not exist. Please run php artisan migrate first.");

        return 1;
    }

    $sourceColumns = Schema::connection($sourceConnection)->getColumnListing($table);
    $localColumns = Schema::getColumnListing($table);
    $columns = array_values(array_intersect($sourceColumns, $localColumns));

    if ($columns === []) {
        $this->error('No matching columns found between source and local personel tables.');

        return 1;
    }

    if ($this->option('fresh')) {
        DB::table($table)->truncate();
    }

    $synced = 0;
    $updateColumns = array_values(array_diff($columns, ['id']));

    DB::connection($sourceConnection)
        ->table($table)
        ->select($columns)
        ->orderBy('id')
        ->chunk($chunkSize, function ($rows) use ($table, $columns, $updateColumns, &$synced): void {
            $payload = $rows->map(fn ($row) => array_intersect_key((array) $row, array_flip($columns)))->all();

            if ($payload === []) {
                return;
            }

            DB::table($table)->upsert($payload, ['id'], $updateColumns);
            $synced += count($payload);
        });

    $this->info("Synced {$synced} personel records from bp_webapp.");

    return 0;
})->purpose('Sync personel records from the remote bp_webapp database');

Artisan::command('backup:run-scheduled {--target= : Run only one backup target id} {--dry-run : Show due targets without running backup}', function (
    BackupScheduleService $scheduleService,
    DatabaseBackupService $backupService,
): int {
    $target = null;

    if ($this->option('target')) {
        $target = BackupTarget::find((int) $this->option('target'));

        if (! $target) {
            $this->error('Backup target not found.');

            return 1;
        }
    }

    $dueTargets = $scheduleService->dueTargets($target);

    if ($dueTargets->isEmpty()) {
        $this->info('No backup targets are due.');

        return 0;
    }

    $this->table(
        ['ID', 'Name', 'Schedule', 'Endpoint'],
        $dueTargets->map(fn (BackupTarget $backupTarget): array => [
            $backupTarget->id,
            $backupTarget->name,
            $scheduleService->nextRunLabel($backupTarget),
            $backupTarget->endpoint,
        ])->all(),
    );

    if ($this->option('dry-run')) {
        $this->info('Dry run only. No backup was created.');

        return 0;
    }

    $failed = 0;
    $queued = 0;

    foreach ($dueTargets as $backupTarget) {
        $this->info("Queueing backup: {$backupTarget->name}");

        try {
            $job = $backupService->queue($backupTarget);
            $queued++;
            $this->info("Queued backup job #{$job->id} for {$backupTarget->name}");
        } catch (Throwable $exception) {
            $failed++;
            $this->error("Cannot queue backup for {$backupTarget->name}: {$exception->getMessage()}");
        }
    }

    if ($queued > 0) {
        $this->info("Queued {$queued} backup job(s).");
    }

    return $failed > 0 ? 1 : 0;
})->purpose('Run due database backups from target schedules');

Artisan::command('backup:cleanup {--target= : Cleanup only one backup target id} {--dry-run : Show files that would be removed}', function (
    BackupRetentionService $retentionService,
): int {
    $target = null;

    if ($this->option('target')) {
        $target = BackupTarget::find((int) $this->option('target'));

        if (! $target) {
            $this->error('Backup target not found.');

            return 1;
        }
    }

    $result = $retentionService->cleanup($target, (bool) $this->option('dry-run'));

    if ($result['items']->isEmpty()) {
        $this->info('No expired backup files found.');

        return 0;
    }

    $this->table(
        ['Target', 'Job ID', 'Finished At', 'File Exists', 'Size', 'Path'],
        $result['items']->map(fn (array $item): array => [
            $item['target'],
            $item['job_id'],
            $item['finished_at'],
            $item['file_exists'] ? 'yes' : 'no',
            number_format($item['file_size']).' B',
            $item['file_path'],
        ])->all(),
    );

    if ($this->option('dry-run')) {
        $this->info("Dry run only. {$result['checked']} expired records found.");

        return 0;
    }

    $this->info("Deleted {$result['deleted_files']} files and {$result['deleted_records']} records. Freed ".number_format($result['freed_bytes']).' bytes.');

    return 0;
})->purpose('Remove expired successful backup files by each target retention_days');

Artisan::command('backup:send-daily-summary {--date= : Summary date in YYYY-MM-DD format} {--dry-run : Build summary without sending email}', function (
    BackupSummaryService $summaryService,
    AuditLogger $audit,
): int {
    $summaryDate = $this->option('date')
        ? \Carbon\Carbon::parse((string) $this->option('date'))
        : now()->subDay();

    $periodStart = $summaryDate->copy()->startOfDay();
    $periodEnd = $summaryDate->copy()->endOfDay();
    $summary = $summaryService->build($periodStart, $periodEnd);

    $recipients = collect(preg_split('/[\r\n,;]+/', (string) (env('BACKUP_DAILY_SUMMARY_EMAILS') ?: env('BACKUP_ALERT_EMAILS'))) ?: [])
        ->map(fn (string $email): string => trim($email))
        ->filter()
        ->unique()
        ->values()
        ->all();

    $this->table('Summary', [
        ['Date', $periodStart->toDateString()],
        ['Total Jobs', (string) $summary['stats']['total']],
        ['Success', (string) $summary['stats']['success']],
        ['Failed', (string) $summary['stats']['failed']],
        ['Queued', (string) $summary['stats']['queued']],
        ['Running', (string) $summary['stats']['running']],
        ['Missing Scheduled Targets', (string) $summary['missing_targets']->count()],
        ['Failed Targets', (string) $summary['failed_targets']->count()],
        ['Recipients', $recipients === [] ? '-' : implode(', ', $recipients)],
    ]);

    if ($this->option('dry-run')) {
        $this->info('Dry run only. No email was sent.');

        return 0;
    }

    if ($recipients === []) {
        $this->warn('No recipients configured. Set BACKUP_DAILY_SUMMARY_EMAILS or BACKUP_ALERT_EMAILS.');

        return 0;
    }

    try {
        Mail::to($recipients)->send(new DailyBackupSummaryMail($summary));
        $audit->log('backup.daily_summary_sent', "Daily backup summary sent for {$periodStart->toDateString()}.", metadata: [
            'date' => $periodStart->toDateString(),
            'recipients' => $recipients,
            'failed_targets' => $summary['failed_targets']->count(),
            'missing_targets' => $summary['missing_targets']->count(),
            'stats' => $summary['stats'],
        ]);

        $this->info('Daily backup summary email sent.');

        return 0;
    } catch (Throwable $exception) {
        $audit->log('backup.daily_summary_failed', "Daily backup summary could not be sent for {$periodStart->toDateString()}.", metadata: [
            'date' => $periodStart->toDateString(),
            'recipients' => $recipients,
            'error' => $exception->getMessage(),
        ]);

        $this->error('Cannot send daily backup summary: '.$exception->getMessage());

        return 1;
    }
})->purpose('Send daily backup summary email to administrators');
