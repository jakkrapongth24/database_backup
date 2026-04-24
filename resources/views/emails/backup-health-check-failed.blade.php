<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Backup Health Check Failed</title>
</head>
<body style="font-family: Arial, sans-serif; color: #0f172a; line-height: 1.6;">
    <h1 style="margin-bottom: 16px;">{{ $checkType }} failed</h1>

    <p>A backup health check needs attention.</p>

    <table cellpadding="8" cellspacing="0" border="0" style="border-collapse: collapse;">
        <tr>
            <td><strong>Target</strong></td>
            <td>{{ $target->name }}</td>
        </tr>
        <tr>
            <td><strong>Endpoint</strong></td>
            <td>{{ $target->endpoint }}</td>
        </tr>
        <tr>
            <td><strong>Message</strong></td>
            <td>{{ $message }}</td>
        </tr>
        @if ($backupJob)
            <tr>
                <td><strong>Backup Job</strong></td>
                <td>#{{ $backupJob->id }} {{ $backupJob->file_name ?: '-' }}</td>
            </tr>
            <tr>
                <td><strong>Backup File</strong></td>
                <td>{{ $backupJob->file_path ?: '-' }}</td>
            </tr>
        @endif
        @if ($restoreDrill)
            <tr>
                <td><strong>Restore Drill</strong></td>
                <td>#{{ $restoreDrill->id }} {{ strtoupper($restoreDrill->status) }}</td>
            </tr>
            <tr>
                <td><strong>Source</strong></td>
                <td>{{ $restoreDrill->source_name ?: '-' }}</td>
            </tr>
        @endif
    </table>

    <p style="margin-top: 20px;">Please review Backup History, Restore Drills, and Audit Logs for details.</p>
</body>
</html>
