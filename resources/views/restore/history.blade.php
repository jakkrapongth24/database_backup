@extends('layouts.app')

@section('title', 'ประวัติ Restore | DB Backup')

@section('body')
    <div class="w-full px-4 py-6 sm:px-6 lg:px-10 lg:py-8">
        <header class="flex flex-col gap-5 rounded-[2rem] bg-white p-6 shadow-sm shadow-slate-200/80 lg:flex-row lg:items-center lg:justify-between">
            <div>
                <p class="text-xs font-semibold uppercase tracking-[0.28em] text-rose-600">Restore History</p>
                <h1 class="mt-3 text-3xl font-semibold tracking-tight text-slate-950">ประวัติการ Restore</h1>
                <p class="mt-2 text-sm leading-6 text-slate-500">ติดตามว่า restore ครั้งไหนสำเร็จ ล้มเหลว ใช้แหล่งข้อมูลใด และมี safety backup อะไรก่อนเริ่มงาน</p>
            </div>
            <a href="{{ route('restore.index', ['target_id' => $filters['target_id'] ?? null]) }}" class="rounded-2xl bg-rose-500 px-5 py-3 text-center text-sm font-semibold text-white shadow-lg shadow-rose-200 transition hover:-translate-y-0.5 hover:bg-rose-600">
                เปิดหน้า Restore
            </a>
        </header>

        <section class="mt-6 grid gap-4 sm:grid-cols-2 xl:grid-cols-5">
            @foreach ([
                ['label' => 'ทั้งหมด', 'value' => $summary['total'], 'class' => 'bg-slate-100 text-slate-700'],
                ['label' => 'รอคิว', 'value' => $summary['queued'], 'class' => 'bg-amber-100 text-amber-700'],
                ['label' => 'กำลังทำงาน', 'value' => $summary['running'], 'class' => 'bg-orange-100 text-orange-700'],
                ['label' => 'สำเร็จ', 'value' => $summary['success'], 'class' => 'bg-emerald-100 text-emerald-700'],
                ['label' => 'ล้มเหลว', 'value' => $summary['failed'], 'class' => 'bg-rose-100 text-rose-700'],
            ] as $item)
                <article class="rounded-[1.75rem] border border-white bg-white p-5 shadow-sm shadow-slate-200/80">
                    <p class="text-sm font-medium text-slate-500">{{ $item['label'] }}</p>
                    <div class="mt-3 flex items-center justify-between">
                        <p class="text-3xl font-semibold text-slate-950">{{ number_format($item['value']) }}</p>
                        <span class="grid h-10 w-10 place-items-center rounded-2xl {{ $item['class'] }}">
                            <span class="h-2.5 w-2.5 rounded-full bg-current"></span>
                        </span>
                    </div>
                </article>
            @endforeach
        </section>

        <section class="mt-6 rounded-[2rem] border border-white bg-white p-5 shadow-sm shadow-slate-200/80">
            <form method="GET" action="{{ route('restore-history.index') }}" class="grid gap-4 lg:grid-cols-[1.3fr_1fr_1fr_1fr_1fr_1fr_auto]">
                <div>
                    <label class="text-sm font-medium text-slate-600">ค้นหา</label>
                    <input name="q" value="{{ $filters['q'] ?? '' }}" placeholder="ชื่อไฟล์, path, error, target" class="mt-2 w-full rounded-2xl border border-slate-200 bg-slate-50 px-4 py-3 text-sm outline-none transition focus:border-rose-300 focus:bg-white">
                </div>
                <div>
                    <label class="text-sm font-medium text-slate-600">Target</label>
                    <select name="target_id" class="mt-2 w-full rounded-2xl border border-slate-200 bg-slate-50 px-4 py-3 text-sm outline-none transition focus:border-rose-300 focus:bg-white">
                        <option value="">ทั้งหมด</option>
                        @foreach ($targets as $target)
                            <option value="{{ $target->id }}" @selected((string) ($filters['target_id'] ?? '') === (string) $target->id)>{{ $target->name }}</option>
                        @endforeach
                    </select>
                </div>
                <div>
                    <label class="text-sm font-medium text-slate-600">สถานะ</label>
                    <select name="status" class="mt-2 w-full rounded-2xl border border-slate-200 bg-slate-50 px-4 py-3 text-sm outline-none transition focus:border-rose-300 focus:bg-white">
                        <option value="">ทั้งหมด</option>
                        @foreach (['queued' => 'Queued', 'running' => 'Running', 'success' => 'Success', 'failed' => 'Failed'] as $value => $label)
                            <option value="{{ $value }}" @selected(($filters['status'] ?? '') === $value)>{{ $label }}</option>
                        @endforeach
                    </select>
                </div>
                <div>
                    <label class="text-sm font-medium text-slate-600">แหล่งข้อมูล</label>
                    <select name="source_type" class="mt-2 w-full rounded-2xl border border-slate-200 bg-slate-50 px-4 py-3 text-sm outline-none transition focus:border-rose-300 focus:bg-white">
                        <option value="">ทั้งหมด</option>
                        <option value="backup_job" @selected(($filters['source_type'] ?? '') === 'backup_job')>Backup Job</option>
                        <option value="upload" @selected(($filters['source_type'] ?? '') === 'upload')>Upload</option>
                    </select>
                </div>
                <div>
                    <label class="text-sm font-medium text-slate-600">ตั้งแต่วันที่</label>
                    <input type="date" name="date_from" value="{{ $filters['date_from'] ?? '' }}" class="mt-2 w-full rounded-2xl border border-slate-200 bg-slate-50 px-4 py-3 text-sm outline-none transition focus:border-rose-300 focus:bg-white">
                </div>
                <div>
                    <label class="text-sm font-medium text-slate-600">ถึงวันที่</label>
                    <input type="date" name="date_to" value="{{ $filters['date_to'] ?? '' }}" class="mt-2 w-full rounded-2xl border border-slate-200 bg-slate-50 px-4 py-3 text-sm outline-none transition focus:border-rose-300 focus:bg-white">
                </div>
                <div class="flex items-end gap-2">
                    <button class="rounded-2xl bg-rose-500 px-5 py-3 text-sm font-semibold text-white transition hover:bg-rose-600">ค้นหา</button>
                    <a href="{{ route('restore-history.index') }}" class="rounded-2xl border border-slate-200 px-5 py-3 text-sm font-semibold text-slate-600 transition hover:bg-slate-50">ล้าง</a>
                </div>
            </form>
        </section>

        <section class="mt-6 overflow-hidden rounded-[2rem] border border-white bg-white shadow-sm shadow-slate-200/80">
            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-slate-100">
                    <thead class="bg-slate-50">
                        <tr>
                            <th class="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-slate-500">Target</th>
                            <th class="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-slate-500">Progress</th>
                            <th class="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-slate-500">สถานะ</th>
                            <th class="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-slate-500">แหล่งข้อมูล</th>
                            <th class="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-slate-500">เวลา</th>
                            <th class="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-slate-500">Safety Backup</th>
                            <th class="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-slate-500">Error</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-slate-100">
                        @forelse ($jobs as $job)
                            <tr class="align-top transition hover:bg-slate-50">
                                <td class="px-6 py-5">
                                    <div class="font-semibold text-slate-950">{{ $job->target?->name ?? 'Deleted target' }}</div>
                                    <div class="mt-1 text-xs text-slate-500">{{ $job->target?->endpoint }}</div>
                                    <div class="mt-2 text-xs text-slate-400">Restore #{{ $job->id }}</div>
                                </td>
                                <td class="px-6 py-5">
                                    <div class="w-48">
                                        <div class="flex items-center justify-between text-xs text-slate-500">
                                            <span>{{ $job->current_step ? str_replace('_', ' ', $job->current_step) : '-' }}</span>
                                            <span>{{ (int) $job->progress_percent }}%</span>
                                        </div>
                                        <div class="mt-2 h-2 rounded-full bg-slate-100">
                                            <div class="h-2 rounded-full {{ $job->status === 'failed' ? 'bg-rose-500' : ($job->status === 'success' ? 'bg-emerald-500' : 'bg-amber-500') }}" style="width: {{ (int) $job->progress_percent }}%"></div>
                                        </div>
                                        <p class="mt-2 max-w-xs text-xs leading-5 text-slate-500">{{ $job->progress_message ?: '-' }}</p>
                                    </div>
                                </td>
                                <td class="px-6 py-5">
                                    <span class="rounded-full px-3 py-1 text-xs font-semibold {{ $job->status === 'success' ? 'bg-emerald-100 text-emerald-700' : ($job->status === 'failed' ? 'bg-rose-100 text-rose-700' : ($job->status === 'queued' ? 'bg-amber-100 text-amber-700' : 'bg-orange-100 text-orange-700')) }}">
                                        {{ strtoupper($job->status) }}
                                    </span>
                                </td>
                                <td class="px-6 py-5">
                                    <div class="text-sm font-semibold text-slate-900">{{ $job->source_type === 'backup_job' ? 'Backup Job' : 'Upload' }}</div>
                                    @if ($job->backupJob)
                                        <a href="{{ route('backup-jobs.index', ['q' => $job->backupJob->file_name]) }}" class="mt-1 block text-xs font-semibold text-emerald-700 hover:text-emerald-800">
                                            Backup #{{ $job->backupJob->id }}
                                        </a>
                                    @endif
                                    <div class="mt-1 max-w-md break-all text-xs text-slate-500">{{ $job->source_name ?: '-' }}</div>
                                    <div class="mt-2 max-w-md break-all text-xs text-slate-400">{{ $job->source_path ?: '-' }}</div>
                                </td>
                                <td class="px-6 py-5 text-sm text-slate-600">
                                    <div class="font-medium text-slate-800">{{ $job->started_at?->format('Y-m-d H:i:s') ?? '-' }}</div>
                                    <div class="mt-1 text-xs text-slate-500">{{ $job->duration_seconds !== null ? $job->duration_seconds.' sec' : '-' }}</div>
                                    @if ($job->finished_at)
                                        <div class="mt-1 text-xs text-slate-400">จบ: {{ $job->finished_at->format('Y-m-d H:i:s') }}</div>
                                    @endif
                                </td>
                                <td class="px-6 py-5 text-sm text-slate-600">
                                    @if ($job->safetyBackupJob)
                                        <a href="{{ route('backup-jobs.index', ['q' => $job->safetyBackupJob->file_name]) }}" class="font-semibold text-emerald-700 hover:text-emerald-800">
                                            Backup #{{ $job->safetyBackupJob->id }}
                                        </a>
                                        <div class="mt-1 max-w-xs break-all text-xs text-slate-500">{{ $job->safetyBackupJob->file_name }}</div>
                                    @else
                                        <span class="text-slate-400">-</span>
                                    @endif
                                </td>
                                <td class="px-6 py-5">
                                    <div class="max-w-xl whitespace-pre-wrap break-words text-xs leading-5 {{ $job->error_message ? 'text-rose-600' : 'text-slate-400' }}">
                                        {{ $job->error_message ?: '-' }}
                                    </div>
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="7" class="px-6 py-16 text-center">
                                    <h2 class="text-2xl font-semibold text-slate-950">ยังไม่มีประวัติ Restore</h2>
                                    <p class="mt-2 text-slate-500">เมื่อมีการ restore ระบบจะแสดงรายการย้อนหลังที่หน้านี้</p>
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
        </section>
    </div>
@endsection
