<?php

namespace App\Services;

use App\Models\AuditLog;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Schema;
use Throwable;

class AuditLogger
{
    /**
     * @param  array<string, mixed>  $metadata
     */
    public function log(string $action, ?string $description = null, ?Model $auditable = null, array $metadata = [], ?int $userId = null): void
    {
        try {
            if (! Schema::hasTable('audit_logs')) {
                return;
            }

            $user = Auth::user();

            AuditLog::create([
                'user_id' => $userId ?? $user?->getAuthIdentifier(),
                'user_name' => $user?->name,
                'action' => $action,
                'auditable_type' => $auditable ? $auditable::class : null,
                'auditable_id' => $auditable?->getKey(),
                'description' => $description,
                'metadata' => $this->sanitize($metadata),
                'ip_address' => request()?->ip(),
                'user_agent' => request()?->userAgent(),
            ]);
        } catch (Throwable) {
            // Audit logging must never block the primary backup workflow.
        }
    }

    /**
     * @param  array<string, mixed>  $metadata
     * @return array<string, mixed>
     */
    private function sanitize(array $metadata): array
    {
        foreach ($metadata as $key => $value) {
            if (str_contains(strtolower((string) $key), 'password')) {
                $metadata[$key] = '[hidden]';
            }

            if (is_array($value)) {
                $metadata[$key] = $this->sanitize($value);
            }
        }

        return $metadata;
    }
}
