@extends('layouts.app')

@section('title', $target->name.' | Backup Target')

@section('body')
    <div class="w-full px-4 py-6 sm:px-6 lg:px-10 lg:py-8">
        <header class="flex flex-col gap-5 rounded-[2rem] bg-white p-6 shadow-sm shadow-slate-200/80 lg:flex-row lg:items-start lg:justify-between">
            <div>
                <div class="flex flex-wrap items-center gap-2 text-xs font-semibold uppercase tracking-[0.28em] text-emerald-600">
                    <span>Backup Target</span>
                    <span class="rounded-full bg-slate-100 px-3 py-1 tracking-normal text-slate-600">{{ strtoupper($target->db_type) }}</span>
                    <span class="rounded-full px-3 py-1 tracking-normal {{ $target->is_active ? 'bg-emerald-100 text-emerald-700' : 'bg-slate-100 text-slate-500' }}">
                        {{ $target->is_active ? 'Active' : 'Inactive' }}
                    </span>
                </div>
                <h1 class="mt-3 text-3xl font-semibold tracking-tight text-slate-950">{{ $target->name }}</h1>
                <p class="mt-2 break-all font-mono text-sm text-slate-500">{{ $target->endpoint }}</p>
                @if ($target->description)
                    <p class="mt-3 max-w-3xl text-sm leading-6 text-slate-500">{{ $target->description }}</p>
                @endif
            </div>
            <div class="flex flex-col gap-3 sm:flex-row">
                <a href="{{ route('backup-targets.index') }}" class="rounded-2xl border border-slate-200 bg-white px-5 py-3 text-center text-sm font-semibold text-slate-700 transition hover:border-slate-300 hover:bg-slate-50">
                    Back to Targets
                </a>
                <a href="{{ route('backup-targets.edit', $target) }}" class="rounded-2xl border border-sky-200 bg-sky-50 px-5 py-3 text-center text-sm font-semibold text-sky-700 transition hover:bg-sky-100">
                    Edit
                </a>
                <a href="{{ route('restore.index', ['target_id' => $target->id]) }}" class="rounded-2xl border border-rose-200 bg-rose-50 px-5 py-3 text-center text-sm font-semibold text-rose-700 transition hover:bg-rose-100">
                    Restore
                </a>
                <form method="POST" action="{{ route('backup-targets.backup-now', $target) }}" class="js-confirm" data-confirm-title="Start backup?" data-confirm-text="Queue backup job for {{ $target->name }} now?">
                    @csrf
                    <button class="rounded-2xl bg-emerald-500 px-5 py-3 text-sm font-semibold text-white shadow-lg shadow-emerald-200 transition hover:-translate-y-0.5 hover:bg-emerald-600">
                        Backup Now
                    </button>
                </form>
            </div>
        </header>

        <section class="mt-6 grid gap-4 sm:grid-cols-2 xl:grid-cols-4">
            @foreach ([
                ['label' => 'All Jobs', 'value' => number_format($summary['total']), 'desc' => 'ทั้งหมดของ target นี้', 'class' => 'bg-slate-100 text-slate-700'],
                ['label' => 'Success', 'value' => number_format($summary['success']), 'desc' => 'backup สำเร็จ', 'class' => 'bg-emerald-100 text-emerald-700'],
                ['label' => 'Failed', 'value' => number_format($summary['failed']), 'desc' => 'งานที่ควรตรวจสอบ', 'class' => 'bg-rose-100 text-rose-700'],
                ['label' => 'Queued / Running', 'value' => number_format($summary['queued'] + $summary['running']), 'desc' => 'กำลังรอหรือกำลังทำงาน', 'class' => 'bg-amber-100 text-amber-700'],
                ['label' => 'Total Size', 'value' => $summary['total_size'], 'desc' => 'เฉพาะไฟล์ที่สำเร็จ', 'class' => 'bg-sky-100 text-sky-700'],
                ['label' => 'Last Success', 'value' => $summary['last_success_at']?->format('Y-m-d H:i') ?? '-', 'desc' => 'เวลาที่สำเร็จล่าสุด', 'class' => 'bg-teal-100 text-teal-700'],
                ['label' => 'Last Failed', 'value' => $summary['last_failed_at']?->format('Y-m-d H:i') ?? '-', 'desc' => 'เวลาที่ล้มเหลวล่าสุด', 'class' => 'bg-orange-100 text-orange-700'],
                ['label' => 'Retention', 'value' => number_format($target->retention_days).' days', 'desc' => 'อายุไฟล์ backup', 'class' => 'bg-violet-100 text-violet-700'],
            ] as $item)
                <article class="rounded-[1.75rem] border border-white bg-white p-5 shadow-sm shadow-slate-200/80">
                    <div class="flex items-start justify-between gap-4">
                        <div>
                            <p class="text-sm font-medium text-slate-500">{{ $item['label'] }}</p>
                            <p class="mt-3 text-2xl font-semibold tracking-tight text-slate-950">{{ $item['value'] }}</p>
                        </div>
                        <span class="grid h-11 w-11 place-items-center rounded-2xl {{ $item['class'] }}">
                            <span class="h-2.5 w-2.5 rounded-full bg-current"></span>
                        </span>
                    </div>
                    <p class="mt-3 text-sm text-slate-500">{{ $item['desc'] }}</p>
                </article>
            @endforeach
        </section>

        <section class="mt-6 grid gap-5 xl:grid-cols-[0.95fr_1.05fr]">
            <article class="rounded-[2rem] border border-white bg-white p-6 shadow-sm shadow-slate-200/80">
                <div class="flex items-center justify-between gap-3">
                    <div>
                        <h2 class="text-2xl font-semibold text-slate-950">Target Details</h2>
                        <p class="mt-2 text-sm text-slate-500">ข้อมูลการเชื่อมต่อ ตำแหน่งไฟล์ และการแจ้งเตือน</p>
                    </div>
                    <form method="POST" action="{{ route('backup-targets.test-connection', $target) }}">
                        @csrf
                        <button class="rounded-2xl border border-slate-200 px-4 py-2 text-sm font-semibold text-slate-700 transition hover:border-emerald-200 hover:bg-emerald-50">
                            Test Connection
                        </button>
                    </form>
                </div>

                <dl class="mt-6 grid gap-4 md:grid-cols-2">
                    <div class="rounded-3xl bg-slate-50 p-4">
                        <dt class="text-xs font-semibold uppercase tracking-wider text-slate-500">Host</dt>
                        <dd class="mt-2 text-sm font-medium text-slate-900">{{ $target->host }}</dd>
                    </div>
                    <div class="rounded-3xl bg-slate-50 p-4">
                        <dt class="text-xs font-semibold uppercase tracking-wider text-slate-500">Port</dt>
                        <dd class="mt-2 text-sm font-medium text-slate-900">{{ $target->port }}</dd>
                    </div>
                    <div class="rounded-3xl bg-slate-50 p-4">
                        <dt class="text-xs font-semibold uppercase tracking-wider text-slate-500">Database</dt>
                        <dd class="mt-2 text-sm font-medium text-slate-900">{{ $target->database_name }}</dd>
                    </div>
                    <div class="rounded-3xl bg-slate-50 p-4">
                        <dt class="text-xs font-semibold uppercase tracking-wider text-slate-500">Username</dt>
                        <dd class="mt-2 text-sm font-medium text-slate-900">{{ $target->username }}</dd>
                    </div>
                    <div class="rounded-3xl bg-slate-50 p-4 md:col-span-2">
                        <dt class="text-xs font-semibold uppercase tracking-wider text-slate-500">Backup Path</dt>
                        <dd class="mt-2 break-all text-sm font-medium text-slate-900">{{ $target->backup_path ?: '-' }}</dd>
                    </div>
                    <div class="rounded-3xl bg-slate-50 p-4 md:col-span-2">
                        <dt class="text-xs font-semibold uppercase tracking-wider text-slate-500">Dump Binary</dt>
                        <dd class="mt-2 break-all text-sm font-medium text-slate-900">{{ $target->dump_binary_path ?: 'Auto detect' }}</dd>
                    </div>
                    <div class="rounded-3xl bg-slate-50 p-4">
                        <dt class="text-xs font-semibold uppercase tracking-wider text-slate-500">Schedule</dt>
                        <dd class="mt-2 text-sm font-medium text-slate-900">
                            {{ ucfirst($target->schedule_frequency) }}
                            @if ($target->schedule_time)
                                at {{ substr($target->schedule_time, 0, 5) }}
                            @endif
                        </dd>
                    </div>
                    <div class="rounded-3xl bg-slate-50 p-4">
                        <dt class="text-xs font-semibold uppercase tracking-wider text-slate-500">Notification Emails</dt>
                        <dd class="mt-2 text-sm font-medium text-slate-900">
                            @if ($target->notificationEmailList())
                                {{ implode(', ', $target->notificationEmailList()) }}
                            @else
                                -
                            @endif
                        </dd>
                    </div>
                    <div class="rounded-3xl bg-slate-50 p-4 md:col-span-2">
                        <dt class="text-xs font-semibold uppercase tracking-wider text-slate-500">Last Connection Check</dt>
                        <dd class="mt-2 text-sm font-medium text-slate-900">
                            @if ($target->last_connection_checked_at)
                                {{ $target->last_connection_checked_at->format('Y-m-d H:i:s') }}
                                @if ($target->last_connection_status === true)
                                    <span class="ml-2 rounded-full bg-emerald-100 px-2.5 py-1 text-xs text-emerald-700">OK</span>
                                @elseif ($target->last_connection_status === false)
                                    <span class="ml-2 rounded-full bg-rose-100 px-2.5 py-1 text-xs text-rose-700">Failed</span>
                                @endif
                            @else
                                ยังไม่เคยทดสอบ
                            @endif
                        </dd>
                        @if ($target->last_connection_error)
                            <dd class="mt-3 whitespace-pre-wrap break-words rounded-2xl bg-rose-50 p-3 text-xs leading-5 text-rose-700">{{ $target->last_connection_error }}</dd>
                        @endif
                    </div>
                </dl>
            </article>

            <article class="overflow-hidden rounded-[2rem] border border-white bg-white shadow-sm shadow-slate-200/80">
                <div class="flex items-center justify-between gap-3 p-6">
                    <div>
                        <h2 class="text-2xl font-semibold text-slate-950">Recent Backup History</h2>
                        <p class="mt-2 text-sm text-slate-500">ประวัติ backup ล่าสุดของ target นี้</p>
                    </div>
                    <a href="{{ route('backup-jobs.index', ['target_id' => $target->id]) }}" class="rounded-2xl border border-slate-200 px-4 py-2 text-sm font-semibold text-slate-700 transition hover:border-emerald-200 hover:bg-emerald-50">
                        Open Full History
                    </a>
                </div>

                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-slate-100">
                        <thead class="bg-slate-50">
                            <tr>
                                <th class="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-slate-500">Status</th>
                                <th class="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-slate-500">Started</th>
                                <th class="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-slate-500">File</th>
                                <th class="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-slate-500">Error</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-slate-100">
                            @forelse ($jobs as $job)
                                <tr class="align-top transition hover:bg-slate-50">
                                    <td class="px-6 py-5">
                                        <span class="rounded-full px-3 py-1 text-xs font-semibold {{ $job->status === 'success' ? 'bg-emerald-100 text-emerald-700' : ($job->status === 'failed' ? 'bg-rose-100 text-rose-700' : ($job->status === 'queued' ? 'bg-amber-100 text-amber-700' : 'bg-orange-100 text-orange-700')) }}">
                                            {{ strtoupper($job->status) }}
                                        </span>
                                        <div class="mt-2 text-xs text-slate-500">{{ $job->duration_seconds !== null ? $job->duration_seconds.' sec' : '-' }}</div>
                                    </td>
                                    <td class="px-6 py-5 text-sm text-slate-600">
                                        {{ $job->started_at?->format('Y-m-d H:i:s') ?? '-' }}
                                    </td>
                                    <td class="px-6 py-5 text-sm text-slate-600">
                                        @if ($job->file_path)
                                            <div class="font-mono text-xs font-medium text-emerald-700">{{ $job->file_name }}</div>
                                            <div class="mt-1 break-all text-xs text-slate-500">{{ $job->file_path }}</div>
                                            <div class="mt-2 flex flex-wrap items-center gap-2">
                                                <span class="inline-flex rounded-full bg-slate-100 px-3 py-1 text-xs font-semibold text-slate-600">{{ $job->human_file_size }}</span>
                                                @if ($job->status === 'success')
                                                    <a href="{{ route('backup-jobs.download', $job) }}" class="inline-flex rounded-full bg-emerald-100 px-3 py-1 text-xs font-semibold text-emerald-700 transition hover:bg-emerald-200">
                                                        Download
                                                    </a>
                                                @endif
                                            </div>
                                        @else
                                            <span class="text-sm text-slate-400">{{ $job->status === 'queued' ? 'Waiting for queue worker' : '-' }}</span>
                                        @endif
                                    </td>
                                    <td class="px-6 py-5">
                                        <div class="max-w-md whitespace-pre-wrap break-words text-xs leading-5 {{ $job->error_message ? 'text-rose-600' : 'text-slate-400' }}">
                                            {{ $job->error_message ?: '-' }}
                                        </div>
                                    </td>
                                </tr>
                            @empty
                                <tr>
                                    <td colspan="4" class="px-6 py-16 text-center text-slate-500">
                                        ยังไม่มีประวัติ backup สำหรับ target นี้
                                    </td>
                                </tr>
                            @endforelse
                        </tbody>
                    </table>
                </div>

                @if ($jobs->hasPages())
                    <div class="border-t border-slate-100 px-6 py-4">
                        {{ $jobs->links() }}
                    </div>
                @endif
            </article>
        </section>
    </div>
@endsection
