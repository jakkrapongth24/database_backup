<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>DB Backup Report</title>
</head>
<body>
    <table border="1">
        <tr>
            <th colspan="2">DB Backup Report</th>
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
            <th colspan="2">Summary</th>
        </tr>
        @foreach ([
            'Total Jobs' => $report['stats']['total'],
            'Success' => $report['stats']['success'],
            'Failed' => $report['stats']['failed'],
            'Running' => $report['stats']['running'],
            'Success Rate (%)' => $report['stats']['success_rate'],
            'Total Size' => $report['stats']['total_size'],
            'Average Duration (sec)' => $report['stats']['avg_duration'],
            'Targets' => $report['stats']['targets'],
            'Stale Targets' => $report['stats']['stale_targets'],
        ] as $label => $value)
            <tr>
                <td>{{ $label }}</td>
                <td>{{ $value }}</td>
            </tr>
        @endforeach
    </table>

    <br>

    <table border="1">
        <tr>
            <th colspan="5">Daily Summary</th>
        </tr>
        <tr>
            <th>Date</th>
            <th>Total</th>
            <th>Success</th>
            <th>Failed</th>
            <th>Total Size</th>
        </tr>
        @foreach ($report['daily'] as $day)
            <tr>
                <td>{{ $day['date'] }}</td>
                <td>{{ $day['total'] }}</td>
                <td>{{ $day['success'] }}</td>
                <td>{{ $day['failed'] }}</td>
                <td>{{ $day['size'] }}</td>
            </tr>
        @endforeach
    </table>

    <br>

    <table border="1">
        <tr>
            <th colspan="9">Target Summary</th>
        </tr>
        <tr>
            <th>Target</th>
            <th>Endpoint</th>
            <th>Total Jobs</th>
            <th>Success</th>
            <th>Failed</th>
            <th>Success Rate (%)</th>
            <th>Total Size</th>
            <th>Latest Success</th>
            <th>Latest Failed</th>
        </tr>
        @foreach ($report['targetSummaries'] as $row)
            <tr>
                <td>{{ $row['target']->name }}</td>
                <td>{{ $row['target']->endpoint }}</td>
                <td>{{ $row['total'] }}</td>
                <td>{{ $row['success'] }}</td>
                <td>{{ $row['failed'] }}</td>
                <td>{{ $row['success_rate'] }}</td>
                <td>{{ $row['size'] }}</td>
                <td>{{ $row['latest_success_at']?->format('Y-m-d H:i:s') ?? '-' }}</td>
                <td>{{ $row['latest_failed_at']?->format('Y-m-d H:i:s') ?? '-' }}</td>
            </tr>
        @endforeach
    </table>
</body>
</html>
