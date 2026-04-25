<?php

namespace App\Services;

use App\Models\BackupJob;
use App\Models\BackupTarget;
use App\Models\RestoreDrill;
use Illuminate\Support\Facades\DB;
use RuntimeException;
use Symfony\Component\Process\Process;
use Throwable;

class RestoreDrillService
{
    /**
     * @param  array{actual_restore?:bool,test_database?:string|null,keep_database?:bool}  $options
     */
    public function runForTarget(BackupTarget $target, ?BackupJob $backupJob = null, ?int $userId = null, array $options = []): RestoreDrill
    {
        $startedAt = now();
        $backupJob ??= $this->latestRestorableBackup($target);

        $drill = RestoreDrill::create([
            'backup_target_id' => $target->id,
            'backup_job_id' => $backupJob?->id,
            'status' => 'running',
            'started_at' => $startedAt,
            'source_name' => $backupJob?->file_name,
            'source_path' => $backupJob?->file_path,
            'created_by' => $userId,
        ]);

        try {
            if (! $backupJob) {
                throw new RuntimeException('No successful backup job found for restore drill.');
            }

            $checks = $this->checks($target, $backupJob, $options);
            $failed = collect($checks)->firstWhere('status', 'failed');
            $finishedAt = now();

            $drill->update([
                'status' => $failed ? 'failed' : 'success',
                'finished_at' => $finishedAt,
                'duration_seconds' => $startedAt->diffInSeconds($finishedAt),
                'checks' => $checks,
                'error_message' => $failed['message'] ?? null,
            ]);

            app(AuditLogger::class)->log($failed ? 'restore_drill.failed' : 'restore_drill.completed', "Restore drill {$drill->status} for {$target->name}.", $drill, [
                'target' => $target->name,
                'backup_job_id' => $backupJob->id,
                'source_name' => $backupJob->file_name,
                'failed_check' => $failed['label'] ?? null,
            ], $userId);

            if ($failed) {
                app(BackupHealthAlertService::class)->send(
                    'Restore drill',
                    $target,
                    $failed['message'],
                    backupJob: $backupJob,
                    restoreDrill: $drill->refresh()->load(['target', 'backupJob']),
                    userId: $userId,
                );
            }
        } catch (Throwable $exception) {
            $finishedAt = now();

            $drill->update([
                'status' => 'failed',
                'finished_at' => $finishedAt,
                'duration_seconds' => $startedAt->diffInSeconds($finishedAt),
                'error_message' => $exception->getMessage(),
                'checks' => $drill->checks ?: [],
            ]);

            app(AuditLogger::class)->log('restore_drill.failed', "Restore drill failed for {$target->name}.", $drill, [
                'target' => $target->name,
                'backup_job_id' => $backupJob?->id,
                'error' => $exception->getMessage(),
            ], $userId);

            app(BackupHealthAlertService::class)->send(
                'Restore drill',
                $target,
                $exception->getMessage(),
                backupJob: $backupJob,
                restoreDrill: $drill->refresh()->load(['target', 'backupJob']),
                userId: $userId,
            );
        }

        return $drill->refresh();
    }

    public function latestRestorableBackup(BackupTarget $target): ?BackupJob
    {
        return BackupJob::query()
            ->where('backup_target_id', $target->id)
            ->where('status', 'success')
            ->latest('finished_at')
            ->latest('id')
            ->first();
    }

