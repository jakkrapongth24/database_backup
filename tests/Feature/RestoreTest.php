<?php

use App\Models\BackupJob;
use App\Models\BackupTarget;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;

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
