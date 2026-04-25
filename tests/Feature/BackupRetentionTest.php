<?php

use App\Models\BackupJob;
use App\Models\BackupTarget;
use App\Models\User;
use App\Services\BackupRetentionService;
use Illuminate\Foundation\Testing\RefreshDatabase;

uses(RefreshDatabase::class);

function createRetentionTarget(): BackupTarget
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

function createExpiredRetentionJob(BackupTarget $target, string $filePath, ?string $offsitePath = null): BackupJob
{
    return BackupJob::create([
        'backup_target_id' => $target->id,
        'status' => 'success',
        'verification_status' => 'passed',
        'started_at' => now()->subDays(20),
        'finished_at' => now()->subDays(20),
        'file_name' => basename($filePath),
        'file_path' => $filePath,
        'file_size' => is_file($filePath) ? filesize($filePath) : null,
        'offsite_status' => $offsitePath ? 'copied' : null,
        'offsite_copied_at' => $offsitePath ? now()->subDays(20) : null,
        'offsite_path' => $offsitePath,
    ]);
}

function actingAsRetentionAdmin(): User
{
    $user = new User([
        'username' => 'admin',
        'first_name' => 'Admin',
        'status' => 'active',
    ]);
    $user->id = 1;

    test()->actingAs($user);

    return $user;
}

test('retention cleanup deletes expired local and offsite backup files', function () {
    $backupDirectory = storage_path('app/testing-retention-local');
    $offsiteDirectory = storage_path('app/testing-retention-offsite');
    $offsiteTargetDirectory = $offsiteDirectory.DIRECTORY_SEPARATOR.'Accounting_DB';

    foreach ([$backupDirectory, $offsiteTargetDirectory] as $directory) {
        if (! is_dir($directory)) {
            mkdir($directory, 0775, true);
        }
    }

    putenv('BACKUP_OFFSITE_PATH='.$offsiteDirectory);
    $_ENV['BACKUP_OFFSITE_PATH'] = $offsiteDirectory;
    $_SERVER['BACKUP_OFFSITE_PATH'] = $offsiteDirectory;

    $localPath = $backupDirectory.DIRECTORY_SEPARATOR.'expired-local.sql.gz';
    $offsitePath = $offsiteTargetDirectory.DIRECTORY_SEPARATOR.'expired-local.sql.gz';
    file_put_contents($localPath, 'local-backup');
    file_put_contents($offsitePath, 'offsite-backup');

    $target = createRetentionTarget();
    $job = createExpiredRetentionJob($target, $localPath, $offsitePath);

    $dryRun = app(BackupRetentionService::class)->cleanup($target, true);

    expect($dryRun['checked'])->toBe(1)
        ->and($dryRun['deleted_files'])->toBe(0)
        ->and($dryRun['items']->first()['offsite_file_exists'])->toBeTrue()
        ->and(is_file($localPath))->toBeTrue()
        ->and(is_file($offsitePath))->toBeTrue();

    $result = app(BackupRetentionService::class)->cleanup($target);

    expect($result['deleted_files'])->toBe(1)
        ->and($result['deleted_offsite_files'])->toBe(1)
        ->and($result['deleted_records'])->toBe(1)
        ->and(is_file($localPath))->toBeFalse()
        ->and(is_file($offsitePath))->toBeFalse()
        ->and(BackupJob::find($job->id))->toBeNull();
});

test('retention cleanup does not delete offsite paths outside configured offsite root', function () {
    $backupDirectory = storage_path('app/testing-retention-local');
    $offsiteDirectory = storage_path('app/testing-retention-offsite-root');
    $outsideDirectory = storage_path('app/testing-retention-outside');

    foreach ([$backupDirectory, $offsiteDirectory, $outsideDirectory] as $directory) {
        if (! is_dir($directory)) {
            mkdir($directory, 0775, true);
        }
    }

    putenv('BACKUP_OFFSITE_PATH='.$offsiteDirectory);
    $_ENV['BACKUP_OFFSITE_PATH'] = $offsiteDirectory;
    $_SERVER['BACKUP_OFFSITE_PATH'] = $offsiteDirectory;

    $localPath = $backupDirectory.DIRECTORY_SEPARATOR.'expired-outside.sql.gz';
    $outsidePath = $outsideDirectory.DIRECTORY_SEPARATOR.'do-not-delete.sql.gz';
    file_put_contents($localPath, 'local-backup');
    file_put_contents($outsidePath, 'outside-backup');

    $target = createRetentionTarget();
    createExpiredRetentionJob($target, $localPath, $outsidePath);

    $result = app(BackupRetentionService::class)->cleanup($target);

    expect($result['deleted_files'])->toBe(1)
        ->and($result['deleted_offsite_files'])->toBe(0)
        ->and(is_file($outsidePath))->toBeTrue();
});

test('backup cleanup can be previewed and run from dashboard buttons', function () {
    actingAsRetentionAdmin();

    $backupDirectory = storage_path('app/testing-retention-web-local');
    $offsiteDirectory = storage_path('app/testing-retention-web-offsite');
    $offsiteTargetDirectory = $offsiteDirectory.DIRECTORY_SEPARATOR.'Accounting_DB';

    foreach ([$backupDirectory, $offsiteTargetDirectory] as $directory) {
        if (! is_dir($directory)) {
            mkdir($directory, 0775, true);
        }
    }

    putenv('BACKUP_OFFSITE_PATH='.$offsiteDirectory);
    $_ENV['BACKUP_OFFSITE_PATH'] = $offsiteDirectory;
    $_SERVER['BACKUP_OFFSITE_PATH'] = $offsiteDirectory;

    $localPath = $backupDirectory.DIRECTORY_SEPARATOR.'expired-web.sql.gz';
    $offsitePath = $offsiteTargetDirectory.DIRECTORY_SEPARATOR.'expired-web.sql.gz';
    file_put_contents($localPath, 'local-backup');
    file_put_contents($offsitePath, 'offsite-backup');

    $target = createRetentionTarget();
    createExpiredRetentionJob($target, $localPath, $offsitePath);

    $this->post(route('backup-cleanup.preview'))
        ->assertRedirect(route('dashboard'))
        ->assertSessionHas('cleanup_result');

    expect(is_file($localPath))->toBeTrue()
        ->and(is_file($offsitePath))->toBeTrue();

    $this->delete(route('backup-cleanup.destroy'), [
        'confirm_cleanup' => '1',
    ])
        ->assertRedirect(route('dashboard'))
        ->assertSessionHas('cleanup_result');

    expect(is_file($localPath))->toBeFalse()
        ->and(is_file($offsitePath))->toBeFalse();
});
