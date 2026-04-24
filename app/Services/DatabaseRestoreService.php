<?php

namespace App\Services;

use App\Jobs\RunRestoreJob;
use App\Models\BackupJob;
use App\Models\BackupTarget;
use App\Models\RestoreJob;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use RuntimeException;
use Symfony\Component\Process\Process;
use Throwable;

class DatabaseRestoreService
{
    /**
     * @return array<int, array{label: string, status: string, message: string}>
     */
    public function precheckBackupJob(BackupTarget $target, BackupJob $backupJob, bool $createSafetyBackup = true): array
    {
        $checks = $this->precheckTarget($target, $createSafetyBackup);

        $checks[] = $this->check('Backup job status', $backupJob->status === 'success', 'Backup job is successful.', 'Backup job must be successful before restore.');
        $checks[] = $this->check('Backup job target', $backupJob->backup_target_id === $target->id, 'Backup job belongs to this target.', 'Selected backup job does not belong to this target.');

        if ($backupJob->file_path && is_file($backupJob->file_path)) {
            $checks[] = $this->check('Restore file exists', true, 'Backup file exists: '.$backupJob->file_path, '');
            $checks[] = $this->check('Restore file path', $this->isPathAllowed($backupJob->file_path, $backupJob->target ?: $target), 'Backup file is inside an allowed backup directory.', 'Backup file path is outside the allowed backup directory.');
            $checks = [...$checks, ...$this->precheckSqlFile($backupJob->file_path)];
        } else {
            $checks[] = $this->check('Restore file exists', false, '', 'Backup file was not found on this server.');
        }

        return $checks;
    }

    /**
     * @return array<int, array{label: string, status: string, message: string}>
     */
    public function precheckUpload(BackupTarget $target, UploadedFile $upload, bool $createSafetyBackup = true): array
    {
        $checks = $this->precheckTarget($target, $createSafetyBackup);
        $extension = strtolower($upload->getClientOriginalExtension());

        $checks[] = $this->check('Upload extension', in_array($extension, ['sql', 'gz'], true), 'Upload extension is allowed.', 'Restore file must be a .sql or .sql.gz file.');
        $checks[] = $this->check('Upload readable', $upload->isValid() && is_file($upload->getPathname()), 'Uploaded file is readable.', 'Uploaded file is not readable.');

        if ($upload->isValid() && is_file($upload->getPathname())) {
            $checks = [...$checks, ...$this->precheckSqlFile($upload->getPathname(), $upload->getClientOriginalName())];
        }

        return $checks;
    }

    public function queueFromBackupJob(BackupTarget $target, BackupJob $backupJob, bool $createSafetyBackup = true): RestoreJob
    {
        $backupJob->loadMissing('target');

        if ($backupJob->status !== 'success') {
            throw new RuntimeException('Only successful backup jobs can be restored.');
        }

        if (! $backupJob->file_path || ! is_file($backupJob->file_path)) {
            throw new RuntimeException('Backup file was not found on this server.');
        }

        if (! $this->isPathAllowed($backupJob->file_path, $backupJob->target ?: $target)) {
            throw new RuntimeException('Backup file path is outside the allowed backup directory.');
        }

        return $this->queue($target, $backupJob->file_path, $backupJob->file_name ?: 'Backup job #'.$backupJob->id, 'backup_job', $backupJob, $createSafetyBackup);
    }

    public function queueFromUpload(BackupTarget $target, UploadedFile $upload, bool $createSafetyBackup = true): RestoreJob
    {
        $extension = strtolower($upload->getClientOriginalExtension());

        if (! in_array($extension, ['sql', 'gz'], true)) {
            throw new RuntimeException('Restore file must be a .sql or .sql.gz file.');
        }

        $directory = storage_path('app/restore-uploads');

        if (! is_dir($directory) && ! mkdir($directory, 0775, true) && ! is_dir($directory)) {
            throw new RuntimeException("Cannot create restore upload directory: {$directory}");
        }

        $safeName = preg_replace('/[^A-Za-z0-9_.-]+/', '_', $upload->getClientOriginalName()) ?: 'restore.sql';
        $fileName = now()->format('Ymd_His').'_'.uniqid().'_'.$safeName;
        $path = $upload->move($directory, $fileName)->getPathname();

        return $this->queue($target, $path, $safeName, 'upload', null, $createSafetyBackup);
    }

