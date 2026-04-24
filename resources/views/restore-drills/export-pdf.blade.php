<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Restore Drill Report PDF</title>
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

    <h1>Restore Drill Report</h1>
    <p class="meta">Date From: {{ $report['dateFrom']->toDateString() }}</p>
    <p class="meta">Date To: {{ $report['dateTo']->toDateString() }}</p>
    <p class="meta">Exported At: {{ $report['exportedAt']->format('Y-m-d H:i:s') }}</p>

    <div class="section">
        <h2>Summary</h2>
        <div class="stats">
            @foreach ([
                'Total' => $report['summary']['total'],
                'Success' => $report['summary']['success'],
                'Failed' => $report['summary']['failed'],
                'Running' => $report['summary']['running'],
            ] as $label => $value)
                <div class="card">
                    <div class="label">{{ $label }}</div>
                    <div class="value">{{ $value }}</div>
                </div>
            @endforeach
        </div>
    </div>

    <div class="section">
        <h2>Drill Results</h2>
        <table>
            <thead>
                <tr>
                    <th>Target</th>
                    <th>Status</th>
                    <th>Backup Job</th>
                    <th>Source</th>
                    <th>Started At</th>
                    <th>Error</th>
                </tr>
            </thead>
            <tbody>
                @forelse ($report['drills'] as $drill)
                    <tr>
                        <td>{{ $drill->target?->name ?? 'Deleted target' }}</td>
                        <td>{{ strtoupper($drill->status) }}</td>
                        <td>{{ $drill->backup_job_id ? '#'.$drill->backup_job_id : '-' }}</td>
                        <td>{{ $drill->source_name ?: '-' }}</td>
                        <td>{{ $drill->started_at?->format('Y-m-d H:i:s') ?? '-' }}</td>
                        <td>{{ $drill->error_message ?: '-' }}</td>
                    </tr>
                @empty
                    <tr>
                        <td colspan="6">No restore drill records found.</td>
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
