<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Backup Failed</title>
</head>
<body style="font-family: Arial, sans-serif; color: #0f172a; line-height: 1.6;">
    <h1 style="margin-bottom: 16px;">Backup failed</h1>

    <p>The backup job could not be completed.</p>

    <table cellpadding="8" cellspacing="0" border="0" style="border-collapse: collapse;">
        <tr>
            <td><strong>Target</strong></td>
            <td>{{ $backupJob->target?->name ?? 'Unknown target' }}</td>
        </tr>
        <tr>
            <td><strong>Endpoint</strong></td>
            <td>{{ $backupJob->target?->endpoint ?? '-' }}</td>
        </tr>
        <tr>
            <td><strong>Status</strong></td>
            <td>{{ strtoupper($backupJob->status) }}</td>
        </tr>
        <tr>
            <td><strong>Started At</strong></td>
            <td>{{ $backupJob->started_at?->format('Y-m-d H:i:s') ?? '-' }}</td>
        </tr>
        <tr>
            <td><strong>Finished At</strong></td>
            <td>{{ $backupJob->finished_at?->format('Y-m-d H:i:s') ?? '-' }}</td>
        </tr>
        <tr>
            <td><strong>Duration</strong></td>
            <td>{{ $backupJob->duration_seconds !== null ? $backupJob->duration_seconds.' sec' : '-' }}</td>
        </tr>
        <tr>
            <td><strong>Dump Binary</strong></td>
            <td>{{ $backupJob->dump_binary_path ?: '-' }}</td>
        </tr>
        <tr>
            <td><strong>Error</strong></td>
            <td>{{ $backupJob->error_message ?: '-' }}</td>
        </tr>
    </table>

    <p style="margin-top: 20px;">Please review the target configuration, credentials, dump tool path, and storage path.</p>
</body>
</html>
