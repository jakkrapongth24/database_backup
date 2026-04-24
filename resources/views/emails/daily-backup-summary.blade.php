@php
    $stats = $summary['stats'];
    $failedTargets = $summary['failed_targets'];
    $missingTargets = $summary['missing_targets'];
@endphp

<h1>Daily Backup Summary</h1>

<p>
    Period:
    {{ $summary['period_start']->format('Y-m-d H:i:s') }}
    to
    {{ $summary['period_end']->format('Y-m-d H:i:s') }}
</p>

<h2>Summary</h2>
<ul>
    <li>Total jobs: {{ $stats['total'] }}</li>
    <li>Queued: {{ $stats['queued'] }}</li>
    <li>Running: {{ $stats['running'] }}</li>
    <li>Success: {{ $stats['success'] }}</li>
    <li>Failed: {{ $stats['failed'] }}</li>
    <li>Success rate: {{ $stats['success_rate'] }}%</li>
    <li>Total size: {{ $stats['total_size'] }}</li>
    <li>Average duration: {{ $stats['avg_duration'] }} sec</li>
</ul>

<h2>Targets With Failures</h2>
@if ($failedTargets->isEmpty())
    <p>No targets failed during this period.</p>
@else
    <ul>
        @foreach ($failedTargets as $item)
            <li>
                {{ $item['target']->name }} ({{ $item['target']->endpoint }}) :
                failed {{ $item['failed_jobs_count'] }} time(s),
                success {{ $item['success_jobs_count'] }} time(s)
            </li>
        @endforeach
    </ul>
@endif

<h2>Scheduled Targets Without Backup</h2>
@if ($missingTargets->isEmpty())
    <p>All scheduled targets had at least one backup job in this period.</p>
@else
    <ul>
        @foreach ($missingTargets as $item)
            <li>
                {{ $item['target']->name }} ({{ $item['target']->endpoint }}) :
                schedule {{ $item['schedule_label'] }}
            </li>
        @endforeach
    </ul>
@endif
