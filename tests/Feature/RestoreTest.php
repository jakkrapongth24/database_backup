<?php

use App\Jobs\RunRestoreJob;
use App\Models\BackupJob;
use App\Models\BackupTarget;
use App\Models\RestoreJob;
use App\Models\User;
use App\Services\DatabaseRestoreService;
use App\Support\UrlId;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Queue;

uses(RefreshDatabase::class);

function actingAsAdmin(): User
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

test('restore page is available for authenticated users', function () {
    actingAsAdmin();

    $target = BackupTarget::create([
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

    $this->get(route('restore.index', ['target_id' => $target->id]))
        ->assertOk()
        ->assertSee('กู้คืนฐานข้อมูล')
        ->assertSee('Accounting DB');
});

test('restore requires exact database confirmation', function () {
    actingAsAdmin();

    $target = BackupTarget::create([
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
    $job = BackupJob::create([
        'backup_target_id' => $target->id,
        'status' => 'success',
        'started_at' => now(),
        'file_name' => 'accounting.sql.gz',
        'file_path' => storage_path('app/backups/accounting.sql.gz'),
    ]);

    $this->post(route('restore.store'), [
        'backup_target_id' => $target->id,
        'source_type' => 'backup_job',
        'backup_job_id' => $job->id,
        'confirmation_database' => 'wrong_database',
        'confirm_understand' => '1',
        'create_safety_backup' => '1',
    ])
        ->assertRedirect()
        ->assertSessionHas('error');
});

test('restore history page shows restore jobs', function () {
    actingAsAdmin();

    $target = BackupTarget::create([
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
    RestoreJob::create([
        'backup_target_id' => $target->id,
        'source_type' => 'upload',
        'status' => 'success',
        'started_at' => now(),
        'finished_at' => now(),
        'duration_seconds' => 2,
        'source_name' => 'accounting.sql.gz',
    ]);

    $this->get(route('restore-history.index'))
        ->assertOk()
        ->assertSee('ประวัติการ Restore')
        ->assertSee('accounting.sql.gz');
});

test('restore precheck can run without final confirmation', function () {
    actingAsAdmin();

    $target = BackupTarget::create([
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
    $job = BackupJob::create([
        'backup_target_id' => $target->id,
        'status' => 'success',
        'started_at' => now(),
        'file_name' => 'missing.sql.gz',
        'file_path' => storage_path('app/backups/missing.sql.gz'),
    ]);

    $this->post(route('restore.store'), [
        'backup_target_id' => $target->id,
        'source_type' => 'backup_job',
        'backup_job_id' => $job->id,
        'intent' => 'precheck',
        'create_safety_backup' => '1',
    ])
        ->assertRedirect()
        ->assertSessionHas('restore_precheck');
});

test('restore request queues a restore job', function () {
    Queue::fake();
    actingAsAdmin();

    $backupDirectory = storage_path('app/backups');

    if (! is_dir($backupDirectory)) {
        mkdir($backupDirectory, 0775, true);
    }

    $filePath = $backupDirectory.DIRECTORY_SEPARATOR.'accounting.sql';
    file_put_contents($filePath, 'select 1;');

    $target = BackupTarget::create([
        'name' => 'Accounting DB',
        'db_type' => 'mariadb',
        'host' => '127.0.0.1',
        'port' => 3306,
        'database_name' => 'accounting',
        'username' => 'root',
        'backup_path' => $backupDirectory,
        'schedule_frequency' => 'manual',
        'retention_days' => 14,
        'is_active' => true,
    ]);
    $job = BackupJob::create([
        'backup_target_id' => $target->id,
        'status' => 'success',
        'started_at' => now(),
        'file_name' => 'accounting.sql',
        'file_path' => $filePath,
    ]);

    $response = $this->post(route('restore.store'), [
        'backup_target_id' => $target->id,
        'source_type' => 'backup_job',
        'backup_job_id' => $job->id,
        'confirmation_database' => 'accounting',
        'confirm_understand' => '1',
        'create_safety_backup' => '1',
        'intent' => 'restore',
    ]);

    $response
        ->assertRedirect()
        ->assertSessionHas('status');

    parse_str(parse_url($response->headers->get('Location'), PHP_URL_QUERY) ?: '', $query);

    expect(UrlId::decode($query['target_id'] ?? null))->toBe($target->id);

    $restoreJob = RestoreJob::query()->first();

    expect($restoreJob)
        ->not->toBeNull()
        ->and($restoreJob->status)->toBe('queued')
        ->and($restoreJob->current_step)->toBe('queued')
        ->and($restoreJob->progress_percent)->toBe(0)
        ->and($restoreJob->create_safety_backup)->toBeTrue();

    Queue::assertPushed(RunRestoreJob::class);
});

test('queued backup-job restore can complete with mocked restore process', function () {
    $backupDirectory = storage_path('app/backups');

    if (! is_dir($backupDirectory)) {
        mkdir($backupDirectory, 0775, true);
    }

    $filePath = $backupDirectory.DIRECTORY_SEPARATOR.'mock-backup.sql';
    file_put_contents($filePath, 'select 1;');

    $target = BackupTarget::create([
        'name' => 'Accounting DB',
        'db_type' => 'mariadb',
        'host' => '127.0.0.1',
        'port' => 3306,
        'database_name' => 'accounting',
        'username' => 'root',
        'backup_path' => $backupDirectory,
        'schedule_frequency' => 'manual',
        'retention_days' => 14,
        'is_active' => true,
    ]);
    $backupJob = BackupJob::create([
        'backup_target_id' => $target->id,
        'status' => 'success',
        'started_at' => now(),
        'file_name' => 'mock-backup.sql',
        'file_path' => $filePath,
    ]);
    $restoreJob = RestoreJob::create([
        'backup_target_id' => $target->id,
        'backup_job_id' => $backupJob->id,
        'source_type' => 'backup_job',
        'status' => 'queued',
        'source_name' => 'mock-backup.sql',
        'source_path' => $filePath,
        'create_safety_backup' => false,
    ]);

    $service = Mockery::mock(DatabaseRestoreService::class)->makePartial()->shouldAllowMockingProtectedMethods();
    $service->shouldReceive('runRestoreCommand')->once()->andReturnNull();

    $result = $service->runQueuedJob($restoreJob);

    expect($result->status)->toBe('success')
        ->and($result->current_step)->toBe('completed')
        ->and($result->progress_percent)->toBe(100)
        ->and($result->safety_backup_job_id)->toBeNull();
});

test('queued upload restore can complete with mocked restore process', function () {
    $uploadDirectory = storage_path('app/restore-uploads');

    if (! is_dir($uploadDirectory)) {
        mkdir($uploadDirectory, 0775, true);
    }

    $filePath = $uploadDirectory.DIRECTORY_SEPARATOR.'mock-upload.sql';
    file_put_contents($filePath, 'select 1;');

    $target = BackupTarget::create([
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
    $restoreJob = RestoreJob::create([
        'backup_target_id' => $target->id,
        'source_type' => 'upload',
        'status' => 'queued',
        'source_name' => 'mock-upload.sql',
        'source_path' => $filePath,
        'create_safety_backup' => false,
    ]);

    $service = Mockery::mock(DatabaseRestoreService::class)->makePartial()->shouldAllowMockingProtectedMethods();
    $service->shouldReceive('runRestoreCommand')->once()->andReturnNull();

    $result = $service->runQueuedJob($restoreJob);

    expect($result->status)->toBe('success')
        ->and($result->current_step)->toBe('completed')
        ->and($result->progress_percent)->toBe(100)
        ->and($result->source_type)->toBe('upload');
});
