@extends('layouts.app')

@section('title', 'Backup Targets | DB Backup')

@section('body')
    <div class="w-full px-4 py-6 sm:px-6 lg:px-10 lg:py-8">
        <header class="flex flex-col gap-5 rounded-[2rem] bg-white p-6 shadow-sm shadow-slate-200/80 lg:flex-row lg:items-center lg:justify-between">
            <div>
                <p class="text-xs font-black uppercase tracking-[0.28em] text-emerald-600">Backup Targets</p>
                <h1 class="mt-3 text-3xl font-black tracking-tight text-slate-950">จัดการระบบที่จะ Backup</h1>
                <p class="mt-2 text-sm leading-6 text-slate-500">เพิ่มฐานข้อมูล MariaDB/MySQL ทดสอบ connection และกด backup ได้จากหน้านี้</p>
            </div>
            <div class="flex flex-col gap-3 sm:flex-row">
                <a href="{{ route('backup-jobs.index') }}" class="rounded-2xl border border-slate-200 bg-white px-5 py-3 text-center text-sm font-black text-slate-700 transition hover:border-emerald-200 hover:bg-emerald-50">
                    ประวัติ Backup
                </a>
                <a href="{{ route('backup-targets.create') }}" class="rounded-2xl bg-emerald-500 px-5 py-3 text-center text-sm font-black text-white shadow-lg shadow-emerald-200 transition hover:-translate-y-0.5 hover:bg-emerald-600">
                    เพิ่มระบบใหม่
                </a>
            </div>
        </header>

        <section class="mt-6 overflow-hidden rounded-[2rem] border border-white bg-white shadow-sm shadow-slate-200/80">
            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-slate-100">
                    <thead class="bg-slate-50">
                        <tr>
                            <th class="px-6 py-4 text-left text-xs font-black uppercase tracking-wider text-slate-500">ระบบ</th>
                            <th class="px-6 py-4 text-left text-xs font-black uppercase tracking-wider text-slate-500">Endpoint</th>
                            <th class="px-6 py-4 text-left text-xs font-black uppercase tracking-wider text-slate-500">Schedule</th>
                            <th class="px-6 py-4 text-left text-xs font-black uppercase tracking-wider text-slate-500">สถานะ</th>
                            <th class="px-6 py-4 text-right text-xs font-black uppercase tracking-wider text-slate-500">จัดการ</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-slate-100">
                        @forelse ($targets as $target)
                            <tr class="align-top transition hover:bg-emerald-50/40">
                                <td class="px-6 py-5">
                                    <div class="flex items-start gap-3">
                                        <div class="grid h-11 w-11 shrink-0 place-items-center rounded-2xl bg-emerald-100 font-black text-emerald-700">
                                            DB
                                        </div>
                                        <div>
                                            <a href="{{ route('backup-targets.show', $target) }}" class="font-black text-slate-950 transition hover:text-emerald-600">{{ $target->name }}</a>
                                            <div class="mt-1 text-sm text-slate-500">{{ strtoupper($target->db_type) }} · {{ $target->username }}</div>
                                        </div>
                                    </div>
                                </td>
                                <td class="px-6 py-5">
                                    <div class="font-mono text-sm font-bold text-slate-800">{{ $target->endpoint }}</div>
                                    <div class="mt-1 text-xs text-slate-500">เก็บย้อนหลัง {{ $target->retention_days }} วัน</div>
                                </td>
                                <td class="px-6 py-5 text-sm text-slate-600">
                                    <span class="rounded-full bg-slate-100 px-3 py-1 text-xs font-black text-slate-700">{{ ucfirst($target->schedule_frequency) }}</span>
                                    @if ($target->schedule_time)
                                        <div class="mt-2 text-xs text-slate-500">เวลา {{ substr($target->schedule_time, 0, 5) }}</div>
                                    @endif
                                    @if (in_array($target->id, $dueTargetIds ?? [], true))
                                        <div class="mt-2 inline-flex rounded-full bg-amber-100 px-3 py-1 text-xs font-bold text-amber-700">Due now</div>
                                    @endif
                                </td>
                                <td class="px-6 py-5">
                                    <div>
                                        <span class="rounded-full px-3 py-1 text-xs font-black {{ $target->is_active ? 'bg-emerald-100 text-emerald-700' : 'bg-slate-100 text-slate-500' }}">
                                            {{ $target->is_active ? 'Active' : 'Inactive' }}
                                        </span>
                                    </div>
                                    <div class="mt-3 text-xs">
                                        @if ($target->last_connection_status === true)
                                            <span class="font-bold text-emerald-600">Connection OK</span>
                                        @elseif ($target->last_connection_status === false)
                                            <span class="font-bold text-rose-600">Connection Failed</span>
                                        @else
                                            <span class="text-slate-400">ยังไม่ได้ทดสอบ</span>
                                        @endif
                                    </div>
                                </td>
                                <td class="px-6 py-5">
                                    <div class="flex flex-wrap justify-end gap-2">
                                        <form method="POST" action="{{ route('backup-targets.backup-now', $target) }}" class="js-confirm" data-confirm-title="เริ่ม Backup?" data-confirm-text="ระบบจะเริ่ม backup {{ $target->name }} ทันที">
                                            @csrf
                                            <button class="rounded-xl bg-emerald-500 px-4 py-2 text-sm font-black text-white transition hover:bg-emerald-600">
                                                Backup Now
                                            </button>
                                        </form>
                                        <form method="POST" action="{{ route('backup-targets.test-connection', $target) }}">
                                            @csrf
                                            <button class="rounded-xl border border-slate-200 px-4 py-2 text-sm font-black text-slate-700 transition hover:border-emerald-200 hover:bg-emerald-50">
                                                Test
                                            </button>
                                        </form>
                                        <a href="{{ route('backup-targets.edit', $target) }}" class="rounded-xl border border-slate-200 px-4 py-2 text-center text-sm font-black text-slate-700 transition hover:border-sky-200 hover:bg-sky-50">
                                            Edit
                                        </a>
                                        <a href="{{ route('backup-targets.show', $target) }}" class="rounded-xl border border-slate-200 px-4 py-2 text-center text-sm font-black text-slate-700 transition hover:border-emerald-200 hover:bg-emerald-50">
                                            Detail
                                        </a>
                                        <form method="POST" action="{{ route('backup-targets.destroy', $target) }}" class="js-confirm" data-confirm-title="ลบระบบนี้?" data-confirm-text="การลบ {{ $target->name }} จะลบประวัติ backup ของ target นี้ด้วย">
                                            @csrf
                                            @method('DELETE')
                                            <button class="rounded-xl border border-rose-200 px-4 py-2 text-sm font-black text-rose-600 transition hover:bg-rose-50">
                                                Delete
                                            </button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="5" class="px-6 py-16 text-center">
                                    <div class="mx-auto grid h-16 w-16 place-items-center rounded-3xl bg-emerald-100 text-2xl font-black text-emerald-700">DB</div>
                                    <h2 class="mt-5 text-2xl font-black text-slate-950">ยังไม่มีระบบที่ต้อง Backup</h2>
                                    <p class="mt-2 text-slate-500">เริ่มจากเพิ่มฐานข้อมูลแรก เช่น HOSxP, HR, Finance หรือระบบภายในอื่น ๆ</p>
                                    <a href="{{ route('backup-targets.create') }}" class="mt-6 inline-flex rounded-2xl bg-emerald-500 px-5 py-3 text-sm font-black text-white transition hover:bg-emerald-600">
                                        เพิ่มระบบแรก
                                    </a>
                                </td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>

            @if ($targets->hasPages())
                <div class="border-t border-slate-100 px-6 py-4">
                    {{ $targets->links() }}
                </div>
            @endif
        </section>
    </div>
@endsection
