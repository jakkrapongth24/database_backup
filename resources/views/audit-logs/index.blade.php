@extends('layouts.app')

@section('title', 'Audit Logs | DB Backup')

@section('body')
    <div class="w-full px-4 py-6 sm:px-6 lg:px-10 lg:py-8">
        <header class="flex flex-col gap-5 rounded-[2rem] bg-white p-6 shadow-sm shadow-slate-200/80 lg:flex-row lg:items-center lg:justify-between">
            <div>
                <p class="text-xs font-semibold uppercase tracking-[0.28em] text-emerald-600">Audit Logs</p>
                <h1 class="mt-3 text-3xl font-semibold tracking-tight text-slate-950">ประวัติการใช้งานระบบ</h1>
                <p class="mt-2 text-sm leading-6 text-slate-500">ตรวจสอบว่าใครทำอะไร เมื่อไหร่ จาก IP ไหน และเกี่ยวข้องกับข้อมูลใด</p>
            </div>
            <a href="{{ route('reports.index') }}" class="rounded-2xl bg-emerald-500 px-5 py-3 text-center text-sm font-semibold text-white shadow-lg shadow-emerald-200 transition hover:-translate-y-0.5 hover:bg-emerald-600">
                Reports
            </a>
        </header>

        <section class="mt-6 grid gap-4 sm:grid-cols-2 xl:grid-cols-4">
            @foreach ([
                ['label' => 'ทั้งหมด', 'value' => $summary['total'], 'class' => 'bg-slate-100 text-slate-700'],
                ['label' => 'วันนี้', 'value' => $summary['today'], 'class' => 'bg-emerald-100 text-emerald-700'],
                ['label' => 'ผู้ใช้งาน', 'value' => $summary['users'], 'class' => 'bg-sky-100 text-sky-700'],
                ['label' => 'Action Types', 'value' => $summary['actions'], 'class' => 'bg-amber-100 text-amber-700'],
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
            <form method="GET" action="{{ route('audit-logs.index') }}" class="grid gap-4 lg:grid-cols-[1.4fr_1fr_1fr_1fr_auto]">
                <div>
                    <label class="text-sm font-medium text-slate-600">ค้นหา</label>
                    <input name="q" value="{{ $filters['q'] ?? '' }}" placeholder="user, description, metadata, IP" class="mt-2 w-full rounded-2xl border border-slate-200 bg-slate-50 px-4 py-3 text-sm outline-none transition focus:border-emerald-300 focus:bg-white">
                </div>
                <div>
                    <label class="text-sm font-medium text-slate-600">Action</label>
                    <select name="action" class="mt-2 w-full rounded-2xl border border-slate-200 bg-slate-50 px-4 py-3 text-sm outline-none transition focus:border-emerald-300 focus:bg-white">
                        <option value="">ทั้งหมด</option>
                        @foreach ($actions as $action)
                            <option value="{{ $action }}" @selected(($filters['action'] ?? '') === $action)>{{ $action }}</option>
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
                    <a href="{{ route('audit-logs.index') }}" class="rounded-2xl border border-slate-200 px-5 py-3 text-sm font-semibold text-slate-600 transition hover:bg-slate-50">ล้าง</a>
                </div>
            </form>
        </section>

        <section class="mt-6 overflow-hidden rounded-[2rem] border border-white bg-white shadow-sm shadow-slate-200/80">
            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-slate-100">
                    <thead class="bg-slate-50">
                        <tr>
                            <th class="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-slate-500">เวลา</th>
                            <th class="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-slate-500">Action</th>
                            <th class="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-slate-500">ผู้ใช้งาน</th>
                            <th class="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-slate-500">รายละเอียด</th>
                            <th class="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-slate-500">Metadata</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-slate-100">
                        @forelse ($logs as $log)
                            <tr class="align-top transition hover:bg-slate-50">
                                <td class="whitespace-nowrap px-6 py-5 text-sm text-slate-600">
                                    <p class="font-medium text-slate-800">{{ $log->created_at?->format('Y-m-d H:i:s') }}</p>
                                    <p class="mt-1 text-xs text-slate-400">{{ $log->ip_address ?: '-' }}</p>
                                </td>
                                <td class="px-6 py-5">
                                    <span class="rounded-full bg-slate-100 px-3 py-1 text-xs font-semibold text-slate-700">{{ $log->action }}</span>
                                    @if ($log->auditable_type)
                                        <p class="mt-2 text-xs text-slate-400">{{ class_basename($log->auditable_type) }} #{{ $log->auditable_id }}</p>
                                    @endif
                                </td>
                                <td class="px-6 py-5 text-sm text-slate-600">
                                    <p class="font-medium text-slate-800">{{ $log->user_name ?: 'System' }}</p>
                                    <p class="mt-1 text-xs text-slate-400">ID: {{ $log->user_id ?: '-' }}</p>
                                </td>
                                <td class="px-6 py-5">
                                    <p class="max-w-md text-sm leading-6 text-slate-600">{{ $log->description ?: '-' }}</p>
                                    @if ($log->user_agent)
                                        <p class="mt-2 max-w-md truncate text-xs text-slate-400">{{ $log->user_agent }}</p>
                                    @endif
                                </td>
                                <td class="px-6 py-5">
                                    @if ($log->metadata)
                                        <pre class="max-w-xl overflow-x-auto rounded-2xl bg-slate-50 p-3 text-xs leading-5 text-slate-600">{{ json_encode($log->metadata, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES) }}</pre>
                                    @else
                                        <span class="text-sm text-slate-400">-</span>
                                    @endif
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="5" class="px-6 py-16 text-center">
                                    <h2 class="text-2xl font-semibold text-slate-950">ยังไม่มี Audit Log</h2>
                                    <p class="mt-2 text-slate-500">เมื่อมีการใช้งานระบบ รายการจะเริ่มแสดงที่นี่</p>
                                </td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>

            @if ($logs->hasPages())
                <div class="border-t border-slate-100 px-6 py-4">
                    {{ $logs->links() }}
                </div>
            @endif
        </section>
    </div>
@endsection
