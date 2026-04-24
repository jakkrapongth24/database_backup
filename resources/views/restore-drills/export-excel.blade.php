<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Restore Drill Report</title>
</head>
<body>
    <table border="1">
        <tr>
            <th colspan="2">Restore Drill Report</th>
        </tr>
        <tr>
            <td>Date From</td>
            <td>{{ $report['dateFrom']->toDateString() }}</td>
        </tr>
        <tr>
            <td>Date To</td>
            <td>{{ $report['dateTo']->toDateString() }}</td>
        </tr>
        <tr>
            <td>Exported At</td>
            <td>{{ $report['exportedAt']->format('Y-m-d H:i:s') }}</td>
        </tr>
    </table>

    <br>

    <table border="1">
        <tr>
            <th>Total</th>
            <th>Success</th>
            <th>Failed</th>
            <th>Running</th>
        </tr>
        <tr>
            <td>{{ $report['summary']['total'] }}</td>
            <td>{{ $report['summary']['success'] }}</td>
            <td>{{ $report['summary']['failed'] }}</td>
            <td>{{ $report['summary']['running'] }}</td>
        </tr>
    </table>

    <br>

    <table border="1">
        <tr>
            <th>Target</th>
            <th>Status</th>
            <th>Backup Job</th>
            <th>Source</th>
            <th>Started At</th>
            <th>Duration</th>
            <th>Error</th>
            <th>Checks</th>
        </tr>
        @foreach ($report['drills'] as $drill)
            <tr>
                <td>{{ $drill->target?->name ?? 'Deleted target' }}</td>
                <td>{{ strtoupper($drill->status) }}</td>
                <td>{{ $drill->backup_job_id ? '#'.$drill->backup_job_id : '-' }}</td>
                <td>{{ $drill->source_name ?: '-' }}</td>
                <td>{{ $drill->started_at?->format('Y-m-d H:i:s') ?? '-' }}</td>
                <td>{{ $drill->duration_seconds !== null ? $drill->duration_seconds.' sec' : '-' }}</td>
                <td>{{ $drill->error_message ?: '-' }}</td>
                <td>
                    @foreach (($drill->checks ?? []) as $check)
                        {{ $check['label'] ?? '-' }}: {{ strtoupper($check['status'] ?? '-') }} - {{ $check['message'] ?? '-' }}<br>
                    @endforeach
                </td>
            </tr>
        @endforeach
    </table>
</body>
</html>