    public function runQueuedJob(RestoreJob $restoreJob): RestoreJob
    {
        if (! in_array($restoreJob->status, ['queued', 'running'], true)) {
            return $restoreJob->refresh();
        }

        $target = $restoreJob->target()->firstOrFail();
        $backupJob = $restoreJob->backupJob()->first();

        $restoreJob->update([
            'status' => 'running',
            'current_step' => 'preparing',
            'progress_percent' => 5,
            'progress_message' => 'Preparing restore job.',
            'started_at' => now(),
            'finished_at' => null,
            'duration_seconds' => null,
            'error_message' => null,
        ]);

        return $this->perform($restoreJob->refresh(), $target, $backupJob);
    }

    private function queue(
        BackupTarget $target,
        string $sourcePath,
        string $sourceName,
        string $sourceType,
        ?BackupJob $sourceBackupJob,
        bool $createSafetyBackup,
    ): RestoreJob {
        $restoreJob = RestoreJob::create([
            'backup_target_id' => $target->id,
            'backup_job_id' => $sourceBackupJob?->id,
            'source_type' => $sourceType,
            'status' => 'queued',
            'current_step' => 'queued',
            'progress_percent' => 0,
            'progress_message' => 'Waiting for queue worker.',
            'source_name' => $sourceName,
            'source_path' => $sourcePath,
            'create_safety_backup' => $createSafetyBackup,
            'created_by' => Auth::id(),
        ]);

        app(AuditLogger::class)->log('restore.queued', "Restore queued for {$target->name}.", $target, [
            'target' => $target->name,
            'database_name' => $target->database_name,
            'source' => $sourceName,
            'source_path' => $sourcePath,
            'restore_job_id' => $restoreJob->id,
            'create_safety_backup' => $createSafetyBackup,
        ]);

        RunRestoreJob::dispatch($restoreJob->id);

        return $restoreJob->refresh();
    }

    private function perform(RestoreJob $restoreJob, BackupTarget $target, ?BackupJob $sourceBackupJob): RestoreJob
    {
        $startedAt = $restoreJob->started_at ?? now();
        $safetyBackupJob = null;

        try {
            $this->markProgress($restoreJob, 'resolving_client', 10, 'Resolving restore client.');

            $restoreJob->update([
                'restore_binary_path' => implode(PHP_EOL, $this->resolveRestoreBinaries($target)),
            ]);

            if ($restoreJob->create_safety_backup) {
                $this->markProgress($restoreJob, 'safety_backup', 20, 'Creating safety backup before restore.');
                $safetyBackupJob = app(DatabaseBackupService::class)->run($target, $restoreJob->created_by);
                $restoreJob->update(['safety_backup_job_id' => $safetyBackupJob->id]);

                if ($safetyBackupJob->status !== 'success') {
                    throw new RuntimeException('Safety backup failed before restore: '.($safetyBackupJob->error_message ?: 'Unknown error'));
                }
            }

            $this->markProgress($restoreJob, 'validating_source', 40, 'Validating restore source file.');

            if (! $restoreJob->source_path || ! is_file($restoreJob->source_path)) {
                throw new RuntimeException('Restore file was not found on this server.');
            }

            if ($restoreJob->source_type === 'backup_job' && (! $sourceBackupJob || ! $this->isPathAllowed($restoreJob->source_path, $sourceBackupJob->target ?: $target))) {
                throw new RuntimeException('Backup file path is outside the allowed backup directory.');
            }

            $this->markProgress($restoreJob, 'preparing_sql', 55, 'Preparing SQL file for restore.');
            $sqlPath = $this->prepareSqlFile($restoreJob->source_path);

            try {
                $this->markProgress($restoreJob, 'restoring', 75, 'Running database restore command.');
                $this->runRestoreCommand($target, $sqlPath);
            } finally {
                if ($sqlPath !== $restoreJob->source_path && is_file($sqlPath)) {
                    @unlink($sqlPath);
                }
            }

            app(AuditLogger::class)->log('restore.completed', "Restore completed for {$target->name}.", $target, [
                'target' => $target->name,
                'database_name' => $target->database_name,
                'source' => $restoreJob->source_name,
                'source_path' => $restoreJob->source_path,
                'restore_job_id' => $restoreJob->id,
                'safety_backup_job_id' => $safetyBackupJob?->id,
            ], $restoreJob->created_by);

            $finishedAt = now();
            $restoreJob->update([
                'status' => 'success',
                'current_step' => 'completed',
                'progress_percent' => 100,
                'progress_message' => 'Restore completed.',
                'finished_at' => $finishedAt,
                'duration_seconds' => $startedAt->diffInSeconds($finishedAt),
                'error_message' => null,
            ]);

            return $restoreJob->refresh();
        } catch (Throwable $exception) {
            $finishedAt = now();
            $restoreJob->update([
                'status' => 'failed',
                'current_step' => 'failed',
                'progress_message' => 'Restore failed.',
                'finished_at' => $finishedAt,
                'duration_seconds' => $startedAt->diffInSeconds($finishedAt),
                'error_message' => $exception->getMessage(),
            ]);

            app(AuditLogger::class)->log('restore.failed', "Restore failed for {$target->name}.", $target, [
                'target' => $target->name,
                'database_name' => $target->database_name,
                'source' => $restoreJob->source_name,
                'source_path' => $restoreJob->source_path,
                'restore_job_id' => $restoreJob->id,
                'safety_backup_job_id' => $safetyBackupJob?->id,
                'error' => $exception->getMessage(),
            ], $restoreJob->created_by);

            return $restoreJob->refresh();
        }
    }

