<?php

namespace App\Mail;

use App\Models\BackupJob;
use App\Models\BackupTarget;
use App\Models\RestoreDrill;
use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;

class BackupHealthCheckFailedMail extends Mailable
{
    use Queueable, SerializesModels;

    public function __construct(
        public string $checkType,
        public BackupTarget $target,
        public string $message,
        public ?BackupJob $backupJob = null,
        public ?RestoreDrill $restoreDrill = null,
    ) {}

    public function envelope(): Envelope
    {
        return new Envelope(
            subject: "[DB Backup] {$this->checkType} failed: {$this->target->name}",
        );
    }

    public function content(): Content
    {
        return new Content(
            view: 'emails.backup-health-check-failed',
        );
    }
}
