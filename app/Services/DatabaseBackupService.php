<?php

namespace App\Services;

use App\Jobs\RunBackupJob;
use App\Mail\BackupFailedMail;
use App\Models\BackupJob;
use App\Models\BackupTarget;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Mail;
use RuntimeException;
use Symfony\Component\Process\Process;
use Throwable;

class DatabaseBackupService
{
    public function queue(BackupTarget $target, ?int $userId = null): BackupJob
    {
        $job = BackupJob::create([
            'backup_target_id' => $target->id,
            'status' => 'queued',
            'created_by' => $userId,
        ]);

        app(AuditLogger::class)->log('backup.queued', "Backup queued for {$target->name}.", $job, [
            'target' => $target->name,
            'backup_job_id' => $job->id,
            'triggered_by_user_id' => $userId,
        ], $userId);

        RunBackupJob::dispatch($job->id);

        return $job->refresh();
    }

    public function run(BackupTarget $target, ?int $userId = null): BackupJob
    {
        $job = BackupJob::create([
            'backup_target_id' => $target->id,
            'status' => 'running',
            'started_at' => now(),
            'created_by' => $userId,
        ]);

        return $this->perform($job, $target, $userId);
    }

    public function runQueuedJob(BackupJob $job): BackupJob
    {
        $target = $job->target()->firstOrFail();
        $userId = $job->created_by;

        $job->update([
            'status' => 'running',
            'started_at' => now(),
            'error_message' => null,
        ]);

        return $this->perform($job->refresh(), $target, $userId);
    }

    private function perform(BackupJob $job, BackupTarget $target, ?int $userId = null): BackupJob
    {
        $startedAt = $job->started_at ?? now();

        if ($job->started_at === null) {
            $job->update(['started_at' => $startedAt]);
        }

        try {
            $dumpBinary = $this->resolveDumpBinary($target);
            $directory = $this->resolveBackupDirectory($target);
            $fileName = $this->buildFileName($target);
            $filePath = $directory.DIRECTORY_SEPARATOR.$fileName;

            $job->update([
                'file_name' => $fileName,
                'file_path' => $filePath,
                'dump_binary_path' => $dumpBinary,
            ]);

            try {
                $this->dumpToGzip($target, $dumpBinary, $filePath);
            } catch (Throwable $exception) {
                $fallbackBinary = $this->resolveMysqlFallbackBinary($dumpBinary, $exception);

                if ($fallbackBinary !== null) {
                    try {
                        $dumpBinary = $fallbackBinary;
                        $job->update(['dump_binary_path' => $dumpBinary]);
                        $this->dumpToGzip($target, $dumpBinary, $filePath);
                    } catch (Throwable) {
                        $dumpBinary = 'php-pdo-dump';
                        $job->update(['dump_binary_path' => $dumpBinary]);
                        $this->dumpWithPdoToGzip($target, $filePath);
                    }
                } else {
                    $dumpBinary = 'php-pdo-dump';
                    $job->update(['dump_binary_path' => $dumpBinary]);
                    $this->dumpWithPdoToGzip($target, $filePath);
                }
            }

            $finishedAt = now();
            $job->update([
                'status' => 'success',
                'finished_at' => $finishedAt,
                'duration_seconds' => $startedAt->diffInSeconds($finishedAt),
                'file_size' => is_file($filePath) ? filesize($filePath) : null,
                'error_message' => null,
            ]);

            app(AuditLogger::class)->log('backup.completed', "Backup completed for {$target->name}.", $job, [
                'target' => $target->name,
                'file_name' => $job->file_name,
                'file_size' => $job->file_size,
                'duration_seconds' => $job->duration_seconds,
                'triggered_by_user_id' => $userId,
            ], $userId);

            app(BackupRetentionService::class)->cleanup($target);
        } catch (Throwable $exception) {
            $finishedAt = now();
            $job->update([
                'status' => 'failed',
                'finished_at' => $finishedAt,
                'duration_seconds' => $startedAt->diffInSeconds($finishedAt),
                'error_message' => $exception->getMessage(),
            ]);

            app(AuditLogger::class)->log('backup.failed', "Backup failed for {$target->name}.", $job, [
                'target' => $target->name,
                'error' => $exception->getMessage(),
                'duration_seconds' => $job->duration_seconds,
                'triggered_by_user_id' => $userId,
            ], $userId);

            $this->sendFailureNotification($job->refresh()->load('target'));
        }

        return $job->refresh();
    }