    /**
     * @return array<int, array{label: string, status: string, message: string}>
     */
    protected function checks(BackupTarget $target, BackupJob $backupJob, array $options = []): array
    {
        $checks = [
            $this->check('Backup job status', $backupJob->status === 'success', 'Backup job is successful.', 'Backup job is not successful.'),
            $this->check('Backup job target', $backupJob->backup_target_id === $target->id, 'Backup job belongs to target.', 'Backup job belongs to another target.'),
            $this->check('Backup verification', $backupJob->verification_status === 'passed', 'Backup verification passed.', 'Backup verification has not passed.'),
            $this->check('Backup file path', (bool) $backupJob->file_path, 'Backup file path is present.', 'Backup file path is empty.'),
        ];

        if (! $backupJob->file_path) {
            return $checks;
        }

        $checks[] = $this->check('Backup file exists', is_file($backupJob->file_path), 'Backup file exists.', 'Backup file does not exist.');
        $checks[] = $this->check('Backup file readable', is_readable($backupJob->file_path), 'Backup file is readable.', 'Backup file is not readable.');
        $checks[] = $this->check('Backup file not empty', is_file($backupJob->file_path) && filesize($backupJob->file_path) > 0, 'Backup file has content.', 'Backup file is empty.');

        if (str_ends_with(strtolower($backupJob->file_path), '.gz')) {
            $checks[] = $this->gzipCheck($backupJob->file_path);
        }

        if (collect($checks)->firstWhere('status', 'failed')) {
            return $checks;
        }

        $checks = [
            ...$checks,
            ...$this->actualRestoreChecks($target, $backupJob, $options),
        ];

        return $checks;
    }

    /**
     * @return array<int, array{label: string, status: string, message: string}>
     */
    protected function actualRestoreChecks(BackupTarget $target, BackupJob $backupJob, array $options = []): array
    {
        $actualRestore = array_key_exists('actual_restore', $options)
            ? (bool) $options['actual_restore']
            : filter_var(env('BACKUP_RESTORE_DRILL_ACTUAL_RESTORE', false), FILTER_VALIDATE_BOOLEAN);

        if (! $actualRestore) {
            return [
                $this->check('Restore จริงเข้า Test Database', true, 'ข้ามขั้นตอนนี้ เพราะยังไม่ได้เปิดโหมด Restore จริง สามารถเปิดได้จากหน้า Restore Drills หรือตั้ง BACKUP_RESTORE_DRILL_ACTUAL_RESTORE=true', ''),
            ];
        }

        try {
            $testDatabase = $this->resolveTestDatabaseName($target, $options['test_database'] ?? null);
            $sqlPath = $this->prepareSqlFile((string) $backupJob->file_path);

            try {
                $this->recreateTestDatabase($target, $testDatabase);
                $this->runRestoreCommand($target, $testDatabase, $sqlPath);
                $tableCount = $this->countTables($target, $testDatabase);
            } finally {
                if ($sqlPath !== $backupJob->file_path && is_file($sqlPath)) {
                    @unlink($sqlPath);
                }

                $keepDatabase = array_key_exists('keep_database', $options)
                    ? (bool) $options['keep_database']
                    : filter_var(env('BACKUP_RESTORE_DRILL_KEEP_DATABASE', false), FILTER_VALIDATE_BOOLEAN);

                if (! $keepDatabase) {
                    $this->dropTestDatabase($target, $testDatabase);
                }
            }

            return [
                $this->check('Restore จริงเข้า Test Database', true, "Restore เข้า {$testDatabase} สำเร็จ และพบ {$tableCount} ตาราง", ''),
            ];
        } catch (Throwable $exception) {
            return [
                $this->check('Restore จริงเข้า Test Database', false, '', $exception->getMessage()),
            ];
        }
    }

    /**
     * @return array{label: string, status: string, message: string}
     */
    private function gzipCheck(string $filePath): array
    {
        $gzip = @gzopen($filePath, 'rb');

        if ($gzip === false) {
            return $this->check('Gzip readable', false, '', 'Cannot open gzip backup file.');
        }

        try {
            $chunk = gzread($gzip, 1024);

            return $this->check('Gzip readable', $chunk !== false && $chunk !== '', 'Gzip backup file can be read.', 'Gzip backup file is empty or unreadable.');
        } finally {
            gzclose($gzip);
        }
    }

    /**
     * @return array{label: string, status: string, message: string}
     */
    private function check(string $label, bool $passed, string $successMessage, string $failureMessage): array
    {
        return [
            'label' => $label,
            'status' => $passed ? 'passed' : 'failed',
            'message' => $passed ? $successMessage : $failureMessage,
        ];
    }

