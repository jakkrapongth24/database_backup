<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

#[Fillable([
    'backup_target_id',
    'backup_job_id',
    'safety_backup_job_id',
    'source_type',
    'status',
    'current_step',
    'progress_percent',
    'progress_message',
    'started_at',
    'finished_at',
    'duration_seconds',
    'source_name',
    'source_path',
    'restore_binary_path',
    'create_safety_backup',
    'error_message',
    'created_by',
])]
class RestoreJob extends Model
{
    protected function casts(): array
    {
        return [
            'started_at' => 'datetime',
            'finished_at' => 'datetime',
            'duration_seconds' => 'integer',
            'create_safety_backup' => 'boolean',
            'progress_percent' => 'integer',
        ];
    }

    public function target(): BelongsTo
    {
        return $this->belongsTo(BackupTarget::class, 'backup_target_id');
    }

    public function backupJob(): BelongsTo
    {
        return $this->belongsTo(BackupJob::class, 'backup_job_id');
    }

    public function safetyBackupJob(): BelongsTo
    {
        return $this->belongsTo(BackupJob::class, 'safety_backup_job_id');
    }
}
