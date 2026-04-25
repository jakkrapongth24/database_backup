<?php

use App\Mail\BackupHealthCheckFailedMail;
use App\Models\BackupJob;
use App\Models\BackupTarget;
use App\Models\RestoreDrill;
use App\Models\User;
use App\Services\RestoreDrillService;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Mail;

uses(RefreshDatabase::class);

function createDrillTarget(): BackupTarget
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

function actingAsDrillAdmin(): User
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

function createDrillBackupJob(BackupTarget $target, string $filePath, string $verificationStatus = 'passed'): BackupJob
{
    return BackupJob::create([
        'backup_target_id' => $target->id,
        'status' => 'success',
        'verification_status' => $verificationStatus,
        'started_at' => now(),
        'finished_at' => now(),
        'file_name' => basename($filePath),
        'file_path' => $filePath,
        'file_size' => is_file($filePath) ? filesize($filePath) : null,
    ]);
}

test('restore drill passes for latest verified readable backup', function () {
    $directory = storage_path('app/testing-drills');

    if (! is_dir($directory)) {
        mkdir($directory, 0775, true);
    }

    $filePath = $directory.DIRECTORY_SEPARATOR.'accounting.sql.gz';
    $gzip = gzopen($filePath, 'wb9');
    gzwrite($gzip, 'select 1;');
    gzclose($gzip);

    $target = createDrillTarget();
    $job = createDrillBackupJob($target, $filePath);

    $drill = app(RestoreDrillService::class)->runForTarget($target, $job);

    expect($drill->status)->toBe('success')
        ->and($drill->backup_job_id)->toBe($job->id)
        ->and($drill->checks)->not->toBeEmpty();
});

test('restore drill skips actual restore unless explicitly enabled', function () {
    putenv('BACKUP_RESTORE_DRILL_ACTUAL_RESTORE=false');
    $_ENV['BACKUP_RESTORE_DRILL_ACTUAL_RESTORE'] = 'false';
    $_SERVER['BACKUP_RESTORE_DRILL_ACTUAL_RESTORE'] = 'false';

    $directory = storage_path('app/testing-drills');

    if (! is_dir($directory)) {
        mkdir($directory, 0775, true);
    }

    $filePath = $directory.DIRECTORY_SEPARATOR.'readiness-only.sql';
    file_put_contents($filePath, 'select 1;');

    $target = createDrillTarget();
    $job = createDrillBackupJob($target, $filePath);

    $drill = app(RestoreDrillService::class)->runForTarget($target, $job);

    expect($drill->status)->toBe('success')
        ->and(collect($drill->checks)->firstWhere('label', 'Restore จริงเข้า Test Database')['message'])
        ->toContain('ข้ามขั้นตอนนี้');
});

test('actual restore drill refuses production database as test database', function () {
    Mail::fake();

    $directory = storage_path('app/testing-drills');

    if (! is_dir($directory)) {
        mkdir($directory, 0775, true);
    }

    $filePath = $directory.DIRECTORY_SEPARATOR.'unsafe-drill.sql';
    file_put_contents($filePath, 'select 1;');

    $target = createDrillTarget();
    $job = createDrillBackupJob($target, $filePath);

    $drill = app(RestoreDrillService::class)->runForTarget($target, $job, options: [
        'actual_restore' => true,
        'test_database' => 'accounting',
    ]);

    expect($drill->status)->toBe('failed')
        ->and($drill->error_message)->toBe('ชื่อ Test Database สำหรับ Restore Drill ต้องไม่ตรงกับชื่อฐานข้อมูลจริง');
});

test('restore drill fails when backup verification has not passed', function () {
    $directory = storage_path('app/testing-drills');

    if (! is_dir($directory)) {
        mkdir($directory, 0775, true);
    }

    $filePath = $directory.DIRECTORY_SEPARATOR.'not-verified.sql';
    file_put_contents($filePath, 'select 1;');

    $target = createDrillTarget();
    $job = createDrillBackupJob($target, $filePath, 'failed');

    $drill = app(RestoreDrillService::class)->runForTarget($target, $job);

    expect($drill->status)->toBe('failed')
        ->and($drill->error_message)->toBe('Backup verification has not passed.');
});

