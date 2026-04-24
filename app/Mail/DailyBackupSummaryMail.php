<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;

class DailyBackupSummaryMail extends Mailable
{
    use Queueable;
    use SerializesModels;

    /**
     * @param  array<string, mixed>  $summary
     */
    public function __construct(public array $summary)
    {
    }

    public function envelope(): Envelope
    {
        $dateLabel = $this->summary['period_start']->format('Y-m-d');

        return new Envelope(
            subject: "Daily Backup Summary - {$dateLabel}",
        );
    }

    public function content(): Content
    {
        return new Content(
            view: 'emails.daily-backup-summary',
        );
    }
}