    private function markProgress(RestoreJob $restoreJob, string $step, int $percent, string $message): void
    {
        $restoreJob->forceFill([
            'current_step' => $step,
            'progress_percent' => max(0, min(100, $percent)),
            'progress_message' => $message,
        ])->save();
    }

    private function prepareSqlFile(string $sourcePath): string
    {
        if (! str_ends_with(strtolower($sourcePath), '.gz')) {
            return $sourcePath;
        }

        $directory = storage_path('app/restore-temp');

        if (! is_dir($directory) && ! mkdir($directory, 0775, true) && ! is_dir($directory)) {
            throw new RuntimeException("Cannot create restore temp directory: {$directory}");
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

            throw new RuntimeException('Cannot read compressed restore file.');
        }

        try {
            while (! gzeof($input)) {
                $chunk = gzread($input, 1024 * 1024);

                if ($chunk === false || fwrite($output, $chunk) === false) {
                    throw new RuntimeException('Cannot decompress restore file.');
                }
            }
        } finally {
            gzclose($input);
            fclose($output);
        }

        return $sqlPath;
    }

    /**
     * @return array<int, array{label: string, status: string, message: string}>
     */
    private function precheckTarget(BackupTarget $target, bool $createSafetyBackup): array
    {
        $checks = [];

        $checks[] = $this->check('Target active', (bool) $target->is_active, 'Target is active.', 'Target is inactive.');

        try {
            $binaries = $this->resolveRestoreBinaries($target);
            $checks[] = $this->check('Restore binary', true, 'Found restore client: '.implode(', ', array_map('basename', $binaries)), '');
        } catch (Throwable $exception) {
            $checks[] = $this->check('Restore binary', false, '', $exception->getMessage());
        }

        try {
            $connection = 'restore_precheck_'.$target->id;
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
            DB::connection($connection)->select('select 1');
            DB::disconnect($connection);
            $checks[] = $this->check('Database connection', true, 'Connected to '.$target->endpoint.'.', '');
        } catch (Throwable $exception) {
            DB::disconnect('restore_precheck_'.$target->id);
            $checks[] = $this->check('Database connection', false, '', $exception->getMessage());
        }

        if ($createSafetyBackup) {
            $directory = $this->resolveConfiguredBackupDirectory($target);
            $checks[] = $this->check('Safety backup folder', is_dir($directory) || @mkdir($directory, 0775, true), 'Safety backup folder exists: '.$directory, 'Cannot create safety backup folder: '.$directory);
            $checks[] = $this->check('Safety backup writable', is_dir($directory) && is_writable($directory), 'Safety backup folder is writable.', 'Safety backup folder is not writable: '.$directory);
        }

        return $checks;
    }

