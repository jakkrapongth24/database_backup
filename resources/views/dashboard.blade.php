@extends('layouts.app')

@section('title', 'Dashboard | DB Backup')

@section('body')
    <div class="w-full px-4 py-6 sm:px-6 lg:px-10 lg:py-8">
        <section class="overflow-hidden rounded-[2rem] bg-[#0b2f28] text-white shadow-2xl shadow-emerald-950/20">
            <div class="relative p-6 sm:p-8 lg:p-10">
                <div class="absolute inset-y-0 right-0 hidden w-1/2 bg-[radial-gradient(circle_at_center,_rgba(52,211,153,0.35),_transparent_55%)] lg:block"></div>
                <div class="relative max-w-3xl">
                    <p class="text-xs font-semibold uppercase tracking-[0.32em] text-emerald-300">Admin Dashboard</p>
                    <h1 class="mt-4 text-3xl font-semibold tracking-tight sm:text-4xl lg:text-5xl">ศูนย์กลางจัดการ Backup</h1>
                    <p class="mt-4 max-w-2xl text-base leading-7 text-emerald-50/80">
                        ดูสถานะระบบทั้งหมด ตั้งค่า backup อัตโนมัติ ตรวจงานที่ถึงรอบ และติดตามผลการสำรองข้อมูลได้จากจุดเดียว
                    </p>
                    <div class="mt-6 flex flex-col gap-3 sm:flex-row">
                        <a href="{{ route('backup-targets.index') }}" class="rounded-2xl bg-emerald-400 px-5 py-3 text-center text-sm font-semibold text-emerald-950 shadow-lg shadow-emerald-950/30 transition hover:-translate-y-0.5 hover:bg-emerald-300">
                            จัดการ Backup Targets
                        </a>
                        <a href="{{ route('backup-jobs.index') }}" class="rounded-2xl border border-white/15 bg-white/10 px-5 py-3 text-center text-sm font-medium text-white transition hover:-translate-y-0.5 hover:bg-white/15">
                            ดูประวัติ Backup
                        </a>
                    </div>
                </div>
            </div>
        </section>

        <section class="mt-6 grid gap-4 sm:grid-cols-2 xl:grid-cols-4">
            @foreach ([
                ['title' => 'Targets ทั้งหมด', 'value' => $stats['targets'], 'desc' => 'ระบบที่ลงทะเบียนไว้', 'badge' => 'bg-emerald-100 text-emerald-700'],
                ['title' => 'Targets ที่เปิดใช้งาน', 'value' => $stats['activeTargets'], 'desc' => 'ระบบที่พร้อม backup', 'badge' => 'bg-sky-100 text-sky-700'],
                ['title' => 'ตั้งเวลาแล้ว', 'value' => $stats['scheduledTargets'], 'desc' => 'มี schedule backup อัตโนมัติ', 'badge' => 'bg-violet-100 text-violet-700'],
                ['title' => 'ถึงรอบ Backup', 'value' => $stats['dueTargets'], 'desc' => 'ควรเริ่ม backup แล้ว', 'badge' => 'bg-amber-100 text-amber-700'],
                ['title' => 'เชื่อมต่อสำเร็จ', 'value' => $stats['connectionOk'], 'desc' => 'ทดสอบ connection ผ่าน', 'badge' => 'bg-lime-100 text-lime-700'],
                ['title' => 'เชื่อมต่อล้มเหลว', 'value' => $stats['connectionFailed'], 'desc' => 'ควรตรวจสอบ target', 'badge' => 'bg-rose-100 text-rose-700'],
                ['title' => 'Backup รอคิว', 'value' => $stats['queuedBackups'], 'desc' => 'รอ queue worker ประมวลผล', 'badge' => 'bg-amber-100 text-amber-700'],
                ['title' => 'Backup กำลังทำงาน', 'value' => $stats['runningBackups'], 'desc' => 'กำลังสร้างไฟล์ backup', 'badge' => 'bg-orange-100 text-orange-700'],
                ['title' => 'Backup สำเร็จ', 'value' => $stats['successfulBackups'], 'desc' => 'งานที่สำเร็จทั้งหมด', 'badge' => 'bg-teal-100 text-teal-700'],
                ['title' => 'Backup ล้มเหลว', 'value' => $stats['failedBackups'], 'desc' => 'งานที่ควรตรวจสอบ', 'badge' => 'bg-red-100 text-red-700'],
            ] as $item)
                <article class="rounded-[1.75rem] border border-white bg-white p-6 shadow-sm shadow-slate-200/80">
                    <div class="flex items-start justify-between gap-4">
                        <div>
                            <p class="text-sm font-medium text-slate-500">{{ $item['title'] }}</p>
                            <p class="mt-3 text-4xl font-semibold tracking-tight text-slate-950">{{ number_format($item['value']) }}</p>
                        </div>
                        <span class="grid h-12 w-12 place-items-center rounded-2xl {{ $item['badge'] }}">
                            <span class="h-2.5 w-2.5 rounded-full bg-current"></span>
                        </span>
                    </div>
                    <p class="mt-4 text-sm text-slate-500">{{ $item['desc'] }}</p>
                </article>
            @endforeach
        </section>

        @if ($dueTargets->isNotEmpty())
            <section class="mt-6 rounded-[2rem] border border-amber-200 bg-amber-50 p-6 shadow-sm shadow-amber-100/80">
                <div class="flex flex-col gap-4 lg:flex-row lg:items-center lg:justify-between">
                    <div>
                        <p class="text-sm font-semibold uppercase tracking-[0.22em] text-amber-700">Scheduled Backup</p>
                        <h2 class="mt-2 text-2xl font-semibold text-slate-950">มีระบบที่ถึงรอบ Backup แล้ว</h2>
                        <p class="mt-2 text-sm leading-6 text-amber-900/70">
                            ถ้าตั้ง Windows Task Scheduler แล้ว ระบบจะเรียก schedule อัตโนมัติ ถ้าต้องการตรวจด้วยมือให้ดูที่ Automation Guide
                        </p>
                    </div>
                    <a href="{{ route('backup-targets.index') }}" class="rounded-2xl bg-amber-500 px-5 py-3 text-center text-sm font-semibold text-white shadow-lg shadow-amber-200 transition hover:-translate-y-0.5 hover:bg-amber-600">
                        ดู Targets
                    </a>
                </div>
                <div class="mt-5 grid gap-3 md:grid-cols-2 xl:grid-cols-3">
                    @foreach ($dueTargets as $target)
                        <div class="rounded-3xl bg-white p-4">
                            <p class="font-semibold text-slate-950">{{ $target->name }}</p>
                            <p class="mt-1 text-sm text-slate-500">{{ $target->endpoint }}</p>
                            <p class="mt-2 text-xs font-medium text-amber-700">{{ ucfirst($target->schedule_frequency) }} เวลา {{ substr((string) ($target->schedule_time ?: '00:00'), 0, 5) }}</p>
                        </div>
                    @endforeach
                </div>
            </section>
        @endif

        <section class="mt-6 grid gap-5 xl:grid-cols-[1.4fr_1fr]">
            <article class="rounded-[2rem] border border-white bg-white p-6 shadow-sm shadow-slate-200/80">
                <div class="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
                    <div>
                        <p class="text-sm font-semibold uppercase tracking-[0.22em] text-emerald-600">Quick Actions</p>
                        <h2 class="mt-2 text-2xl font-semibold text-slate-950">งานที่ใช้บ่อย</h2>
                    </div>
                </div>

                <div class="mt-6 grid gap-4 md:grid-cols-2">
                    <a href="{{ route('backup-targets.create') }}" class="group rounded-3xl border border-slate-200 bg-slate-50 p-5 transition hover:-translate-y-1 hover:border-emerald-200 hover:bg-emerald-50">
                        <p class="text-lg font-semibold text-slate-950">เพิ่มระบบใหม่</p>
                        <p class="mt-2 text-sm leading-6 text-slate-500">เพิ่มฐานข้อมูล MariaDB/MySQL ที่ต้องการให้ระบบดูแล backup</p>
                    </a>
                    <a href="{{ route('backup-targets.index') }}" class="group rounded-3xl border border-slate-200 bg-slate-50 p-5 transition hover:-translate-y-1 hover:border-emerald-200 hover:bg-emerald-50">
                        <p class="text-lg font-semibold text-slate-950">Backup Now</p>
                        <p class="mt-2 text-sm leading-6 text-slate-500">เลือก target แล้วกด backup ได้ทันที พร้อมเก็บประวัติการทำงาน</p>
                    </a>
                    <a href="{{ route('backup-jobs.index') }}" class="group rounded-3xl border border-slate-200 bg-slate-50 p-5 transition hover:-translate-y-1 hover:border-emerald-200 hover:bg-emerald-50">
                        <p class="text-lg font-semibold text-slate-950">ตรวจสอบประวัติ</p>
                        <p class="mt-2 text-sm leading-6 text-slate-500">ดูผลสำเร็จ ล้มเหลว ขนาดไฟล์ และ error ล่าสุด</p>
                    </a>
                    <a href="{{ route('reports.index') }}" class="group rounded-3xl border border-slate-200 bg-slate-50 p-5 transition hover:-translate-y-1 hover:border-emerald-200 hover:bg-emerald-50">
                        <p class="text-lg font-semibold text-slate-950">Reports</p>
                        <p class="mt-2 text-sm leading-6 text-slate-500">ดู success rate, ขนาดไฟล์, รายวัน และ target ที่ควรตรวจสอบ</p>
                    </a>
                </div>

                <div class="mt-6 rounded-3xl border border-amber-200 bg-amber-50 p-5">
                    <div class="flex flex-col gap-4 lg:flex-row lg:items-start lg:justify-between">
                        <div>
                            <p class="text-lg font-semibold text-slate-950">ล้างไฟล์ Backup หมดอายุ</p>
                            <p class="mt-2 text-sm leading-6 text-amber-900/80">กดตรวจดูก่อนเพื่อดูรายการที่จะถูกลบ ระบบจะลบทั้งไฟล์ในเครื่องและไฟล์ offsite ที่อยู่ใต้ BACKUP_OFFSITE_PATH ตาม retention ของแต่ละ target</p>
                        </div>
                        <div class="flex flex-col gap-2 sm:flex-row">
                            <form method="POST" action="{{ route('backup-cleanup.preview') }}">
                                @csrf
                                <button class="w-full rounded-2xl border border-amber-200 bg-white px-5 py-3 text-sm font-semibold text-amber-800 transition hover:bg-amber-100">
                                    ตรวจไฟล์หมดอายุ
                                </button>
                            </form>
                            <form method="POST" action="{{ route('backup-cleanup.destroy') }}" class="js-confirm" data-confirm-title="ลบไฟล์ Backup หมดอายุ?" data-confirm-text="ระบบจะลบไฟล์ local/offsite ที่หมดอายุตาม retention และลบ record ที่เกี่ยวข้อง">
                                @csrf
                                @method('DELETE')
                                <input type="hidden" name="confirm_cleanup" value="1">
                                <button class="w-full rounded-2xl bg-rose-500 px-5 py-3 text-sm font-semibold text-white shadow-lg shadow-rose-200 transition hover:bg-rose-600">
                                    ลบไฟล์หมดอายุ
                                </button>
                            </form>
                        </div>
                    </div>

                    @if (session('cleanup_result'))
                        @php($cleanup = session('cleanup_result'))
                        <div class="mt-5 rounded-3xl bg-white p-5">
                            <div class="grid gap-3 sm:grid-cols-2 xl:grid-cols-5">
                                @foreach ([
                                    ['label' => 'พบรายการ', 'value' => $cleanup['checked']],
                                    ['label' => 'ลบไฟล์ local', 'value' => $cleanup['deleted_files']],
                                    ['label' => 'ลบไฟล์ offsite', 'value' => $cleanup['deleted_offsite_files']],
                                    ['label' => 'ลบ record', 'value' => $cleanup['deleted_records']],
                                    ['label' => 'คืนพื้นที่', 'value' => number_format($cleanup['freed_bytes']).' B'],
                                ] as $item)
                                    <div class="rounded-2xl bg-slate-50 p-4">
                                        <p class="text-xs font-semibold text-slate-500">{{ $item['label'] }}</p>
                                        <p class="mt-2 text-xl font-semibold text-slate-950">{{ $item['value'] }}</p>
                                    </div>
                                @endforeach
                            </div>

                            @if (! empty($cleanup['items']))
                                <div class="mt-5 overflow-x-auto">
                                    <table class="w-full min-w-[720px] text-left text-sm">
                                        <thead class="text-xs uppercase tracking-wide text-slate-500">
                                            <tr>
                                                <th class="px-3 py-2">Target</th>
                                                <th class="px-3 py-2">Job</th>
                                                <th class="px-3 py-2">วันที่</th>
                                                <th class="px-3 py-2">Local</th>
                                                <th class="px-3 py-2">Offsite</th>
                                                <th class="px-3 py-2">Size</th>
                                            </tr>
                                        </thead>
                                        <tbody class="divide-y divide-slate-100">
                                            @foreach ($cleanup['items'] as $item)
                                                <tr>
                                                    <td class="px-3 py-3 font-medium text-slate-900">{{ $item['target'] }}</td>
                                                    <td class="px-3 py-3">#{{ $item['job_id'] }}</td>
                                                    <td class="px-3 py-3">{{ $item['finished_at'] ?: '-' }}</td>
                                                    <td class="px-3 py-3">{{ $item['file_exists'] ? 'มีไฟล์' : 'ไม่มีไฟล์' }}</td>
                                                    <td class="px-3 py-3">{{ $item['offsite_file_exists'] ? 'มีไฟล์' : 'ไม่มีไฟล์' }}</td>
                                                    <td class="px-3 py-3">{{ number_format($item['file_size'] + $item['offsite_file_size']) }} B</td>
                                                </tr>
                                            @endforeach
                                        </tbody>
                                    </table>
                                </div>
                            @else
                                <p class="mt-5 rounded-2xl bg-slate-50 p-4 text-sm text-slate-600">ยังไม่มีไฟล์ backup ที่หมดอายุตาม retention</p>
                            @endif
                        </div>
                    @endif
                </div>
            </article>

            <article class="rounded-[2rem] border border-emerald-100 bg-emerald-50 p-6 shadow-sm shadow-emerald-100/80">
                <p class="text-sm font-semibold uppercase tracking-[0.22em] text-emerald-700">Automation</p>
                <h2 class="mt-2 text-2xl font-semibold text-slate-950">ระบบอัตโนมัติ</h2>
                <div class="mt-6 space-y-3">
                    <div class="rounded-3xl bg-white p-5">
                        <p class="text-sm font-medium text-slate-500">ตรวจงานที่ถึงรอบโดยไม่ backup จริง</p>
                        <p class="mt-2 break-all font-mono text-sm text-slate-900">php artisan backup:run-scheduled --dry-run</p>
                    </div>
                    <div class="rounded-3xl bg-white p-5">
                        <p class="text-sm font-medium text-slate-500">ลบไฟล์เก่าตาม retention โดยตรวจดูก่อน</p>
                        <p class="mt-2 break-all font-mono text-sm text-slate-900">php artisan backup:cleanup --dry-run</p>
                    </div>
                    <div class="rounded-3xl bg-white p-5">
                        <p class="text-sm font-medium text-slate-500">คำสั่งที่ควรใส่ใน Windows Task Scheduler</p>
                        <p class="mt-2 break-all font-mono text-sm text-slate-900">php artisan schedule:run</p>
                    </div>
                </div>
            </article>
        </section>
    </div>
@endsection