    private function resolveTestDatabaseName(BackupTarget $target, ?string $requestedDatabase = null): string
    {
        $configuredName = trim((string) ($requestedDatabase ?: env('BACKUP_RESTORE_DRILL_DATABASE')));
        $suffix = trim((string) env('BACKUP_RESTORE_DRILL_DATABASE_SUFFIX', '_restore_drill'));
        $database = $configuredName !== ''
            ? str_replace('{database}', $target->database_name, $configuredName)
            : $target->database_name.$suffix;

        if ($database === '' || ! preg_match('/^[A-Za-z0-9_]+$/', $database)) {
            throw new RuntimeException('ชื่อ Test Database สำหรับ Restore Drill ใช้ได้เฉพาะตัวอักษรภาษาอังกฤษ ตัวเลข และ underscore (_)');
        }

        if (strtolower($database) === strtolower($target->database_name)) {
            throw new RuntimeException('ชื่อ Test Database สำหรับ Restore Drill ต้องไม่ตรงกับชื่อฐานข้อมูลจริง');
        }

        return $database;
    }

    private function prepareSqlFile(string $sourcePath): string
    {
        if (! str_ends_with(strtolower($sourcePath), '.gz')) {
            return $sourcePath;
        }

        $directory = storage_path('app/restore-drill-temp');

        if (! is_dir($directory) && ! mkdir($directory, 0775, true) && ! is_dir($directory)) {
            throw new RuntimeException("Cannot create restore drill temp directory: {$directory}");
        }

        $sqlPath = $directory.DIRECTORY_SEPARATOR.pathinfo($sourcePath, PATHINFO_FILENAME).'_'.uniqid().'.sql';
        $input = gzopen($sourcePath, 'rb');
        $output = fopen($sqlPath, 'wb');

        if ($input === false || $output === false) {
            if (is_resource($input)) {
                gzclose($input);
            }

            if (is_resource($output)) {
                fclose($output);
            }

            throw new RuntimeException('Cannot read compressed restore drill file.');
        }

        try {
            while (! gzeof($input)) {
                $chunk = gzread($input, 1024 * 1024);

                if ($chunk === false || fwrite($output, $chunk) === false) {
                    throw new RuntimeException('Cannot decompress restore drill file.');
                }
            }
        } finally {
            gzclose($input);
            fclose($output);
        }

        return $sqlPath;
    }

    private function recreateTestDatabase(BackupTarget $target, string $database): void
    {
        $connection = $this->connectionName($target, null, 'restore_drill_admin_');

        try {
            $this->configureConnection($connection, $target, null);
            DB::connection($connection)->statement('DROP DATABASE IF EXISTS '.$this->quoteIdentifier($database));
            DB::connection($connection)->statement('CREATE DATABASE '.$this->quoteIdentifier($database).' CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci');
        } finally {
            DB::disconnect($connection);
        }
    }

    private function dropTestDatabase(BackupTarget $target, string $database): void
    {
        $connection = $this->connectionName($target, null, 'restore_drill_admin_');

        try {
            $this->configureConnection($connection, $target, null);
            DB::connection($connection)->statement('DROP DATABASE IF EXISTS '.$this->quoteIdentifier($database));
        } finally {
            DB::disconnect($connection);
        }
    }

    private function countTables(BackupTarget $target, string $database): int
    {
        $connection = $this->connectionName($target, $database, 'restore_drill_check_');

        try {
            $this->configureConnection($connection, $target, $database);

            return count(DB::connection($connection)->select("SHOW FULL TABLES WHERE Table_type = 'BASE TABLE'"));
        } finally {
            DB::disconnect($connection);
        }
    }

    private function runRestoreCommand(BackupTarget $target, string $database, string $sqlPath): void
    {
        $env = $this->processEnvironment();

        if (($target->password ?? '') !== '') {
            $env['MYSQL_PWD'] = $target->password;
        }

        $errors = [];

        foreach ($this->buildRestoreCommands($target, $database) as $command) {
            $input = fopen($sqlPath, 'rb');

            if ($input === false) {
                throw new RuntimeException("Cannot open restore drill file: {$sqlPath}");
            }

            $process = new Process($command, null, $env);
            $process->setTimeout(null);
            $process->setInput($input);
            $process->run();

            fclose($input);

            if ($process->isSuccessful()) {
                return;
            }

            $errors[] = basename($command[0]).': '.(trim($process->getErrorOutput()) ?: 'Database restore drill failed.');
        }

        throw new RuntimeException(implode(PHP_EOL.PHP_EOL, array_unique($errors)));
    }

