<?php

namespace App\Services;

use App\Models\BackupJob;
use App\Models\BackupTarget;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Auth;
use RuntimeException;
use Symfony\Component\Process\Process;
use Throwable;

class DatabaseRestoreService
{
    /**
     * @return array{source_path: string, safety_backup_job_id: int|null}
     */
    public function restoreFromBackupJob(BackupTarget $target, BackupJob $backupJob, bool $createSafetyBackup = true): array
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

        return $this->restore($target, $backupJob->file_path, 'backup_job:'.$backupJob->id, $createSafetyBackup);
    }

    /**
     * @return array{source_path: string, safety_backup_job_id: int|null}
     */
    public function restoreFromUpload(BackupTarget $target, UploadedFile $upload, bool $createSafetyBackup = true): array
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

        return $this->restore($target, $path, 'uploaded:'.$safeName, $createSafetyBackup);
    }

    /**
     * @return array{source_path: string, safety_backup_job_id: int|null}
     */
    private function restore(BackupTarget $target, string $sourcePath, string $sourceLabel, bool $createSafetyBackup): array
    {
        $safetyBackupJob = null;

        try {
            if ($createSafetyBackup) {
                $safetyBackupJob = app(DatabaseBackupService::class)->run($target, Auth::id());

                if ($safetyBackupJob->status !== 'success') {
                    throw new RuntimeException('Safety backup failed before restore: '.($safetyBackupJob->error_message ?: 'Unknown error'));
                }
            }

            $sqlPath = $this->prepareSqlFile($sourcePath);

            try {
                $this->runRestoreCommand($target, $sqlPath);
            } finally {
                if ($sqlPath !== $sourcePath && is_file($sqlPath)) {
                    @unlink($sqlPath);
                }
            }

            app(AuditLogger::class)->log('restore.completed', "Restore completed for {$target->name}.", $target, [
                'target' => $target->name,
                'database_name' => $target->database_name,
                'source' => $sourceLabel,
                'source_path' => $sourcePath,
                'safety_backup_job_id' => $safetyBackupJob?->id,
            ]);

            return [
                'source_path' => $sourcePath,
                'safety_backup_job_id' => $safetyBackupJob?->id,
            ];
        } catch (Throwable $exception) {
            app(AuditLogger::class)->log('restore.failed', "Restore failed for {$target->name}.", $target, [
                'target' => $target->name,
                'database_name' => $target->database_name,
                'source' => $sourceLabel,
                'source_path' => $sourcePath,
                'safety_backup_job_id' => $safetyBackupJob?->id,
                'error' => $exception->getMessage(),
            ]);

            throw $exception;
        }
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

    private function runRestoreCommand(BackupTarget $target, string $sqlPath): void
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

    private function isAbsolutePath(string $path): bool
    {
        return preg_match('/^[A-Za-z]:[\\\\\\/]/', $path) === 1 || str_starts_with($path, '/') || str_starts_with($path, '\\\\');
    }

    private function normalizeHost(string $host): string
    {
        return strtolower(trim($host)) === 'localhost' ? '127.0.0.1' : $host;
    }
}
