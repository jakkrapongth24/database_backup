@extends('layouts.app')

@section('title', 'Restore Drills | DB Backup')

@section('body')
    <div class="w-full px-4 py-6 sm:px-6 lg:px-10 lg:py-8">
        <header class="flex flex-col gap-5 rounded-[2rem] bg-white p-6 shadow-sm shadow-slate-200/80 lg:flex-row lg:items-center lg:justify-between">
            <div>
                <p class="text-xs font-semibold uppercase tracking-[0.28em] text-emerald-600">Restore Drills</p>
                <h1 class="mt-3 text-3xl font-semibold tracking-tight text-slate-950">ตรวจความพร้อม Restore</h1>
                <p class="mt-2 text-sm leading-6 text-slate-500">กดปุ่มเดียวเพื่อตรวจว่า backup ล่าสุดพร้อมใช้กู้คืนหรือไม่ โดยยังไม่เขียนทับฐานข้อมูลจริง</p>
            </div>
            <form method="POST" action="{{ route('restore-drills.run') }}" class="grid gap-3 rounded-3xl border border-emerald-100 bg-emerald-50 p-4 sm:min-w-[360px]">
                @csrf
                <label for="run_backup_target_id" class="text-sm font-semibold text-emerald-950">เลือกฐานข้อมูลที่ต้องการตรวจ</label>
                <select id="run_backup_target_id" name="backup_target_id" class="w-full rounded-2xl border border-emerald-200 bg-white px-4 py-3 text-sm outline-none transition focus:border-emerald-400 focus:ring-4 focus:ring-emerald-100">
                    <option value="">ตรวจทุก Target ที่เปิดใช้งาน</option>
                    @foreach ($targets as $target)
                        <option value="{{ $target->id }}">{{ $target->name }}</option>
                    @endforeach
                </select>
                <button class="rounded-2xl bg-emerald-500 px-5 py-3 text-sm font-semibold text-white shadow-lg shadow-emerald-200 transition hover:-translate-y-0.5 hover:bg-emerald-600">
                    ตรวจ Restore ตอนนี้
                </button>
            </form>
        </header>

        <section class="mt-6 rounded-[2rem] border border-sky-100 bg-sky-50 p-5">
            <h2 class="text-lg font-semibold text-sky-950">ใช้หน้านี้แบบง่าย ๆ</h2>
            <div class="mt-3 grid gap-3 text-sm leading-6 text-sky-900 md:grid-cols-3">
                <p><span class="font-semibold">1.</span> เลือก target หรือปล่อยเป็นตรวจทั้งหมด</p>
                <p><span class="font-semibold">2.</span> กดปุ่มตรวจ Restore ตอนนี้</p>
                <p><span class="font-semibold">3.</span> ดูผลด้านล่าง ถ้าขึ้น SUCCESS คือ backup พร้อมใช้</p>
            </div>
        </section>

        <section class="mt-6 flex flex-col gap-3 rounded-[2rem] border border-white bg-white p-5 shadow-sm shadow-slate-200/80 lg:flex-row lg:items-center lg:justify-between">
            <div>
                <h2 class="text-lg font-semibold text-slate-950">ส่งออกรายงาน</h2>
                <p class="mt-1 text-sm text-slate-500">ใช้ตัวกรองด้านล่างร่วมกับ export ได้ เช่น เลือกเฉพาะ target หรือช่วงวันที่</p>
            </div>
            <div class="flex flex-col gap-2 sm:flex-row">
                <a href="{{ route('restore-drills.export.csv', request()->query()) }}" class="rounded-2xl border border-slate-200 bg-white px-5 py-3 text-center text-sm font-semibold text-slate-700 transition hover:border-emerald-200 hover:bg-emerald-50">CSV</a>
                <a href="{{ route('restore-drills.export.excel', request()->query()) }}" class="rounded-2xl border border-slate-200 bg-white px-5 py-3 text-center text-sm font-semibold text-slate-700 transition hover:border-emerald-200 hover:bg-emerald-50">Excel</a>
                <a href="{{ route('restore-drills.export.pdf', request()->query()) }}" target="_blank" rel="noopener" class="rounded-2xl bg-slate-900 px-5 py-3 text-center text-sm font-semibold text-white transition hover:bg-slate-700">PDF</a>
            </div>
        </section>

        <section class="mt-6 grid gap-4 sm:grid-cols-2 xl:grid-cols-4">
            @foreach ([
                ['label' => 'ทั้งหมด', 'value' => $summary['total'], 'class' => 'bg-slate-100 text-slate-700'],
                ['label' => 'ผ่าน', 'value' => $summary['success'], 'class' => 'bg-emerald-100 text-emerald-700'],
                ['label' => 'ไม่ผ่าน', 'value' => $summary['failed'], 'class' => 'bg-rose-100 text-rose-700'],
                ['label' => 'กำลังตรวจ', 'value' => $summary['running'], 'class' => 'bg-orange-100 text-orange-700'],
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
            <form method="GET" action="{{ route('restore-drills.index') }}" class="grid gap-4 lg:grid-cols-[1fr_1fr_1fr_1fr_auto]">
                <div>
                    <label class="text-sm font-medium text-slate-600">Target</label>
                    <select name="target_id" class="mt-2 w-full rounded-2xl border border-slate-200 bg-slate-50 px-4 py-3 text-sm outline-none transition focus:border-emerald-300 focus:bg-white">
                        <option value="">ทั้งหมด</option>
                        @foreach ($targets as $target)
                            <option value="{{ $target->id }}" @selected((string) ($filters['target_id'] ?? '') === (string) $target->id)>{{ $target->name }}</option>
                        @endforeach
                    </select>
                </div>
                <div>
                    <label class="text-sm font-medium text-slate-600">Status</label>
                    <select name="status" class="mt-2 w-full rounded-2xl border border-slate-200 bg-slate-50 px-4 py-3 text-sm outline-none transition focus:border-emerald-300 focus:bg-white">
                        <option value="">ทั้งหมด</option>
                        @foreach (['success' => 'Success', 'failed' => 'Failed', 'running' => 'Running'] as $value => $label)
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
                    <a href="{{ route('restore-drills.index') }}" class="rounded-2xl border border-slate-200 px-5 py-3 text-sm font-semibold text-slate-600 transition hover:bg-slate-50">ล้าง</a>
                </div>
            </form>
        </section>

        <section class="mt-6 space-y-4">
            @forelse ($drills as $drill)
                <article class="rounded-[2rem] border border-white bg-white p-5 shadow-sm shadow-slate-200/80">
                    <div class="flex flex-col gap-4 lg:flex-row lg:items-start lg:justify-between">
                        <div>
                            <div class="flex flex-wrap items-center gap-3">
                                <h2 class="text-lg font-semibold text-slate-950">{{ $drill->target?->name ?? 'Deleted target' }}</h2>
                                <span class="rounded-full px-3 py-1 text-xs font-semibold {{ $drill->status === 'success' ? 'bg-emerald-100 text-emerald-700' : ($drill->status === 'failed' ? 'bg-rose-100 text-rose-700' : 'bg-orange-100 text-orange-700') }}">
                                    {{ strtoupper($drill->status) }}
                                </span>
                            </div>
                            <p class="mt-2 break-all font-mono text-xs text-slate-500">{{ $drill->source_name ?: '-' }}</p>
                            <p class="mt-1 break-all text-xs text-slate-400">{{ $drill->source_path ?: '-' }}</p>
                        </div>
                        <div class="text-sm text-slate-500 lg:text-right">
                            <div>{{ $drill->started_at?->format('Y-m-d H:i:s') ?? '-' }}</div>
                            <div class="mt-1">{{ $drill->duration_seconds !== null ? $drill->duration_seconds.' sec' : '-' }}</div>
                        </div>
                    </div>

                    @if ($drill->error_message)
                        <div class="mt-4 rounded-2xl bg-rose-50 p-4 text-sm text-rose-700">{{ $drill->error_message }}</div>
                    @endif

                    <div class="mt-4 grid gap-3 md:grid-cols-2 xl:grid-cols-3">
                        @foreach (($drill->checks ?? []) as $check)
                            <div class="rounded-2xl border {{ ($check['status'] ?? '') === 'passed' ? 'border-emerald-100 bg-emerald-50' : 'border-rose-100 bg-rose-50' }} p-4">
                                <div class="text-sm font-semibold {{ ($check['status'] ?? '') === 'passed' ? 'text-emerald-900' : 'text-rose-900' }}">{{ $check['label'] ?? '-' }}</div>
                                <div class="mt-1 text-xs leading-5 {{ ($check['status'] ?? '') === 'passed' ? 'text-emerald-700' : 'text-rose-700' }}">{{ $check['message'] ?? '-' }}</div>
                            </div>
                        @endforeach
                    </div>
                </article>
            @empty
                <div class="rounded-[2rem] bg-white p-10 text-center shadow-sm shadow-slate-200/80">
                    <h2 class="text-2xl font-semibold text-slate-950">ยังไม่มีผลตรวจ Restore</h2>
                    <p class="mt-2 text-slate-500">กดปุ่มตรวจ Restore ตอนนี้ด้านบน เพื่อสร้างผลตรวจรายการแรก</p>
                </div>
            @endforelse

            @if ($drills->hasPages())
                <div class="rounded-[2rem] bg-white px-6 py-4 shadow-sm shadow-slate-200/80">
                    {{ $drills->links() }}
                </div>
            @endif
        </section>
    </div>
@endsection
