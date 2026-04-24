<?php

namespace App\Services;

use App\Mail\BackupHealthCheckFailedMail;
use App\Models\BackupJob;
use App\Models\BackupTarget;
use App\Models\RestoreDrill;
use Illuminate\Support\Facades\Mail;
use Throwable;

class BackupHealthAlertService
{
    public function send(
        string $checkType,
        BackupTarget $target,
        string $message,
        ?BackupJob $backupJob = null,
        ?RestoreDrill $restoreDrill = null,
        ?int $userId = null,
    ): void {
        $recipients = $this->resolveRecipients($target);

        if ($recipients === []) {
            return;
        }

        try {
            Mail::to($recipients)->send(new BackupHealthCheckFailedMail(
                checkType: $checkType,
                target: $target,
                message: $message,
                backupJob: $backupJob,
                restoreDrill: $restoreDrill,
            ));

            app(AuditLogger::class)->log('backup.health_notification_sent', "{$checkType} notification sent for {$target->name}.", $backupJob ?: $restoreDrill ?: $target, [
                'check_type' => $checkType,
                'target' => $target->name,
                'recipients' => $recipients,
                'message' => $message,
            ], $userId);
        } catch (Throwable $exception) {
            app(AuditLogger::class)->log('backup.health_notification_failed', "{$checkType} notification could not be sent for {$target->name}.", $backupJob ?: $restoreDrill ?: $target, [
                'check_type' => $checkType,
                'target' => $target->name,
                'recipients' => $recipients,
                'message' => $message,
                'error' => $exception->getMessage(),
            ], $userId);
        }
    }

    /**
     * @return array<int, string>
     */
    private function resolveRecipients(BackupTarget $target): array
    {
        $targetRecipients = $target->notificationEmailList();

        if ($targetRecipients !== []) {
            return $targetRecipients;
        }

        return collect(preg_split('/[\r\n,;]+/', (string) env('BACKUP_ALERT_EMAILS')) ?: [])
            ->map(fn (string $email): string => trim($email))
            ->filter()
            ->unique()
            ->values()
            ->all();
    }
}