    /**
     * @return array<int, array<int, string>>
     */
    private function buildRestoreCommands(BackupTarget $target, string $database): array
    {
        $commands = [];
        $hosts = array_values(array_unique(array_filter([
            $this->normalizeHost($target->host),
            $target->host,
        ])));

        foreach ($this->resolveRestoreBinaries($target) as $binary) {
            foreach ($hosts as $host) {
                $commands[] = [
                    $binary,
                    '--protocol=TCP',
                    '--binary-mode',
                    '--host='.$host,
                    '--port='.(string) $target->port,
                    '--user='.$target->username,
                    $database,
                ];
            }
        }

        return $commands;
    }

    /**
     * @return array<int, string>
     */
    private function resolveRestoreBinaries(BackupTarget $target): array
    {
        $candidates = array_filter([
            env('BACKUP_RESTORE_BINARY_PATH'),
            $this->clientBinaryFromDumpBinary($target->dump_binary_path),
            $target->db_type === 'mariadb' ? 'C:\\wamp64\\bin\\mariadb\\mariadb11.4.9\\bin\\mariadb.exe' : null,
            $target->db_type === 'mysql' ? 'C:\\wamp64\\bin\\mysql\\mysql8.4.7\\bin\\mysql.exe' : null,
            'C:\\wamp64\\bin\\mariadb\\mariadb11.4.9\\bin\\mariadb.exe',
            'C:\\wamp64\\bin\\mysql\\mysql8.4.7\\bin\\mysql.exe',
            'mariadb',
            'mysql',
        ]);
        $binaries = [];

        foreach ($candidates as $candidate) {
            if (str_contains($candidate, DIRECTORY_SEPARATOR) || preg_match('/^[A-Za-z]:[\\\\\\/]/', $candidate) === 1) {
                if (is_file($candidate)) {
                    $binaries[] = $candidate;
                }

                continue;
            }

            $binaries[] = $candidate;
        }

        $binaries = array_values(array_unique($binaries));

        if ($binaries === []) {
            throw new RuntimeException('Restore binary not found. Please set BACKUP_RESTORE_BINARY_PATH.');
        }

        return $binaries;
    }

    private function configureConnection(string $connection, BackupTarget $target, ?string $database): void
    {
        config([
            "database.connections.{$connection}" => [
                'driver' => $target->db_type,
                'host' => $this->normalizeHost($target->host),
                'port' => $target->port,
                'database' => $database,
                'username' => $target->username,
                'password' => $target->password ?? '',
                'charset' => 'utf8mb4',
                'collation' => 'utf8mb4_unicode_ci',
                'prefix' => '',
                'strict' => false,
            ],
        ]);

        DB::purge($connection);
    }

    private function connectionName(BackupTarget $target, ?string $database, string $prefix): string
    {
        return $prefix.$target->id.'_'.md5((string) $database);
    }

    /**
     * @return array<string, string>
     */
    private function processEnvironment(): array
    {
        return collect(['SystemRoot', 'WINDIR', 'PATH', 'TEMP', 'TMP'])
            ->mapWithKeys(fn (string $key): array => getenv($key) !== false ? [$key => (string) getenv($key)] : [])
            ->all();
    }

    private function clientBinaryFromDumpBinary(?string $dumpBinary): ?string
    {
        if (! $dumpBinary) {
            return null;
        }

        $directory = dirname($dumpBinary);
        $basename = strtolower(basename($dumpBinary));

        if (str_contains($basename, 'mariadb-dump')) {
            return $directory.DIRECTORY_SEPARATOR.'mariadb.exe';
        }

        if (str_contains($basename, 'mysqldump')) {
            return $directory.DIRECTORY_SEPARATOR.'mysql.exe';
        }

        return null;
    }

    private function normalizeHost(string $host): string
    {
        return strtolower(trim($host)) === 'localhost' ? '127.0.0.1' : $host;
    }

    private function quoteIdentifier(string $identifier): string
    {
        return '`'.str_replace('`', '``', $identifier).'`';
    }
}
