<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

#[Fillable([
    'backup_target_id',
    'backup_job_id',
    'status',
    'started_at',
    'finished_at',
    'duration_seconds',
    'source_name',
    'source_path',
    'checks',
    'error_message',
    'created_by',
])]
class RestoreDrill extends Model
{
    protected function casts(): array
    {
        return [
            'started_at' => 'datetime',
            'finished_at' => 'datetime',
            'duration_seconds' => 'integer',
            'checks' => 'array',
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
}
