<?php

use Illuminate\Foundation\Inspiring;
use App\Models\BackupTarget;
use App\Services\DatabaseBackupService;
use App\Services\BackupRetentionService;
use App\Services\BackupScheduleService;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\DB;
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

    foreach ($dueTargets as $backupTarget) {
        $this->info("Running backup: {$backupTarget->name}");

        $job = $backupService->run($backupTarget);

        if ($job->status === 'success') {
            $this->info("Backup success: {$job->file_name}");
        } else {
            $failed++;
            $this->error("Backup failed: {$job->error_message}");
        }
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
