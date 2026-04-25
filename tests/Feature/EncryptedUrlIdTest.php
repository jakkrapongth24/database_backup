<?php

use App\Models\BackupJob;
use App\Models\BackupTarget;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;

uses(RefreshDatabase::class);

function actingAsUrlIdUser(): User
{
    $user = new User([
        'username' => 'url-id-admin',
        'first_name' => 'Admin',
        'status' => 'active',
    ]);
    $user->id = 1;

    test()->actingAs($user);

    return $user;
}

function makeUrlIdTarget(): BackupTarget
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

test('backup target routes use encrypted url ids instead of numeric ids', function () {
    actingAsUrlIdUser();
    $target = makeUrlIdTarget();

    $url = route('backup-targets.show', $target);
    $segment = basename(parse_url($url, PHP_URL_PATH));

    expect($segment)
        ->not->toBe((string) $target->id)
        ->and(ctype_digit($segment))->toBeFalse();

    $this->get($url)
        ->assertOk()
        ->assertSee('Accounting DB');
});

test('filters and restore forms accept encrypted url ids', function () {
    actingAsUrlIdUser();
    $target = makeUrlIdTarget();
    $job = BackupJob::create([
        'backup_target_id' => $target->id,
        'status' => 'success',
        'started_at' => now(),
        'file_name' => 'accounting.sql.gz',
        'file_path' => storage_path('app/backups/accounting.sql.gz'),
    ]);

    $this->get(route('backup-jobs.index', ['target_id' => $target->getRouteKey()]))
        ->assertOk()
        ->assertSee('accounting.sql.gz')
        ->assertDontSee('target_id='.$target->id, false);

    $this->get(route('restore.index', ['target_id' => $target->getRouteKey()]))
        ->assertOk()
        ->assertSee('Accounting DB')
        ->assertSee('name="backup_job_id"', false)
        ->assertDontSee('<option value="'.$job->id.'"', false);
});
