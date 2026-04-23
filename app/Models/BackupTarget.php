<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

#[Fillable([
    'name',
    'description',
    'db_type',
    'host',
    'port',
    'database_name',
    'username',
    'password',
    'dump_binary_path',
    'backup_path',
    'schedule_frequency',
    'schedule_time',
    'retention_days',
    'is_active',
    'last_connection_status',
    'last_connection_checked_at',
    'last_connection_error',
    'created_by',
    'updated_by',
])]
class BackupTarget extends Model
{
    protected function casts(): array
    {
        return [
            'password' => 'encrypted',
            'port' => 'integer',
            'retention_days' => 'integer',
            'is_active' => 'boolean',
            'last_connection_status' => 'boolean',
            'last_connection_checked_at' => 'datetime',
        ];
    }

    protected function endpoint(): Attribute
    {
        return Attribute::get(fn (): string => "{$this->host}:{$this->port}/{$this->database_name}");
    }

    public function markConnectionResult(bool $success, ?string $error = null): void
    {
        $this->forceFill([
            'last_connection_status' => $success,
            'last_connection_checked_at' => now(),
            'last_connection_error' => $success ? null : $error,
        ])->save();
    }

    public function jobs(): HasMany
    {
        return $this->hasMany(BackupJob::class);
    }
}