test('restore drill failure sends health alert email', function () {
    Mail::fake();

    $directory = storage_path('app/testing-drills');

    if (! is_dir($directory)) {
        mkdir($directory, 0775, true);
    }

    $filePath = $directory.DIRECTORY_SEPARATOR.'drill-alert.sql';
    file_put_contents($filePath, 'select 1;');

    $target = createDrillTarget();
    $target->update(['notification_emails' => 'admin@example.com']);
    $job = createDrillBackupJob($target, $filePath, 'failed');

    app(RestoreDrillService::class)->runForTarget($target, $job);

    Mail::assertSent(BackupHealthCheckFailedMail::class, fn (BackupHealthCheckFailedMail $mail): bool => $mail->checkType === 'Restore drill');
});

test('restore drill command supports dry run', function () {
    $directory = storage_path('app/testing-drills');

    if (! is_dir($directory)) {
        mkdir($directory, 0775, true);
    }

    $filePath = $directory.DIRECTORY_SEPARATOR.'command.sql';
    file_put_contents($filePath, 'select 1;');

    $target = createDrillTarget();
    createDrillBackupJob($target, $filePath);

    $this->artisan('backup:restore-drill --dry-run')
        ->assertSuccessful()
        ->expectsOutputToContain('Dry run only');
});

test('restore drill can be run from web page button', function () {
    actingAsDrillAdmin();

    $directory = storage_path('app/testing-drills');

    if (! is_dir($directory)) {
        mkdir($directory, 0775, true);
    }

    $filePath = $directory.DIRECTORY_SEPARATOR.'web-button.sql';
    file_put_contents($filePath, 'select 1;');

    $target = createDrillTarget();
    createDrillBackupJob($target, $filePath);

    $this->post(route('restore-drills.run'), [
        'backup_target_id' => $target->id,
    ])
        ->assertRedirect(route('restore-drills.index'))
        ->assertSessionHas('status');

    $this->assertDatabaseHas('restore_drills', [
        'backup_target_id' => $target->id,
        'status' => 'success',
    ]);
});

test('restore drill actual restore options can be submitted from web page', function () {
    actingAsDrillAdmin();
    Mail::fake();

    $directory = storage_path('app/testing-drills');

    if (! is_dir($directory)) {
        mkdir($directory, 0775, true);
    }

    $filePath = $directory.DIRECTORY_SEPARATOR.'web-actual-restore.sql';
    file_put_contents($filePath, 'select 1;');

    $target = createDrillTarget();
    createDrillBackupJob($target, $filePath);

    $this->post(route('restore-drills.run'), [
        'backup_target_id' => $target->id,
        'actual_restore' => '1',
        'test_database' => 'accounting',
    ])
        ->assertRedirect(route('restore-drills.index'))
        ->assertSessionHas('error');

    $this->assertDatabaseHas('restore_drills', [
        'backup_target_id' => $target->id,
        'status' => 'failed',
        'error_message' => 'ชื่อ Test Database สำหรับ Restore Drill ต้องไม่ตรงกับชื่อฐานข้อมูลจริง',
    ]);
});

test('restore drill page shows drill records', function () {
    actingAsDrillAdmin();

    $target = createDrillTarget();
    RestoreDrill::create([
        'backup_target_id' => $target->id,
        'status' => 'success',
        'started_at' => now(),
        'finished_at' => now(),
        'duration_seconds' => 1,
        'source_name' => 'accounting.sql.gz',
        'checks' => [
            ['label' => 'Backup file exists', 'status' => 'passed', 'message' => 'Backup file exists.'],
        ],
    ]);

    $this->get(route('restore-drills.index'))
        ->assertOk()
        ->assertSee('Restore Drills')
        ->assertSee('ตรวจ Restore ตอนนี้')
        ->assertSee('accounting.sql.gz');
});

test('restore drill report can be exported', function () {
    actingAsDrillAdmin();

    $target = createDrillTarget();
    RestoreDrill::create([
        'backup_target_id' => $target->id,
        'status' => 'success',
        'started_at' => now(),
        'finished_at' => now(),
        'duration_seconds' => 1,
        'source_name' => 'accounting-export.sql.gz',
        'checks' => [
            ['label' => 'Backup file exists', 'status' => 'passed', 'message' => 'Backup file exists.'],
        ],
    ]);

    $this->get(route('restore-drills.export.csv'))
        ->assertOk()
        ->assertHeader('content-type', 'text/csv; charset=UTF-8');

    $this->get(route('restore-drills.export.excel'))
        ->assertOk()
        ->assertHeader('content-type', 'application/vnd.ms-excel; charset=UTF-8');

    $this->get(route('restore-drills.export.pdf'))
        ->assertOk()
        ->assertSee('Restore Drill Report')
        ->assertSee('accounting-export.sql.gz');
});
