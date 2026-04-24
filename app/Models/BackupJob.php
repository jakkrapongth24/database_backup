<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

#[Fillable([
    'backup_target_id',
    'status',
    'started_at',
    'finished_at',
    'duration_seconds',
    'file_name',
    'file_path',
    'file_size',
    'dump_binary_path',
    'verification_status',
    'verified_at',
    'verification_message',
    'offsite_status',
    'offsite_copied_at',
    'offsite_path',
    'offsite_message',
    'error_message',
    'created_by',
])]
class BackupJob extends Model
{
    protected function casts(): array
    {
        return [
            'started_at' => 'datetime',
            'finished_at' => 'datetime',
            'duration_seconds' => 'integer',
            'file_size' => 'integer',
            'verified_at' => 'datetime',
            'offsite_copied_at' => 'datetime',
        ];
    }

    public function isQueued(): bool
    {
        return $this->status === 'queued';
    }

    public function target(): BelongsTo
    {
        return $this->belongsTo(BackupTarget::class, 'backup_target_id');
    }

    public function restoreDrills(): HasMany
    {
        return $this->hasMany(RestoreDrill::class);
    }

    public function getHumanFileSizeAttribute(): string
    {
        if ($this->file_size === null) {
            return '-';
        }

        $units = ['B', 'KB', 'MB', 'GB', 'TB'];
        $size = (float) $this->file_size;

        foreach ($units as $unit) {
            if ($size < 1024 || $unit === 'TB') {
                return number_format($size, $unit === 'B' ? 0 : 2).' '.$unit;
            }

            $size /= 1024;
        }

        return '-';
    }
}