    private function sendFailureNotification(BackupJob $job): void
    {
        $recipients = $this->resolveNotificationRecipients($job->target);

        if ($recipients === []) {
            return;
        }

        try {
            Mail::to($recipients)->send(new BackupFailedMail($job));

            app(AuditLogger::class)->log('backup.notification_sent', "Failure notification sent for {$job->target?->name}.", $job, [
                'backup_job_id' => $job->id,
                'recipients' => $recipients,
            ], $job->created_by);
        } catch (Throwable $exception) {
            app(AuditLogger::class)->log('backup.notification_failed', "Failure notification could not be sent for {$job->target?->name}.", $job, [
                'backup_job_id' => $job->id,
                'recipients' => $recipients,
                'error' => $exception->getMessage(),
            ], $job->created_by);
        }
    }

    /**
     * @return array<int, string>
     */
    private function resolveNotificationRecipients(?BackupTarget $target): array
    {
        $targetRecipients = $target?->notificationEmailList() ?? [];

        if ($targetRecipients !== []) {
            return $targetRecipients;
        }

        return collect(preg_split('/[\r\n,;]+/', (string) env('BACKUP_ALERT_EMAILS')) ?: [])
            ->map(fn (string $email): string => trim($email))
            ->filter()
            ->unique()
            ->values()
            ->all();
    }

    private function dumpToGzip(BackupTarget $target, string $dumpBinary, string $filePath): void
    {
        $env = [];

        if (($target->password ?? '') !== '') {
            $env['MYSQL_PWD'] = $target->password;
        }

        $errors = [];

        foreach ($this->buildDumpCommands($target, $dumpBinary) as $command) {
            if (is_file($filePath)) {
                @unlink($filePath);
            }

            $error = $this->runDumpCommand($command, $env, $filePath);

            if ($error === null) {
                return;
            }

            $errors[] = $error;
        }

        throw new RuntimeException(implode(PHP_EOL.PHP_EOL, array_unique($errors)));
    }

    /**
     * @param  array<int, string>  $command
     * @param  array<string, string>  $env
     */
    private function runDumpCommand(array $command, array $env, string $filePath): ?string
    {
        $sqlFilePath = preg_replace('/\.gz$/', '', $filePath) ?: $filePath.'.sql';
        $commandWithResultFile = [
            ...array_slice($command, 0, -1),
            '--result-file='.$sqlFilePath,
            ...array_slice($command, -1),
        ];

        if (is_file($sqlFilePath)) {
            @unlink($sqlFilePath);
        }

        $stderr = '';
        $process = new Process($commandWithResultFile, null, $env);
        $process->setTimeout(null);
        $process->run(function (string $type, string $buffer) use (&$stderr): void {
            if ($type !== Process::OUT) {
                $stderr .= $buffer;
            }
        });

        if (! $process->isSuccessful()) {
            if (is_file($sqlFilePath)) {
                @unlink($sqlFilePath);
            }

            return trim($stderr) ?: trim($process->getErrorOutput()) ?: 'Database dump failed.';
        }

        $gzip = gzopen($filePath, 'wb9');
        $source = fopen($sqlFilePath, 'rb');

        if ($gzip === false || $source === false) {
            if (is_resource($gzip)) {
                gzclose($gzip);
            }

            if (is_resource($source)) {
                fclose($source);
            }

            return "Cannot create backup file: {$filePath}";
        }

        try {
            while (! feof($source)) {
                gzwrite($gzip, fread($source, 1024 * 1024) ?: '');
            }
        } finally {
            fclose($source);
            gzclose($gzip);
            @unlink($sqlFilePath);
        }

        return null;
    }

