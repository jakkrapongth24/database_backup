<?php

use App\Jobs\RunBackupJob;
use App\Models\BackupJob;
use App\Models\BackupTarget;
use App\Models\User;
use App\Support\UrlId;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Queue;

uses(RefreshDatabase::class);

function actingAsBackupWorkflowAdmin(): User
{
    $user = new User([
        'username' => 'backup-workflow-admin',
        'first_name' => 'Admin',
        'status' => 'active',
    ]);
    $user->id = 1;

    test()->actingAs($user);

    return $user;
}

function backupWorkflowPayload(array $overrides = []): array
{
    return [
        'name' => 'Accounting DB',
        'description' => 'Main accounting database',
        'db_type' => 'mariadb',
        'host' => '127.0.0.1',
        'port' => 3306,
        'database_name' => 'accounting',
        'username' => 'root',
        'password' => 'secret',
        'dump_binary_path' => '',
        'backup_path' => storage_path('app/testing-workflow-backups'),
        'notification_emails' => 'admin@example.test',
        'schedule_frequency' => 'daily',
        'schedule_time' => '01:30',
        'retention_days' => 14,
        'is_active' => '1',
        ...$overrides,
    ];
}

function createBackupWorkflowTarget(array $overrides = []): BackupTarget
{
    return BackupTarget::create([
        'name' => 'Accounting DB',
        'description' => 'Main accounting database',
        'db_type' => 'mariadb',
        'host' => '127.0.0.1',
        'port' => 3306,
        'database_name' => 'accounting',
        'username' => 'root',
        'backup_path' => storage_path('app/testing-workflow-backups'),
        'schedule_frequency' => 'manual',
        'retention_days' => 14,
        'is_active' => true,
        ...$overrides,
    ]);
}

test('backup target can be created and edited from web forms', function () {
    actingAsBackupWorkflowAdmin();

    $this->post(route('backup-targets.store'), backupWorkflowPayload())
        ->assertRedirect(route('backup-targets.index'))
        ->assertSessionHas('status');

    $target = BackupTarget::query()->where('name', 'Accounting DB')->firstOrFail();

    expect($target->created_by)
        ->toBe(1)
        ->and($target->is_active)->toBeTrue()
        ->and($target->retention_days)->toBe(14);

    $this->get(route('backup-targets.show', $target))
        ->assertOk()
        ->assertSee('Accounting DB')
        ->assertDontSee('/backup-targets/'.$target->id, false);

    $response = $this->put(route('backup-targets.update', $target), backupWorkflowPayload([
        'name' => 'Accounting DB Updated',
        'password' => '',
        'schedule_frequency' => 'weekly',
        'schedule_time' => '02:15',
        'retention_days' => 30,
    ]));

    $response
        ->assertRedirect()
        ->assertSessionHas('status');

    $path = trim(parse_url($response->headers->get('Location'), PHP_URL_PATH) ?: '', '/');
    $segments = explode('/', $path);

    expect(UrlId::decode($segments[1] ?? null))->toBe($target->id);

    $target->refresh();

    expect($target->name)
        ->toBe('Accounting DB Updated')
        ->and($target->schedule_frequency)->toBe('weekly')
        ->and($target->retention_days)->toBe(30)
        ->and($target->updated_by)->toBe(1);
});

test('backup now queues a backup job from encrypted target route', function () {
    Queue::fake();
    actingAsBackupWorkflowAdmin();
    $target = createBackupWorkflowTarget();

    $this->post(route('backup-targets.backup-now', $target))
        ->assertRedirect()
        ->assertSessionHas('status');

    $job = BackupJob::query()->firstOrFail();

    expect($job->backup_target_id)
        ->toBe($target->id)
        ->and($job->status)->toBe('queued')
        ->and($job->created_by)->toBe(1);

    Queue::assertPushed(RunBackupJob::class, fn (RunBackupJob $queuedJob): bool => $queuedJob->backupJobId === $job->id);
});

test('successful backup can be downloaded from encrypted backup job route', function () {
    actingAsBackupWorkflowAdmin();
    $backupDirectory = storage_path('app/testing-workflow-backups');

    if (! is_dir($backupDirectory)) {
        mkdir($backupDirectory, 0775, true);
    }

    $filePath = $backupDirectory.DIRECTORY_SEPARATOR.'accounting.sql.gz';
    file_put_contents($filePath, 'backup-content');

    $target = createBackupWorkflowTarget([
        'backup_path' => $backupDirectory,
    ]);
    $job = BackupJob::create([
        'backup_target_id' => $target->id,
        'status' => 'success',
        'started_at' => now(),
        'finished_at' => now(),
        'file_name' => 'accounting.sql.gz',
        'file_path' => $filePath,
        'file_size' => filesize($filePath),
    ]);

    $url = route('backup-jobs.download', $job);
    $segment = basename(dirname(parse_url($url, PHP_URL_PATH)));

    expect($segment)
        ->not->toBe((string) $job->id)
        ->and(ctype_digit($segment))->toBeFalse();

    $this->get($url)
        ->assertOk()
        ->assertDownload('accounting.sql.gz');
});
