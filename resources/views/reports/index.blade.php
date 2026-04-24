@extends('layouts.app')

@section('title', 'Reports | DB Backup')

@section('body')
    <div class="w-full px-4 py-6 sm:px-6 lg:px-10 lg:py-8">
        <header class="flex flex-col gap-5 rounded-[2rem] bg-white p-6 shadow-sm shadow-slate-200/80 lg:flex-row lg:items-center lg:justify-between">
            <div>
                <p class="text-xs font-semibold uppercase tracking-[0.28em] text-emerald-600">Reports</p>
                <h1 class="mt-3 text-3xl font-semibold tracking-tight text-slate-950">รายงานภาพรวม Backup</h1>
                <p class="mt-2 text-sm leading-6 text-slate-500">สรุปอัตราสำเร็จ ขนาดไฟล์รวม รายวัน และระบบที่ควรตรวจสอบ พร้อม export เป็น CSV ได้ทันที</p>
            </div>
            <div class="flex flex-col gap-3 sm:flex-row">
                <a href="{{ route('reports.export.csv', ['date_from' => $dateFrom, 'date_to' => $dateTo]) }}" class="rounded-2xl border border-slate-200 bg-white px-5 py-3 text-center text-sm font-semibold text-slate-700 transition hover:border-emerald-200 hover:bg-emerald-50">
                    Export CSV
                </a>
                <a href="{{ route('reports.export.excel', ['date_from' => $dateFrom, 'date_to' => $dateTo]) }}" class="rounded-2xl border border-slate-200 bg-white px-5 py-3 text-center text-sm font-semibold text-slate-700 transition hover:border-emerald-200 hover:bg-emerald-50">
                    Export Excel
                </a>
                <a href="{{ route('reports.export.pdf', ['date_from' => $dateFrom, 'date_to' => $dateTo]) }}" target="_blank" rel="noopener" class="rounded-2xl border border-slate-200 bg-white px-5 py-3 text-center text-sm font-semibold text-slate-700 transition hover:border-emerald-200 hover:bg-emerald-50">
                    Export PDF
                </a>
                <a href="{{ route('backup-jobs.index') }}" class="rounded-2xl bg-emerald-500 px-5 py-3 text-center text-sm font-semibold text-white shadow-lg shadow-emerald-200 transition hover:-translate-y-0.5 hover:bg-emerald-600">
                    ดูประวัติ Backup
                </a>
            </div>
        </header>

        <section class="mt-6 rounded-[2rem] border border-white bg-white p-5 shadow-sm shadow-slate-200/80">
            <form method="GET" action="{{ route('reports.index') }}" class="grid gap-4 md:grid-cols-[1fr_1fr_auto]">
                <div>
                    <label class="text-sm font-medium text-slate-600">ตั้งแต่วันที่</label>
                    <input type="date" name="date_from" value="{{ $dateFrom }}" class="mt-2 w-full rounded-2xl border border-slate-200 bg-slate-50 px-4 py-3 text-sm outline-none transition focus:border-emerald-300 focus:bg-white">
                </div>
                <div>
                    <label class="text-sm font-medium text-slate-600">ถึงวันที่</label>
                    <input type="date" name="date_to" value="{{ $dateTo }}" class="mt-2 w-full rounded-2xl border border-slate-200 bg-slate-50 px-4 py-3 text-sm outline-none transition focus:border-emerald-300 focus:bg-white">
                </div>
                <div class="flex items-end gap-2">
                    <button class="rounded-2xl bg-emerald-500 px-5 py-3 text-sm font-semibold text-white transition hover:bg-emerald-600">ดูรายงาน</button>
                    <a href="{{ route('reports.index') }}" class="rounded-2xl border border-slate-200 px-5 py-3 text-sm font-semibold text-slate-600 transition hover:bg-slate-50">รีเซ็ต</a>
                </div>
            </form>
        </section>

        <section class="mt-6 grid gap-4 sm:grid-cols-2 xl:grid-cols-4">
            @foreach ([
                ['label' => 'งานทั้งหมด', 'value' => number_format($stats['total']), 'desc' => 'ในช่วงวันที่ที่เลือก', 'class' => 'bg-slate-100 text-slate-700'],
                ['label' => 'Success Rate', 'value' => $stats['success_rate'].'%', 'desc' => number_format($stats['success']).' สำเร็จ', 'class' => 'bg-emerald-100 text-emerald-700'],
                ['label' => 'Failed', 'value' => number_format($stats['failed']), 'desc' => 'งานที่ควรตรวจสอบ', 'class' => 'bg-rose-100 text-rose-700'],
                ['label' => 'ขนาดไฟล์รวม', 'value' => $stats['total_size'], 'desc' => 'เฉพาะ backup สำเร็จ', 'class' => 'bg-sky-100 text-sky-700'],
                ['label' => 'เวลาเฉลี่ย', 'value' => $stats['avg_duration'].' sec', 'desc' => 'เวลาที่ใช้ต่อ backup', 'class' => 'bg-violet-100 text-violet-700'],
                ['label' => 'Targets', 'value' => number_format($stats['targets']), 'desc' => 'ระบบทั้งหมด', 'class' => 'bg-teal-100 text-teal-700'],
                ['label' => 'ควรตรวจสอบ', 'value' => number_format($stats['stale_targets']), 'desc' => 'ไม่มี success ตาม retention', 'class' => 'bg-amber-100 text-amber-700'],
                ['label' => 'Running', 'value' => number_format($stats['running']), 'desc' => 'กำลังทำงาน', 'class' => 'bg-lime-100 text-lime-700'],
            ] as $item)
                <article class="rounded-[1.75rem] border border-white bg-white p-5 shadow-sm shadow-slate-200/80">
                    <div class="flex items-start justify-between gap-4">
                        <div>
                            <p class="text-sm font-medium text-slate-500">{{ $item['label'] }}</p>
                            <p class="mt-3 text-3xl font-semibold tracking-tight text-slate-950">{{ $item['value'] }}</p>
                        </div>
                        <span class="grid h-11 w-11 place-items-center rounded-2xl {{ $item['class'] }}">
                            <span class="h-2.5 w-2.5 rounded-full bg-current"></span>
                        </span>
                    </div>
                    <p class="mt-3 text-sm text-slate-500">{{ $item['desc'] }}</p>
                </article>
            @endforeach
        </section>

        <section class="mt-6 grid gap-5 xl:grid-cols-[0.9fr_1.3fr]">
            <article class="rounded-[2rem] border border-white bg-white p-6 shadow-sm shadow-slate-200/80">
                <h2 class="text-2xl font-semibold text-slate-950">รายวันล่าสุด</h2>
                <div class="mt-5 space-y-3">
                    @forelse ($daily as $day)
                        <div class="rounded-3xl border border-slate-100 bg-slate-50 p-4">
                            <div class="flex items-center justify-between gap-4">
                                <p class="font-semibold text-slate-950">{{ $day['date'] }}</p>
                                <p class="text-sm font-medium text-slate-500">{{ $day['size'] }}</p>
                            </div>
                            <div class="mt-3 grid grid-cols-3 gap-2 text-sm">
                                <span class="rounded-2xl bg-white px-3 py-2 text-slate-600">Total {{ $day['total'] }}</span>
                                <span class="rounded-2xl bg-emerald-100 px-3 py-2 text-emerald-700">Success {{ $day['success'] }}</span>
                                <span class="rounded-2xl bg-rose-100 px-3 py-2 text-rose-700">Failed {{ $day['failed'] }}</span>
                            </div>
                        </div>
                    @empty
                        <p class="rounded-3xl bg-slate-50 p-6 text-center text-sm text-slate-500">ยังไม่มีข้อมูลในช่วงวันที่ที่เลือก</p>
                    @endforelse
                </div>
            </article>

            <article class="overflow-hidden rounded-[2rem] border border-white bg-white shadow-sm shadow-slate-200/80">
                <div class="p-6">
                    <h2 class="text-2xl font-semibold text-slate-950">สรุปตาม Target</h2>
                    <p class="mt-2 text-sm text-slate-500">ดูระบบที่ error บ่อย หรือไม่มี backup สำเร็จตามช่วง retention</p>
                </div>
                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-slate-100">
                        <thead class="bg-slate-50">
                            <tr>
                                <th class="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-slate-500">Target</th>
                                <th class="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-slate-500">Result</th>
                                <th class="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-slate-500">Size</th>
                                <th class="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-slate-500">Latest</th>
                                <th class="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-slate-500">Health</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-slate-100">
                            @forelse ($targetSummaries as $row)
                                <tr class="align-top transition hover:bg-slate-50">
                                    <td class="px-6 py-5">
                                        <p class="font-semibold text-slate-950">{{ $row['target']->name }}</p>
                                        <p class="mt-1 text-xs text-slate-500">{{ $row['target']->endpoint }}</p>
                                    </td>
                                    <td class="px-6 py-5 text-sm text-slate-600">
                                        <p>{{ $row['total'] }} jobs</p>
                                        <p class="mt-1 text-emerald-700">{{ $row['success'] }} success</p>
                                        <p class="mt-1 text-rose-700">{{ $row['failed'] }} failed</p>
                                        <p class="mt-1 text-xs text-slate-500">{{ $row['success_rate'] }}% success rate</p>
                                    </td>
                                    <td class="px-6 py-5 text-sm text-slate-600">{{ $row['size'] }}</td>
                                    <td class="px-6 py-5 text-sm text-slate-600">
                                        <p>Success: {{ $row['latest_success_at']?->format('Y-m-d H:i') ?? '-' }}</p>
                                        <p class="mt-1">Failed: {{ $row['latest_failed_at']?->format('Y-m-d H:i') ?? '-' }}</p>
                                    </td>
                                    <td class="px-6 py-5">
                                        <span class="rounded-full px-3 py-1 text-xs font-semibold {{ $row['is_stale'] ? 'bg-amber-100 text-amber-700' : 'bg-emerald-100 text-emerald-700' }}">
                                            {{ $row['is_stale'] ? 'Check' : 'OK' }}
                                        </span>
                                    </td>
                                </tr>
                            @empty
                                <tr>
                                    <td colspan="5" class="px-6 py-16 text-center text-slate-500">ยังไม่มี target ในระบบ</td>
                                </tr>
                            @endforelse
                        </tbody>
                    </table>
                </div>
            </article>
        </section>
    </div>
@endsection
