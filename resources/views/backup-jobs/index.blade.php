@extends('layouts.app')

@section('title', 'Backup History | DB Backup')

@section('body')
    <div class="w-full px-4 py-6 sm:px-6 lg:px-10 lg:py-8">
        <header class="flex flex-col gap-5 rounded-[2rem] bg-white p-6 shadow-sm shadow-slate-200/80 lg:flex-row lg:items-center lg:justify-between">
            <div>
                <p class="text-xs font-semibold uppercase tracking-[0.28em] text-emerald-600">Backup History</p>
                <h1 class="mt-3 text-3xl font-semibold tracking-tight text-slate-950">ประวัติการ Backup</h1>
                <p class="mt-2 text-sm leading-6 text-slate-500">ค้นหา กรองสถานะ เลือกช่วงวันที่ และตรวจสอบ error ล่าสุดได้จากหน้านี้</p>
            </div>
            <div class="flex flex-col gap-3 sm:flex-row">
                <a href="{{ route('reports.index') }}" class="rounded-2xl border border-slate-200 bg-white px-5 py-3 text-center text-sm font-semibold text-slate-700 transition hover:border-emerald-200 hover:bg-emerald-50">Reports</a>
                <a href="{{ route('backup-targets.index') }}" class="rounded-2xl bg-emerald-500 px-5 py-3 text-center text-sm font-semibold text-white shadow-lg shadow-emerald-200 transition hover:-translate-y-0.5 hover:bg-emerald-600">Backup Targets</a>
            </div>
        </header>

        <section class="mt-6 grid gap-4 sm:grid-cols-2 xl:grid-cols-4">
            @foreach ([
                ['label' => 'ทั้งหมด', 'value' => $summary['total'], 'class' => 'bg-slate-100 text-slate-700'],
                ['label' => 'รอคิว', 'value' => $summary['queued'], 'class' => 'bg-amber-100 text-amber-700'],
                ['label' => 'สำเร็จ', 'value' => $summary['success'], 'class' => 'bg-emerald-100 text-emerald-700'],
                ['label' => 'ล้มเหลว', 'value' => $summary['failed'], 'class' => 'bg-rose-100 text-rose-700'],
                ['label' => 'กำลังทำงาน', 'value' => $summary['running'], 'class' => 'bg-orange-100 text-orange-700'],
                ['label' => 'Verify ผ่าน', 'value' => $summary['verified'], 'class' => 'bg-cyan-100 text-cyan-700'],
                ['label' => 'Verify ไม่ผ่าน', 'value' => $summary['verification_failed'], 'class' => 'bg-red-100 text-red-700'],
                ['label' => 'Offsite สำเร็จ', 'value' => $summary['offsite_copied'], 'class' => 'bg-indigo-100 text-indigo-700'],
                ['label' => 'Offsite ล้มเหลว', 'value' => $summary['offsite_failed'], 'class' => 'bg-pink-100 text-pink-700'],
            ] as $item)
                <article class="rounded-[1.75rem] border border-white bg-white p-5 shadow-sm shadow-slate-200/80">
                    <p class="text-sm font-medium text-slate-500">{{ $item['label'] }}</p>
                    <div class="mt-3 flex items-center justify-between">
                        <p class="text-3xl font-semibold text-slate-950">{{ number_format($item['value']) }}</p>
                        <span class="grid h-10 w-10 place-items-center rounded-2xl {{ $item['class'] }}"><span class="h-2.5 w-2.5 rounded-full bg-current"></span></span>
                    </div>
                </article>
            @endforeach
        </section>

        <section class="mt-6 rounded-[2rem] border border-white bg-white p-5 shadow-sm shadow-slate-200/80">
            <form method="GET" action="{{ route('backup-jobs.index') }}" class="grid gap-4 lg:grid-cols-[1.3fr_1fr_1fr_1fr_1fr_auto]">
                <div>
                    <label class="text-sm font-medium text-slate-600">ค้นหา</label>
                    <input name="q" value="{{ $filters['q'] ?? '' }}" placeholder="ชื่อระบบ, ชื่อไฟล์, error" class="mt-2 w-full rounded-2xl border border-slate-200 bg-slate-50 px-4 py-3 text-sm outline-none transition focus:border-emerald-300 focus:bg-white">
                </div>
                <div>
                    <label class="text-sm font-medium text-slate-600">Target</label>
                    <select name="target_id" class="mt-2 w-full rounded-2xl border border-slate-200 bg-slate-50 px-4 py-3 text-sm outline-none transition focus:border-emerald-300 focus:bg-white">
                        <option value="">ทั้งหมด</option>
                        @foreach ($targets as $target)
                            <option value="{{ $target->getRouteKey() }}" @selected((string) ($filters['target_id'] ?? '') === (string) $target->id)>{{ $target->name }}</option>
                        @endforeach
                    </select>
                </div>
                <div>
                    <label class="text-sm font-medium text-slate-600">Status</label>
                    <select name="status" class="mt-2 w-full rounded-2xl border border-slate-200 bg-slate-50 px-4 py-3 text-sm outline-none transition focus:border-emerald-300 focus:bg-white">
                        <option value="">ทั้งหมด</option>
                        @foreach (['queued' => 'Queued', 'success' => 'Success', 'failed' => 'Failed', 'running' => 'Running'] as $value => $label)
                            <option value="{{ $value }}" @selected(($filters['status'] ?? '') === $value)>{{ $label }}</option>
                        @endforeach
                    </select>
                </div>
                <div>
                    <label class="text-sm font-medium text-slate-600">ตั้งแต่วันที่</label>
                    <input type="date" name="date_from" value="{{ $filters['date_from'] ?? '' }}" class="mt-2 w-full rounded-2xl border border-slate-200 bg-slate-50 px-4 py-3 text-sm outline-none transition focus:border-emerald-300 focus:bg-white">
                </div>
                <div>
                    <label class="text-sm font-medium text-slate-600">ถึงวันที่</label>
                    <input type="date" name="date_to" value="{{ $filters['date_to'] ?? '' }}" class="mt-2 w-full rounded-2xl border border-slate-200 bg-slate-50 px-4 py-3 text-sm outline-none transition focus:border-emerald-300 focus:bg-white">
                </div>
                <div class="flex items-end gap-2">
                    <button class="rounded-2xl bg-emerald-500 px-5 py-3 text-sm font-semibold text-white transition hover:bg-emerald-600">ค้นหา</button>
                    <a href="{{ route('backup-jobs.index') }}" class="rounded-2xl border border-slate-200 px-5 py-3 text-sm font-semibold text-slate-600 transition hover:bg-slate-50">ล้าง</a>
                </div>
            </form>
        </section>

        <section class="mt-6 overflow-hidden rounded-[2rem] border border-white bg-white shadow-sm shadow-slate-200/80">
            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-slate-100">
                    <thead class="bg-slate-50">
                        <tr>
                            <th class="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-slate-500">Target</th>
                            <th class="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-slate-500">Status</th>
                            <th class="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-slate-500">File</th>
                            <th class="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-slate-500">Time</th>
                            <th class="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-slate-500">Error</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-slate-100">
                        @forelse ($jobs as $job)
                            <tr class="align-top transition hover:bg-slate-50">
                                <td class="px-6 py-5">
                                    <div class="font-semibold text-slate-950">{{ $job->target?->name ?? 'Deleted target' }}</div>
                                    <div class="mt-1 text-xs text-slate-500">{{ $job->target?->endpoint }}</div>
                                    <div class="mt-2 break-all text-xs text-slate-400">{{ $job->dump_binary_path }}</div>
                                </td>
                                <td class="px-6 py-5">
                                    <span class="rounded-full px-3 py-1 text-xs font-semibold {{ $job->status === 'success' ? 'bg-emerald-100 text-emerald-700' : ($job->status === 'failed' ? 'bg-rose-100 text-rose-700' : ($job->status === 'queued' ? 'bg-amber-100 text-amber-700' : 'bg-orange-100 text-orange-700')) }}">{{ strtoupper($job->status) }}</span>
                                </td>
                                <td class="px-6 py-5">
                                    @if ($job->file_path)
                                        <div class="font-mono text-xs font-medium text-emerald-700">{{ $job->file_name }}</div>
                                        <div class="mt-1 max-w-md break-all text-xs text-slate-500">{{ $job->file_path }}</div>
                                        <div class="mt-2 flex flex-wrap items-center gap-2">
                                            <div class="inline-flex rounded-full bg-slate-100 px-3 py-1 text-xs font-semibold text-slate-600">{{ $job->human_file_size }}</div>
                                            @if ($job->verification_status)
                                                <div class="inline-flex rounded-full px-3 py-1 text-xs font-semibold {{ $job->verification_status === 'passed' ? 'bg-cyan-100 text-cyan-700' : 'bg-red-100 text-red-700' }}">VERIFY {{ strtoupper($job->verification_status) }}</div>
                                            @endif
                                            @if ($job->offsite_status)
                                                <div class="inline-flex rounded-full px-3 py-1 text-xs font-semibold {{ $job->offsite_status === 'copied' ? 'bg-indigo-100 text-indigo-700' : ($job->offsite_status === 'failed' ? 'bg-pink-100 text-pink-700' : 'bg-slate-100 text-slate-600') }}">OFFSITE {{ strtoupper($job->offsite_status) }}</div>
                                            @endif
                                            @if ($job->status === 'success')
                                                <a href="{{ route('backup-jobs.download', $job) }}" class="inline-flex rounded-full bg-emerald-100 px-3 py-1 text-xs font-semibold text-emerald-700 transition hover:bg-emerald-200">Download</a>
                                                @if ($job->target)
                                                    <a href="{{ route('restore.index', ['target_id' => $job->target->getRouteKey()]) }}" class="inline-flex rounded-full bg-rose-100 px-3 py-1 text-xs font-semibold text-rose-700 transition hover:bg-rose-200">Restore</a>
                                                @endif
                                            @endif
                                        </div>
                                        @if ($job->verification_message)
                                            <div class="mt-2 max-w-md break-words text-xs text-slate-500">{{ $job->verification_message }}</div>
                                        @endif
                                        @if ($job->offsite_path || $job->offsite_message)
                                            <div class="mt-2 max-w-md break-words text-xs text-slate-500">{{ $job->offsite_path ?: $job->offsite_message }}</div>
                                        @endif
                                    @else
                                        <span class="text-sm text-slate-400">{{ $job->status === 'queued' ? 'Waiting for queue worker' : '-' }}</span>
                                    @endif
                                </td>
                                <td class="px-6 py-5 text-sm text-slate-600">
                                    <div class="font-medium text-slate-800">{{ $job->started_at?->format('Y-m-d H:i:s') ?? '-' }}</div>
                                    <div class="mt-1 text-xs text-slate-500">{{ $job->duration_seconds !== null ? $job->duration_seconds.' sec' : '-' }}</div>
                                </td>
                                <td class="px-6 py-5">
                                    <div class="max-w-xl whitespace-pre-wrap break-words text-xs leading-5 {{ $job->error_message ? 'text-rose-600' : 'text-slate-400' }}">{{ $job->error_message ?: '-' }}</div>
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="5" class="px-6 py-16 text-center">
                                    <h2 class="text-2xl font-semibold text-slate-950">ไม่พบประวัติ Backup</h2>
                                    <p class="mt-2 text-slate-500">ลองปรับตัวกรอง หรือเริ่มจากกด Backup Now ในหน้า Backup Targets</p>
                                </td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>

            @if ($jobs->hasPages())
                <div class="border-t border-slate-100 px-6 py-4">{{ $jobs->links() }}</div>
            @endif
        </section>
    </div>
@endsection
