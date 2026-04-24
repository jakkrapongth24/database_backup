<?php

use App\Mail\BackupHealthCheckFailedMail;
use App\Models\BackupJob;
use App\Models\BackupTarget;
use App\Services\BackupOffsiteCopyService;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Mail;

uses(RefreshDatabase::class);

function createOffsiteTarget(): BackupTarget
{
    return BackupTarget::create([
        'name' => 'Accounting DB',
        'db_type' => 'mariadb',
        'host' => '127.0.0.1',
        'port' => 3306,
        'database_name' => 'accounting',
        'username' => 'root',
        'schedule_frequency' => 'manual',
        'retention_days' => 14,
        'is_active' => true,
    ]);
}

function createVerifiedBackupJob(BackupTarget $target, string $filePath): BackupJob
{
    return BackupJob::create([
        'backup_target_id' => $target->id,
        'status' => 'success',
        'verification_status' => 'passed',
        'started_at' => now(),
        'finished_at' => now(),
        'file_name' => basename($filePath),
        'file_path' => $filePath,
        'file_size' => filesize($filePath),
    ]);
}

test('offsite copy copies verified backup to configured path', function () {
    $backupDirectory = storage_path('app/testing-backups');
    $offsiteDirectory = storage_path('app/testing-offsite');

    if (! is_dir($backupDirectory)) {
        mkdir($backupDirectory, 0775, true);
    }

    $filePath = $backupDirectory.DIRECTORY_SEPARATOR.'accounting-copy-'.uniqid().'.sql.gz';
    file_put_contents($filePath, 'backup-content');

    config(['app.name' => 'testing']);
    putenv('BACKUP_OFFSITE_PATH='.$offsiteDirectory);
    $_ENV['BACKUP_OFFSITE_PATH'] = $offsiteDirectory;
    $_SERVER['BACKUP_OFFSITE_PATH'] = $offsiteDirectory;

    $target = createOffsiteTarget();
    $job = createVerifiedBackupJob($target, $filePath);

    $copied = app(BackupOffsiteCopyService::class)->copy($job);

    expect($copied->offsite_status)->toBe('copied')
        ->and($copied->offsite_path)->not->toBeNull()
        ->and(is_file($copied->offsite_path))->toBeTrue()
        ->and(file_get_contents($copied->offsite_path))->toBe('backup-content');
});

test('offsite copy is skipped when path is not configured', function () {
    putenv('BACKUP_OFFSITE_PATH');
    unset($_ENV['BACKUP_OFFSITE_PATH'], $_SERVER['BACKUP_OFFSITE_PATH']);

    $backupDirectory = storage_path('app/testing-backups');

    if (! is_dir($backupDirectory)) {
        mkdir($backupDirectory, 0775, true);
    }

    $filePath = $backupDirectory.DIRECTORY_SEPARATOR.'accounting-skip.sql.gz';
    file_put_contents($filePath, 'backup-content');

    $target = createOffsiteTarget();
    $job = createVerifiedBackupJob($target, $filePath);

    $copied = app(BackupOffsiteCopyService::class)->copy($job);

    expect($copied->offsite_status)->toBe('skipped')
        ->and($copied->offsite_message)->toContain('BACKUP_OFFSITE_PATH');
});

test('offsite copy command supports dry run', function () {
    $backupDirectory = storage_path('app/testing-backups');

    if (! is_dir($backupDirectory)) {
        mkdir($backupDirectory, 0775, true);
    }

    $filePath = $backupDirectory.DIRECTORY_SEPARATOR.'accounting-command.sql.gz';
    file_put_contents($filePath, 'backup-content');

    $target = createOffsiteTarget();
    createVerifiedBackupJob($target, $filePath);

    $this->artisan('backup:copy-offsite --dry-run')
        ->assertSuccessful()
        ->expectsOutputToContain('Dry run only');
});

test('offsite copy failure sends health alert email', function () {
    Mail::fake();

    $backupDirectory = storage_path('app/testing-backups');

    if (! is_dir($backupDirectory)) {
        mkdir($backupDirectory, 0775, true);
    }

    $filePath = $backupDirectory.DIRECTORY_SEPARATOR.'accounting-offsite-alert.sql.gz';
    $blockedPath = storage_path('app/offsite-blocked-file');
    file_put_contents($filePath, 'backup-content');
    file_put_contents($blockedPath, 'not-a-directory');

    putenv('BACKUP_OFFSITE_PATH='.$blockedPath);
    $_ENV['BACKUP_OFFSITE_PATH'] = $blockedPath;
    $_SERVER['BACKUP_OFFSITE_PATH'] = $blockedPath;

    $target = createOffsiteTarget();
    $target->update(['notification_emails' => 'admin@example.com']);
    $job = createVerifiedBackupJob($target, $filePath);

    try {
        app(BackupOffsiteCopyService::class)->copy($job);
    } catch (Throwable) {
        //
    }

    Mail::assertSent(BackupHealthCheckFailedMail::class, fn (BackupHealthCheckFailedMail $mail): bool => $mail->checkType === 'Offsite copy');
});
