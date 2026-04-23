<?php

namespace App\Mail;

use App\Models\BackupJob;
use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;

class BackupFailedMail extends Mailable
{
    use Queueable, SerializesModels;

    public function __construct(public BackupJob $backupJob)
    {
    }

    public function envelope(): Envelope
    {
        $targetName = $this->backupJob->target?->name ?? 'Unknown Target';

        return new Envelope(
            subject: "[DB Backup] Failed: {$targetName}",
        );
    }

    public function content(): Content
    {
        return new Content(
            view: 'emails.backup-failed',
        );
    }
}
