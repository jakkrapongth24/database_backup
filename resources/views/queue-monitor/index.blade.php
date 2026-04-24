@extends('layouts.app')

@section('title', 'Queue Monitor | DB Backup')

@section('body')
    <div class="w-full px-4 py-6 sm:px-6 lg:px-10 lg:py-8">
        <header class="flex flex-col gap-5 rounded-[2rem] bg-white p-6 shadow-sm shadow-slate-200/80 lg:flex-row lg:items-center lg:justify-between">
            <div>
                <p class="text-xs font-semibold uppercase tracking-[0.28em] text-emerald-600">Queue Monitor</p>
                <h1 class="mt-3 text-3xl font-semibold tracking-tight text-slate-950">ติดตามสถานะ Queue และ Failed Jobs</h1>
                <p class="mt-2 text-sm leading-6 text-slate-500">ดูงานที่ยังรอ worker, งานที่ล้มเหลว, และสั่ง retry ได้จากหน้าเดียว</p>
            </div>
            <div class="flex flex-col gap-3 sm:flex-row">
                <a href="{{ route('backup-jobs.index', ['status' => 'queued']) }}" class="rounded-2xl border border-slate-200 bg-white px-5 py-3 text-center text-sm font-semibold text-slate-700 transition hover:border-emerald-200 hover:bg-emerald-50">
                    Open Queued Backups
                </a>
                <a href="{{ route('automation-guide') }}" class="rounded-2xl bg-emerald-500 px-5 py-3 text-center text-sm font-semibold text-white shadow-lg shadow-emerald-200 transition hover:-translate-y-0.5 hover:bg-emerald-600">
                    Automation Guide
                </a>
            </div>
        </header>

        <section class="mt-6 grid gap-4 sm:grid-cols-2 xl:grid-cols-4">
            @foreach ([
                ['label' => 'Pending Queue Jobs', 'value' => number_format($pendingJobsCount), 'desc' => 'รายการที่ยังอยู่ในตาราง jobs', 'class' => 'bg-amber-100 text-amber-700'],
                ['label' => 'Reserved Jobs', 'value' => number_format($reservedJobsCount), 'desc' => 'งานที่ worker จับไปแล้ว', 'class' => 'bg-orange-100 text-orange-700'],
                ['label' => 'Failed Jobs', 'value' => number_format($failedJobsCount), 'desc' => 'รายการในตาราง failed_jobs', 'class' => 'bg-rose-100 text-rose-700'],
                ['label' => 'Oldest Pending', 'value' => $oldestPending ? \Illuminate\Support\Carbon::createFromTimestamp($oldestPending)->format('Y-m-d H:i') : '-', 'desc' => 'งานที่ค้างนานที่สุดใน queue', 'class' => 'bg-slate-100 text-slate-700'],
                ['label' => 'Backup Queued', 'value' => number_format($backupQueueSummary['queued']), 'desc' => 'จากตาราง backup_jobs', 'class' => 'bg-yellow-100 text-yellow-700'],
                ['label' => 'Backup Running', 'value' => number_format($backupQueueSummary['running']), 'desc' => 'งาน backup ที่กำลังทำ', 'class' => 'bg-lime-100 text-lime-700'],
                ['label' => 'Backup Failed', 'value' => number_format($backupQueueSummary['failed']), 'desc' => 'ประวัติ backup ที่ fail', 'class' => 'bg-red-100 text-red-700'],
                ['label' => 'Backup Success', 'value' => number_format($backupQueueSummary['success']), 'desc' => 'ประวัติ backup ที่สำเร็จ', 'class' => 'bg-emerald-100 text-emerald-700'],
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
                <h2 class="text-2xl font-semibold text-slate-950">Worker Commands</h2>
                <p class="mt-2 text-sm text-slate-500">ใช้คำสั่งพวกนี้เมื่อ queue ค้างหรืออยาก retry จาก terminal</p>

                <div class="mt-5 space-y-4">
                    <div class="rounded-3xl bg-slate-50 p-4">
                        <p class="text-xs font-semibold uppercase tracking-wider text-slate-500">Start Worker</p>
                        <code class="mt-2 block rounded-2xl bg-slate-950 px-4 py-3 text-sm text-emerald-300">{{ $queueWorkCommand }}</code>
                    </div>
                    <div class="rounded-3xl bg-slate-50 p-4">
                        <p class="text-xs font-semibold uppercase tracking-wider text-slate-500">Retry Failed Job</p>
                        <code class="mt-2 block rounded-2xl bg-slate-950 px-4 py-3 text-sm text-amber-300">{{ $retryFailedCommand }}</code>
                    </div>
                    <div class="rounded-3xl border border-amber-200 bg-amber-50 p-4 text-sm leading-6 text-amber-900">
                        ถ้า backup ขึ้นสถานะ <strong>QUEUED</strong> นานผิดปกติ ให้เช็กหน้านี้ก่อนว่า worker ยังรันอยู่หรือไม่ และดูว่ามี failed jobs ค้างหรือเปล่า
                    </div>
                </div>
            </article>

            <article class="overflow-hidden rounded-[2rem] border border-white bg-white shadow-sm shadow-slate-200/80">
                <div class="p-6">
                    <h2 class="text-2xl font-semibold text-slate-950">Pending Queue Jobs</h2>
                    <p class="mt-2 text-sm text-slate-500">รายการล่าสุดจากตาราง jobs</p>
                </div>
                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-slate-100">
                        <thead class="bg-slate-50">
                            <tr>
                                <th class="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-slate-500">Job</th>
                                <th class="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-slate-500">Queue</th>
                                <th class="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-slate-500">Attempts</th>
                                <th class="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-slate-500">Created</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-slate-100">
                            @forelse ($pendingJobs as $job)
                                <tr class="align-top transition hover:bg-slate-50">
                                    <td class="px-6 py-5">
                                        <p class="font-semibold text-slate-950">{{ $job['display_name'] }}</p>
                                        <p class="mt-1 text-xs text-slate-500">#{{ $job['id'] }}</p>
                                    </td>
                                    <td class="px-6 py-5 text-sm text-slate-600">{{ $job['queue'] }}</td>
                                    <td class="px-6 py-5 text-sm text-slate-600">
                                        {{ $job['attempts'] }}
                                        @if ($job['reserved_at'])
                                            <span class="mt-2 inline-flex rounded-full bg-orange-100 px-3 py-1 text-xs font-semibold text-orange-700">Reserved</span>
                                        @endif
                                    </td>
                                    <td class="px-6 py-5 text-sm text-slate-600">
                                        <div>{{ \Illuminate\Support\Carbon::createFromTimestamp($job['created_at'])->format('Y-m-d H:i:s') }}</div>
                                        <div class="mt-1 text-xs text-slate-500">Available: {{ \Illuminate\Support\Carbon::createFromTimestamp($job['available_at'])->format('Y-m-d H:i:s') }}</div>
                                    </td>
                                </tr>
                            @empty
                                <tr>
                                    <td colspan="4" class="px-6 py-16 text-center text-slate-500">ไม่มี pending jobs ค้างใน queue</td>
                                </tr>
                            @endforelse
                        </tbody>
                    </table>
                </div>
            </article>
        </section>

        <section class="mt-6 overflow-hidden rounded-[2rem] border border-white bg-white shadow-sm shadow-slate-200/80">
            <div class="flex items-center justify-between gap-3 p-6">
                <div>
                    <h2 class="text-2xl font-semibold text-slate-950">Failed Jobs</h2>
                    <p class="mt-2 text-sm text-slate-500">รายการล่าสุดจากตาราง failed_jobs พร้อมปุ่ม retry</p>
                </div>
            </div>
            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-slate-100">
                    <thead class="bg-slate-50">
                        <tr>
                            <th class="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-slate-500">Job</th>
                            <th class="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-slate-500">Queue</th>
                            <th class="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-slate-500">Failed At</th>
                            <th class="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-slate-500">Error</th>
                            <th class="px-6 py-4 text-right text-xs font-semibold uppercase tracking-wider text-slate-500">Action</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-slate-100">
                        @forelse ($failedJobs as $job)
                            <tr class="align-top transition hover:bg-slate-50">
                                <td class="px-6 py-5">
                                    <p class="font-semibold text-slate-950">{{ $job['display_name'] }}</p>
                                    <p class="mt-1 text-xs text-slate-500">#{{ $job['id'] }} · {{ $job['uuid'] }}</p>
                                </td>
                                <td class="px-6 py-5 text-sm text-slate-600">
                                    <div>{{ $job['connection'] }}</div>
                                    <div class="mt-1 text-xs text-slate-500">{{ $job['queue'] }}</div>
                                </td>
                                <td class="px-6 py-5 text-sm text-slate-600">{{ \Illuminate\Support\Carbon::parse($job['failed_at'])->format('Y-m-d H:i:s') }}</td>
                                <td class="px-6 py-5">
                                    <div class="max-w-xl whitespace-pre-wrap break-words text-xs leading-5 text-rose-600">{{ $job['exception_excerpt'] }}</div>
                                </td>
                                <td class="px-6 py-5">
                                    <div class="flex justify-end">
                                        <form method="POST" action="{{ route('queue-monitor.retry', $job['id']) }}" class="js-confirm" data-confirm-title="Retry failed job?" data-confirm-text="ระบบจะส่ง failed job #{{ $job['id'] }} กลับเข้า queue อีกครั้ง">
                                            @csrf
                                            <button class="rounded-xl border border-amber-200 px-4 py-2 text-sm font-semibold text-amber-700 transition hover:bg-amber-50">
                                                Retry
                                            </button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="5" class="px-6 py-16 text-center text-slate-500">ยังไม่มี failed jobs ในระบบ</td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </section>
    </div>
@endsection