    /**
     * @return array<int, array{label: string, status: string, message: string}>
     */
    private function precheckSqlFile(string $path, ?string $displayName = null): array
    {
        $name = $displayName ?: $path;
        $checks = [
            $this->check('Restore file readable', is_readable($path), 'Restore file is readable: '.$name, 'Restore file is not readable: '.$name),
            $this->check('Restore file not empty', is_file($path) && filesize($path) > 0, 'Restore file has content.', 'Restore file is empty.'),
        ];

        if (str_ends_with(strtolower($name), '.gz') || str_ends_with(strtolower($path), '.gz')) {
            $gzip = @gzopen($path, 'rb');

            if ($gzip === false) {
                $checks[] = $this->check('Gzip file', false, '', 'Cannot open gzip restore file.');
            } else {
                $chunk = gzread($gzip, 512);
                gzclose($gzip);
                $checks[] = $this->check('Gzip file', $chunk !== false, 'Gzip restore file can be read.', 'Cannot read gzip restore file.');
            }
        }

        return $checks;
    }

    protected function runRestoreCommand(BackupTarget $target, string $sqlPath): void
    {
        $env = $this->restoreProcessEnvironment();

        if (($target->password ?? '') !== '') {
            $env['MYSQL_PWD'] = $target->password;
        }

        $errors = [];

        foreach ($this->buildRestoreCommands($target) as $command) {
            $input = fopen($sqlPath, 'rb');

            if ($input === false) {
                throw new RuntimeException("Cannot open restore file: {$sqlPath}");
            }

            $process = new Process($command, null, $env);
            $process->setTimeout(null);
            $process->setInput($input);
            $process->run();

            fclose($input);

            if ($process->isSuccessful()) {
                return;
            }

            $errors[] = basename($command[0]).': '.(trim($process->getErrorOutput()) ?: 'Database restore failed.');
        }

        throw new RuntimeException(implode(PHP_EOL.PHP_EOL, array_unique($errors)));
    }

    /**
     * @return array<int, array<int, string>>
     */
    private function buildRestoreCommands(BackupTarget $target): array
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
                    $target->database_name,
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

    /**
     * @return array<string, string>
     */
    private function restoreProcessEnvironment(): array
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

    private function isPathAllowed(string $filePath, BackupTarget $target): bool
    {
        $realFilePath = realpath($filePath);

        if ($realFilePath === false) {
            return false;
        }

        foreach ($this->allowedBackupDirectories($target) as $directory) {
            $realDirectory = realpath($directory);

            if ($realDirectory === false) {
                continue;
            }

            $normalizedFilePath = rtrim(str_replace('\\', '/', $realFilePath), '/');
            $normalizedDirectory = rtrim(str_replace('\\', '/', $realDirectory), '/');

            if ($normalizedFilePath === $normalizedDirectory || str_starts_with($normalizedFilePath, $normalizedDirectory.'/')) {
                return true;
            }
        }

        return false;
    }

    /**
     * @return array<int, string>
     */
    private function allowedBackupDirectories(BackupTarget $target): array
    {
        return collect([
            $target->backup_path,
            env('BACKUP_DEFAULT_PATH', 'storage/app/backups'),
        ])
            ->filter()
            ->map(fn (string $path): string => $this->isAbsolutePath($path) ? $path : base_path($path))
            ->unique()
            ->values()
            ->all();
    }

    private function resolveConfiguredBackupDirectory(BackupTarget $target): string
    {
        $path = $target->backup_path ?: env('BACKUP_DEFAULT_PATH', 'storage/app/backups');

        return rtrim($this->isAbsolutePath($path) ? $path : base_path($path), '\\/');
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

    private function isAbsolutePath(string $path): bool
    {
        return preg_match('/^[A-Za-z]:[\\\\\\/]/', $path) === 1 || str_starts_with($path, '/') || str_starts_with($path, '\\\\');
    }

    private function normalizeHost(string $host): string
    {
        return strtolower(trim($host)) === 'localhost' ? '127.0.0.1' : $host;
    }
}
