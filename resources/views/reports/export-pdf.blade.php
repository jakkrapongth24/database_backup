<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>DB Backup Report PDF</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 32px; color: #0f172a; }
        h1, h2 { margin: 0 0 12px; }
        p { margin: 0 0 8px; }
        .section { margin-top: 28px; }
        .meta { color: #475569; font-size: 14px; }
        .stats { display: grid; grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 10px; margin-top: 16px; }
        .card { border: 1px solid #cbd5e1; border-radius: 12px; padding: 12px 14px; }
        .label { font-size: 12px; text-transform: uppercase; color: #64748b; margin-bottom: 6px; }
        .value { font-size: 18px; font-weight: bold; }
        table { width: 100%; border-collapse: collapse; margin-top: 14px; }
        th, td { border: 1px solid #cbd5e1; padding: 8px; text-align: left; vertical-align: top; font-size: 12px; }
        th { background: #f8fafc; }
        .hint { margin-top: 16px; font-size: 12px; color: #64748b; }
        @media print {
            .print-bar { display: none; }
            body { margin: 16px; }
        }
    </style>
</head>
<body>
    <div class="print-bar">
        <button onclick="window.print()">Print / Save as PDF</button>
        <p class="hint">Use your browser print dialog and choose "Save as PDF".</p>
    </div>

    <h1>DB Backup Report</h1>
    <p class="meta">Date From: {{ $report['dateFrom']->toDateString() }}</p>
    <p class="meta">Date To: {{ $report['dateTo']->toDateString() }}</p>
    <p class="meta">Exported At: {{ $report['exportedAt']->format('Y-m-d H:i:s') }}</p>

    <div class="section">
        <h2>Summary</h2>
        <div class="stats">
            @foreach ([
                'Total Jobs' => $report['stats']['total'],
                'Success' => $report['stats']['success'],
                'Failed' => $report['stats']['failed'],
                'Running' => $report['stats']['running'],
                'Success Rate (%)' => $report['stats']['success_rate'],
                'Total Size' => $report['stats']['total_size'],
                'Average Duration (sec)' => $report['stats']['avg_duration'],
                'Stale Targets' => $report['stats']['stale_targets'],
            ] as $label => $value)
                <div class="card">
                    <div class="label">{{ $label }}</div>
                    <div class="value">{{ $value }}</div>
                </div>
            @endforeach
        </div>
    </div>

    <div class="section">
        <h2>Daily Summary</h2>
        <table>
            <thead>
                <tr>
                    <th>Date</th>
                    <th>Total</th>
                    <th>Success</th>
                    <th>Failed</th>
                    <th>Total Size</th>
                </tr>
            </thead>
            <tbody>
                @forelse ($report['daily'] as $day)
                    <tr>
                        <td>{{ $day['date'] }}</td>
                        <td>{{ $day['total'] }}</td>
                        <td>{{ $day['success'] }}</td>
                        <td>{{ $day['failed'] }}</td>
                        <td>{{ $day['size'] }}</td>
                    </tr>
                @empty
                    <tr>
                        <td colspan="5">No data in selected period.</td>
                    </tr>
                @endforelse
            </tbody>
        </table>
    </div>

    <div class="section">
        <h2>Target Summary</h2>
        <table>
            <thead>
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
                    <th>Health</th>
                </tr>
            </thead>
            <tbody>
                @forelse ($report['targetSummaries'] as $row)
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
                        <td>{{ $row['is_stale'] ? 'Check' : 'OK' }}</td>
                    </tr>
                @empty
                    <tr>
                        <td colspan="10">No targets found.</td>
                    </tr>
                @endforelse
            </tbody>
        </table>
    </div>

    <script>
        window.addEventListener('load', () => {
            window.print();
        });
    </script>
</body>
</html>
