<?php

use App\Mail\BackupHealthCheckFailedMail;
use App\Models\BackupJob;
use App\Models\BackupTarget;
use App\Services\BackupVerificationService;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Mail;

uses(RefreshDatabase::class);

function createVerificationTarget(): BackupTarget
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

test('backup verification passes for readable gzip backup', function () {
    $directory = storage_path('app/testing-backups');

    if (! is_dir($directory)) {
        mkdir($directory, 0775, true);
    }

    $filePath = $directory.DIRECTORY_SEPARATOR.'accounting.sql.gz';
    $gzip = gzopen($filePath, 'wb9');
    gzwrite($gzip, 'select 1;');
    gzclose($gzip);

    $target = createVerificationTarget();
    $job = BackupJob::create([
        'backup_target_id' => $target->id,
        'status' => 'success',
        'started_at' => now(),
        'finished_at' => now(),
        'file_name' => 'accounting.sql.gz',
        'file_path' => $filePath,
        'file_size' => filesize($filePath),
    ]);

    $verified = app(BackupVerificationService::class)->verify($job);

    expect($verified->verification_status)->toBe('passed')
        ->and($verified->verified_at)->not->toBeNull()
        ->and($verified->verification_message)->toContain('gzip');
});

test('backup verification records failure when file is missing', function () {
    Mail::fake();

    $target = createVerificationTarget();
    $target->update(['notification_emails' => 'admin@example.com']);
    $job = BackupJob::create([
        'backup_target_id' => $target->id,
        'status' => 'success',
        'started_at' => now(),
        'finished_at' => now(),
        'file_name' => 'missing.sql.gz',
        'file_path' => storage_path('app/testing-backups/missing.sql.gz'),
    ]);

    app(BackupVerificationService::class)->verify($job);
})->throws(RuntimeException::class, 'Backup file does not exist');

test('backup verification failure sends health alert email', function () {
    Mail::fake();

    $target = createVerificationTarget();
    $target->update(['notification_emails' => 'admin@example.com']);
    $job = BackupJob::create([
        'backup_target_id' => $target->id,
        'status' => 'success',
        'started_at' => now(),
        'finished_at' => now(),
        'file_name' => 'missing-alert.sql.gz',
        'file_path' => storage_path('app/testing-backups/missing-alert.sql.gz'),
    ]);

    try {
        app(BackupVerificationService::class)->verify($job);
    } catch (RuntimeException) {
        //
    }

    Mail::assertSent(BackupHealthCheckFailedMail::class, fn (BackupHealthCheckFailedMail $mail): bool => $mail->checkType === 'Backup verification');
});

test('backup verify command supports dry run', function () {
    $target = createVerificationTarget();
    BackupJob::create([
        'backup_target_id' => $target->id,
        'status' => 'success',
        'started_at' => now(),
        'finished_at' => now(),
        'file_name' => 'accounting.sql.gz',
        'file_path' => storage_path('app/testing-backups/accounting.sql.gz'),
    ]);

    $this->artisan('backup:verify --dry-run')
        ->assertSuccessful()
        ->expectsOutputToContain('Dry run only');
});
