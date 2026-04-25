<?php

use App\Mail\DailyBackupSummaryMail;
use App\Models\BackupJob;
use App\Models\BackupTarget;
use App\Services\AuditLogger;
use App\Services\BackupOffsiteCopyService;
use App\Services\BackupRetentionService;
use App\Services\BackupScheduleService;
use App\Services\BackupSummaryService;
use App\Services\BackupVerificationService;
use App\Services\DatabaseBackupService;
use App\Services\RestoreDrillService;
use Carbon\Carbon;
use Illuminate\Foundation\Inspiring;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Schema;

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
        ['Target', 'Job ID', 'Finished At', 'Local File', 'Offsite File', 'Total Size', 'Path'],
        $result['items']->map(fn (array $item): array => [
            $item['target'],
            $item['job_id'],
            $item['finished_at'],
            $item['file_exists'] ? 'yes' : 'no',
            $item['offsite_file_exists'] ? 'yes' : 'no',
            number_format($item['file_size'] + $item['offsite_file_size']).' B',
            $item['file_path'],
        ])->all(),
    );

    if ($this->option('dry-run')) {
        $this->info("Dry run only. {$result['checked']} expired records found.");

        return 0;
    }

    $this->info("Deleted {$result['deleted_files']} local files, {$result['deleted_offsite_files']} offsite files, and {$result['deleted_records']} records. Freed ".number_format($result['freed_bytes']).' bytes.');

    return 0;
})->purpose('Remove expired successful backup files by each target retention_days');

Artisan::command('backup:verify {--target= : Verify successful backups for one target id} {--job= : Verify one backup job id} {--dry-run : Show backups that would be verified}', function (
    BackupVerificationService $verificationService,
): int {
    $query = BackupJob::query()
        ->with('target')
        ->where('status', 'success');

    if ($this->option('job')) {
        $query->whereKey((int) $this->option('job'));
    }

    if ($this->option('target')) {
        $query->where('backup_target_id', (int) $this->option('target'));
    }

    $jobs = $query->latest('finished_at')->get();

    if ($jobs->isEmpty()) {
        $this->info('No successful backup jobs found to verify.');

        return 0;
    }

    $this->table(
        ['Job ID', 'Target', 'File', 'Current Verification'],
        $jobs->map(fn (BackupJob $job): array => [
            $job->id,
            $job->target?->name ?? 'Deleted target',
            $job->file_name ?? basename((string) $job->file_path),
            $job->verification_status ?? 'not checked',
        ])->all(),
    );

    if ($this->option('dry-run')) {
        $this->info('Dry run only. No backup file was verified.');

        return 0;
    }

    $failed = 0;

    foreach ($jobs as $job) {
        try {
            $verificationService->verify($job);
            $this->info("Verified backup job #{$job->id}");
        } catch (Throwable $exception) {
            $failed++;
            $this->error("Backup job #{$job->id} verification failed: {$exception->getMessage()}");
        }
    }

    return $failed > 0 ? 1 : 0;
})->purpose('Verify successful backup files can be read and opened');

Artisan::command('backup:copy-offsite {--target= : Copy verified backups for one target id} {--job= : Copy one backup job id} {--dry-run : Show backups that would be copied}', function (
    BackupOffsiteCopyService $offsiteCopyService,
): int {
    $query = BackupJob::query()
        ->with('target')
        ->where('status', 'success')
        ->where('verification_status', 'passed');

    if ($this->option('job')) {
        $query->whereKey((int) $this->option('job'));
    }

    if ($this->option('target')) {
        $query->where('backup_target_id', (int) $this->option('target'));
    }

    $jobs = $query->latest('finished_at')->get();

    if ($jobs->isEmpty()) {
        $this->info('No verified backup jobs found to copy offsite.');

        return 0;
    }

    $this->table(
        ['Job ID', 'Target', 'File', 'Current Offsite'],
        $jobs->map(fn (BackupJob $job): array => [
            $job->id,
            $job->target?->name ?? 'Deleted target',
            $job->file_name ?? basename((string) $job->file_path),
            $job->offsite_status ?? 'not copied',
        ])->all(),
    );

    if ($this->option('dry-run')) {
        $this->info('Dry run only. No backup file was copied offsite.');

        return 0;
    }

    $failed = 0;

    foreach ($jobs as $job) {
        try {
            $offsiteCopyService->copy($job);
            $this->info("Copied backup job #{$job->id} offsite");
        } catch (Throwable $exception) {
            $failed++;
            $this->error("Backup job #{$job->id} offsite copy failed: {$exception->getMessage()}");
        }
    }

    return $failed > 0 ? 1 : 0;
})->purpose('Copy verified backup files to configured offsite storage');

Artisan::command('backup:restore-drill {--target= : Run drill for one target id} {--job= : Run drill for one backup job id} {--actual-restore : Restore backup into a separate test database during the drill} {--test-database= : Test database name or pattern} {--keep-test-database : Keep the test database after the drill} {--dry-run : Show selected targets without creating drill records}', function (
    RestoreDrillService $restoreDrillService,
): int {
    $target = null;
    $job = null;

    if ($this->option('job')) {
        $job = BackupJob::query()->with('target')->find((int) $this->option('job'));

        if (! $job || ! $job->target) {
            $this->error('Backup job not found.');

            return 1;
        }

        $target = $job->target;
    }

    if ($this->option('target')) {
        $target = BackupTarget::find((int) $this->option('target'));

        if (! $target) {
            $this->error('Backup target not found.');

            return 1;
        }
    }

    $targets = $target
        ? collect([$target])
        : BackupTarget::query()->where('is_active', true)->orderBy('name')->get();

    if ($targets->isEmpty()) {
        $this->info('No active backup targets found.');

        return 0;
    }

    $this->table(
        ['Target ID', 'Target', 'Selected Backup'],
        $targets->map(function (BackupTarget $backupTarget) use ($restoreDrillService, $job): array {
            $selectedJob = $job && $job->backup_target_id === $backupTarget->id
                ? $job
                : $restoreDrillService->latestRestorableBackup($backupTarget);

            return [
                $backupTarget->id,
                $backupTarget->name,
                $selectedJob ? "#{$selectedJob->id} {$selectedJob->file_name}" : 'No successful backup',
            ];
        })->all(),
    );

    if ($this->option('dry-run')) {
        $this->info('Dry run only. No restore drill record was created.');

        return 0;
    }

    $failed = 0;
    $options = [];

    if ($this->option('actual-restore')) {
        $options['actual_restore'] = true;
    }

    if ($this->option('test-database')) {
        $options['test_database'] = (string) $this->option('test-database');
    }

    if ($this->option('keep-test-database')) {
        $options['keep_database'] = true;
    }

    foreach ($targets as $backupTarget) {
        $selectedJob = $job && $job->backup_target_id === $backupTarget->id
            ? $job
            : null;
        $drill = $restoreDrillService->runForTarget($backupTarget, $selectedJob, options: $options);

        if ($drill->status === 'success') {
            $this->info("Restore drill #{$drill->id} passed for {$backupTarget->name}");
        } else {
            $failed++;
            $this->error("Restore drill #{$drill->id} failed for {$backupTarget->name}: {$drill->error_message}");
        }
    }

    return $failed > 0 ? 1 : 0;
})->purpose('Run restore drill readiness checks against latest successful backups');

Artisan::command('backup:send-daily-summary {--date= : Summary date in YYYY-MM-DD format} {--dry-run : Build summary without sending email}', function (
    BackupSummaryService $summaryService,
    AuditLogger $audit,
): int {
    $summaryDate = $this->option('date')
        ? Carbon::parse((string) $this->option('date'))
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