    /**
     * @return array<int, array<int, string>>
     */
    private function buildDumpCommands(BackupTarget $target, string $dumpBinary): array
    {
        $hosts = array_values(array_unique(array_filter([
            $this->normalizeHost($target->host),
            $target->host,
            'localhost',
            '127.0.0.1',
        ])));

        $commands = [];

        foreach ($hosts as $host) {
            $base = [
                $dumpBinary,
                '--host='.$host,
                '--port='.(string) $target->port,
                '--user='.$target->username,
            ];

            $commands[] = [
                ...$base,
                '--single-transaction',
                '--quick',
                '--routines',
                '--triggers',
                '--events',
                $target->database_name,
            ];

            $commands[] = [
                ...$base,
                $target->database_name,
            ];
        }

        return $commands;
    }

    private function resolveDumpBinary(BackupTarget $target): string
    {
        if ($target->dump_binary_path && is_file($target->dump_binary_path)) {
            return $target->dump_binary_path;
        }

        $candidates = $target->db_type === 'mariadb'
            ? [
                env('BACKUP_MARIADB_DUMP_BINARY_PATH'),
                'C:\\wamp64\\bin\\mariadb\\mariadb11.4.9\\bin\\mariadb-dump.exe',
                env('BACKUP_DUMP_BINARY_PATH'),
            ]
            : [
                env('BACKUP_MYSQL_DUMP_BINARY_PATH'),
                'C:\\wamp64\\bin\\mysql\\mysql8.4.7\\bin\\mysqldump.exe',
                env('BACKUP_DUMP_BINARY_PATH'),
            ];

        $candidates = array_filter($candidates);

        foreach ($candidates as $candidate) {
            if (is_file($candidate)) {
                return $candidate;
            }
        }

        throw new RuntimeException('Dump binary not found. Please set Path mysqldump/mariadb-dump or BACKUP_DUMP_BINARY_PATH.');
    }

    private function resolveMysqlFallbackBinary(string $currentBinary, Throwable $exception): ?string
    {
        if (str_contains(strtolower(basename($currentBinary)), 'mariadb-dump')) {
            return null;
        }

        if (! str_contains(strtolower(basename($currentBinary)), 'mariadb-dump')
            && ! str_contains($exception->getMessage(), 'caching_sha2_password')) {
            return null;
        }

        $mysqlDump = 'C:\\wamp64\\bin\\mysql\\mysql8.4.7\\bin\\mysqldump.exe';

        if (realpath($currentBinary) === realpath($mysqlDump) || ! is_file($mysqlDump)) {
            return null;
        }

        return $mysqlDump;
    }

    private function resolveBackupDirectory(BackupTarget $target): string
    {
        $path = $target->backup_path ?: env('BACKUP_DEFAULT_PATH', 'storage/app/backups');
        $directory = $this->isAbsolutePath($path) ? $path : base_path($path);

        if (! is_dir($directory) && ! mkdir($directory, 0775, true) && ! is_dir($directory)) {
            throw new RuntimeException("Cannot create backup directory: {$directory}");
        }

        return rtrim($directory, "\\/");
    }

    private function buildFileName(BackupTarget $target): string
    {
        $safeName = preg_replace('/[^A-Za-z0-9_-]+/', '_', $target->name) ?: 'backup';
        $database = preg_replace('/[^A-Za-z0-9_-]+/', '_', $target->database_name) ?: 'database';

        return "{$safeName}_{$database}_".now()->format('Ymd_His').'.sql.gz';
    }

    private function isAbsolutePath(string $path): bool
    {
        return preg_match('/^[A-Za-z]:[\\\\\\/]/', $path) === 1 || str_starts_with($path, '/') || str_starts_with($path, '\\\\');
    }

