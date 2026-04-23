<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Attributes\Hidden;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;

#[Fillable([
    'employee_id',
    'cid',
    'prefix',
    'first_name',
    'last_name',
    'thai_first_name',
    'thai_last_name',
    'email',
    'phone',
    'username',
    'password',
    'status',
])]
#[Hidden(['password', 'remember_token'])]
class User extends Authenticatable
{
    use Notifiable, SoftDeletes;

    protected $table = 'personel';

    public function getNameAttribute(): string
    {
        $fullName = trim(implode(' ', array_filter([
            $this->prefix,
            $this->thai_first_name ?: $this->first_name,
            $this->thai_last_name ?: $this->last_name,
        ])));

        return $fullName !== '' ? $fullName : $this->username;
    }

    public function isActive(): bool
    {
        return $this->status === 'active';
    }

    /**
     * Get the attributes that should be cast.
     *
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'birthdate' => 'date',
            'hire_date' => 'date',
            'deleted_at' => 'datetime',
            'password' => 'hashed',
        ];
    }
}