    private function normalizeHost(string $host): string
    {
        return strtolower(trim($host)) === 'localhost' ? '127.0.0.1' : $host;
    }

    private function dumpWithPdoToGzip(BackupTarget $target, string $filePath): void
    {
        if (is_file($filePath)) {
            @unlink($filePath);
        }

        $connection = 'backup_pdo_dump_'.$target->id;

        config([
            "database.connections.{$connection}" => [
                'driver' => $target->db_type,
                'host' => $this->normalizeHost($target->host),
                'port' => $target->port,
                'database' => $target->database_name,
                'username' => $target->username,
                'password' => $target->password ?? '',
                'charset' => 'utf8mb4',
                'collation' => 'utf8mb4_unicode_ci',
                'prefix' => '',
                'strict' => false,
            ],
        ]);

        DB::purge($connection);
        $pdo = DB::connection($connection)->getPdo();
        $gzip = gzopen($filePath, 'wb9');

        if ($gzip === false) {
            throw new RuntimeException("Cannot create backup file: {$filePath}");
        }

        try {
            $this->gzwrite($gzip, "-- PHP PDO dump\n");
            $this->gzwrite($gzip, "-- Database: {$target->database_name}\n");
            $this->gzwrite($gzip, "-- Created at: ".now()->format('Y-m-d H:i:s')."\n\n");
            $this->gzwrite($gzip, "SET FOREIGN_KEY_CHECKS=0;\n\n");

            $tables = $pdo->query("SHOW FULL TABLES WHERE Table_type = 'BASE TABLE'")->fetchAll(\PDO::FETCH_NUM);

            foreach ($tables as $tableRow) {
                $table = (string) $tableRow[0];
                $quotedTable = $this->quoteIdentifier($table);
                $create = $pdo->query("SHOW CREATE TABLE {$quotedTable}")->fetch(\PDO::FETCH_ASSOC);
                $createSql = (string) array_values($create)[1];

                $this->gzwrite($gzip, "DROP TABLE IF EXISTS {$quotedTable};\n");
                $this->gzwrite($gzip, $createSql.";\n\n");

                $rows = $pdo->query("SELECT * FROM {$quotedTable}");
                $batch = [];
                $columns = null;

                while ($row = $rows->fetch(\PDO::FETCH_ASSOC)) {
                    if ($columns === null) {
                        $columns = array_map(fn (string $column): string => $this->quoteIdentifier($column), array_keys($row));
                    }

                    $batch[] = '('.implode(', ', array_map(
                        fn ($value): string => $value === null ? 'NULL' : $pdo->quote((string) $value),
                        array_values($row),
                    )).')';

                    if (count($batch) >= 100) {
                        $this->writeInsertBatch($gzip, $quotedTable, $columns, $batch);
                        $batch = [];
                    }
                }

                if ($batch !== [] && $columns !== null) {
                    $this->writeInsertBatch($gzip, $quotedTable, $columns, $batch);
                }

                $this->gzwrite($gzip, "\n");
            }

            $this->gzwrite($gzip, "SET FOREIGN_KEY_CHECKS=1;\n");
        } finally {
            gzclose($gzip);
            DB::disconnect($connection);
        }
    }

    /**
     * @param  resource  $gzip
     * @param  array<int, string>  $columns
     * @param  array<int, string>  $batch
     */
    private function writeInsertBatch($gzip, string $table, array $columns, array $batch): void
    {
        $this->gzwrite($gzip, 'INSERT INTO '.$table.' ('.implode(', ', $columns).') VALUES'."\n");
        $this->gzwrite($gzip, implode(",\n", $batch).";\n");
    }

    /**
     * @param  resource  $gzip
     */
    private function gzwrite($gzip, string $content): void
    {
        if (gzwrite($gzip, $content) === false) {
            throw new RuntimeException('Cannot write to gzip backup file.');
        }
    }

    private function quoteIdentifier(string $identifier): string
    {
        return '`'.str_replace('`', '``', $identifier).'`';
    }
}
