@extends('layouts.app')

@section('title', 'กู้คืนข้อมูล | DB Backup')

@section('body')
    <div class="w-full px-4 py-6 sm:px-6 lg:px-10 lg:py-8">
        <header class="flex flex-col gap-5 rounded-[2rem] bg-white p-6 shadow-sm shadow-slate-200/80 lg:flex-row lg:items-center lg:justify-between">
            <div>
                <p class="text-xs font-semibold uppercase tracking-[0.28em] text-rose-600">Restore</p>
                <h1 class="mt-3 text-3xl font-semibold tracking-tight text-slate-950">กู้คืนฐานข้อมูล</h1>
                <p class="mt-2 max-w-3xl text-sm leading-6 text-slate-500">
                    กู้คืนจาก backup job ที่สำเร็จแล้ว หรืออัปโหลดไฟล์ .sql / .sql.gz การทำงานนี้จะเขียนข้อมูลลงฐานข้อมูลที่เลือก จึงต้องพิมพ์ชื่อฐานข้อมูลให้ตรงเพื่อยืนยัน
                </p>
            </div>
            <a href="{{ route('backup-jobs.index') }}" class="rounded-2xl border border-slate-200 bg-white px-5 py-3 text-center text-sm font-semibold text-slate-700 transition hover:border-emerald-200 hover:bg-emerald-50">
                ประวัติ Backup
            </a>
            <a href="{{ route('restore-history.index', ['target_id' => $selectedTarget?->id]) }}" class="rounded-2xl border border-rose-200 bg-rose-50 px-5 py-3 text-center text-sm font-semibold text-rose-700 transition hover:bg-rose-100">
                ประวัติ Restore
            </a>
        </header>

        <section class="mt-6 rounded-[2rem] border border-rose-100 bg-rose-50 p-5 shadow-sm shadow-rose-100/70">
            <div class="flex flex-col gap-3 md:flex-row md:items-start md:justify-between">
                <div>
                    <h2 class="text-lg font-semibold text-rose-950">การทำงานที่มีผลกระทบสูง</h2>
                    <p class="mt-2 max-w-4xl text-sm leading-6 text-rose-700">
                        การกู้คืนอาจแทนที่ตารางและข้อมูลในฐานข้อมูลปลายทาง ควรเปิดตัวเลือก safety backup ไว้เสมอ เว้นแต่มีจุดกู้คืนภายนอกที่พร้อมใช้งานแล้ว
                    </p>
                </div>
                <span class="rounded-full bg-white px-4 py-2 text-xs font-semibold uppercase tracking-wider text-rose-700">
                    บันทึก Audit Log
                </span>
            </div>
        </section>

        <section class="mt-6 grid gap-5 xl:grid-cols-[0.8fr_1.2fr]">
            <article class="rounded-[2rem] border border-white bg-white p-6 shadow-sm shadow-slate-200/80">
                <h2 class="text-2xl font-semibold text-slate-950">ระบบปลายทาง</h2>
                <p class="mt-2 text-sm text-slate-500">เลือกฐานข้อมูลที่จะรับข้อมูลจากการกู้คืน</p>

                <form method="GET" action="{{ route('restore.index') }}" class="mt-5">
                    <label class="text-sm font-medium text-slate-600">Backup Target</label>
                    <select name="target_id" onchange="this.form.submit()" class="mt-2 w-full rounded-2xl border border-slate-200 bg-slate-50 px-4 py-3 text-sm outline-none transition focus:border-emerald-300 focus:bg-white">
                        @forelse ($targets as $target)
                            <option value="{{ $target->id }}" @selected($selectedTarget?->id === $target->id)>
                                {{ $target->name }} / {{ $target->database_name }}
                            </option>
                        @empty
                            <option value="">ยังไม่มี target ที่เปิดใช้งาน</option>
                        @endforelse
                    </select>
                </form>

                @if ($selectedTarget)
                    <dl class="mt-6 grid gap-4">
                        <div class="rounded-3xl bg-slate-50 p-4">
                            <dt class="text-xs font-semibold uppercase tracking-wider text-slate-500">ปลายทาง</dt>
                            <dd class="mt-2 break-all text-sm font-medium text-slate-900">{{ $selectedTarget->endpoint }}</dd>
                        </div>
                        <div class="rounded-3xl bg-slate-50 p-4">
                            <dt class="text-xs font-semibold uppercase tracking-wider text-slate-500">ฐานข้อมูล</dt>
                            <dd class="mt-2 font-mono text-sm font-medium text-slate-900">{{ $selectedTarget->database_name }}</dd>
                        </div>
                        <div class="rounded-3xl bg-slate-50 p-4">
                            <dt class="text-xs font-semibold uppercase tracking-wider text-slate-500">โฟลเดอร์ Backup</dt>
                            <dd class="mt-2 break-all text-sm font-medium text-slate-900">{{ $selectedTarget->backup_path ?: '-' }}</dd>
                        </div>
                    </dl>
                @endif
            </article>

            <article class="rounded-[2rem] border border-white bg-white p-6 shadow-sm shadow-slate-200/80">
                <h2 class="text-2xl font-semibold text-slate-950">แหล่งข้อมูลสำหรับกู้คืน</h2>
                <p class="mt-2 text-sm text-slate-500">เลือก backup ที่สำเร็จแล้ว หรืออัปโหลดไฟล์ SQL dump</p>

                @if ($selectedTarget)
                    <form
                        method="POST"
                        action="{{ route('restore.store') }}"
                        enctype="multipart/form-data"
                        class="js-confirm mt-6 space-y-6"
                        data-confirm-title="ยืนยันการกู้คืนฐานข้อมูล?"
                        data-confirm-text="ระบบจะเขียนข้อมูลลง {{ $selectedTarget->database_name }} โปรดดำเนินการต่อเมื่อเลือกแหล่งข้อมูลถูกต้องแล้วเท่านั้น"
                    >
                        @csrf
                        <input type="hidden" name="backup_target_id" value="{{ $selectedTarget->id }}">

                        <div class="grid gap-3 sm:grid-cols-2">
                            <label class="flex cursor-pointer items-start gap-3 rounded-3xl border border-slate-200 bg-slate-50 p-4 transition has-[:checked]:border-emerald-300 has-[:checked]:bg-emerald-50">
                                <input type="radio" name="source_type" value="backup_job" class="mt-1" @checked(old('source_type', 'backup_job') === 'backup_job')>
                                <span>
                                    <span class="block font-semibold text-slate-950">Backup เดิมในระบบ</span>
                                    <span class="mt-1 block text-sm text-slate-500">กู้คืนจากงาน backup ที่สำเร็จและถูกจัดเก็บไว้ในระบบนี้</span>
                                </span>
                            </label>
                            <label class="flex cursor-pointer items-start gap-3 rounded-3xl border border-slate-200 bg-slate-50 p-4 transition has-[:checked]:border-emerald-300 has-[:checked]:bg-emerald-50">
                                <input type="radio" name="source_type" value="upload" class="mt-1" @checked(old('source_type') === 'upload')>
                                <span>
                                    <span class="block font-semibold text-slate-950">อัปโหลดไฟล์</span>
                                    <span class="mt-1 block text-sm text-slate-500">ใช้ไฟล์ .sql หรือ .sql.gz จากภายนอกระบบ</span>
                                </span>
                            </label>
                        </div>

                        <div class="grid gap-5 lg:grid-cols-2">
                            <div>
                                <label class="text-sm font-medium text-slate-600">Backup Job ที่สำเร็จ</label>
                                <select name="backup_job_id" class="mt-2 w-full rounded-2xl border border-slate-200 bg-slate-50 px-4 py-3 text-sm outline-none transition focus:border-emerald-300 focus:bg-white">
                                    <option value="">เลือก backup job</option>
                                    @foreach ($backupJobs as $job)
                                        <option value="{{ $job->id }}" @selected((string) old('backup_job_id') === (string) $job->id)>
                                            #{{ $job->id }} / {{ $job->started_at?->format('Y-m-d H:i') ?? '-' }} / {{ $job->file_name }}
                                        </option>
                                    @endforeach
                                </select>
                                <p class="mt-2 text-xs text-slate-500">พบ backup ที่สำเร็จสำหรับ target นี้ {{ $backupJobs->count() }} รายการ</p>
                            </div>

                            <div>
                                <label class="text-sm font-medium text-slate-600">อัปโหลดไฟล์ SQL</label>
                                <input type="file" name="restore_file" accept=".sql,.gz,.sql.gz" class="mt-2 w-full rounded-2xl border border-slate-200 bg-slate-50 px-4 py-3 text-sm outline-none transition file:mr-4 file:rounded-xl file:border-0 file:bg-slate-200 file:px-3 file:py-2 file:text-sm file:font-semibold file:text-slate-700 focus:border-emerald-300 focus:bg-white">
                                <p class="mt-2 text-xs text-slate-500">ขนาดไฟล์สูงสุด 500 MB</p>
                            </div>
                        </div>

                        <div class="rounded-3xl bg-slate-50 p-5">
                            <label class="text-sm font-medium text-slate-600">พิมพ์ชื่อฐานข้อมูลเพื่อยืนยัน</label>
                            <input name="confirmation_database" value="{{ old('confirmation_database') }}" placeholder="{{ $selectedTarget->database_name }}" class="mt-2 w-full rounded-2xl border border-slate-200 bg-white px-4 py-3 font-mono text-sm outline-none transition focus:border-rose-300">
                            <p class="mt-2 text-xs text-slate-500">ต้องพิมพ์ให้ตรงทุกตัวอักษร: <span class="font-mono font-semibold text-slate-800">{{ $selectedTarget->database_name }}</span></p>

                            <div class="mt-5 space-y-3">
                                <label class="flex items-start gap-3 text-sm text-slate-700">
                                    <input type="checkbox" name="create_safety_backup" value="1" class="mt-1" @checked(old('create_safety_backup', '1'))>
                                    <span>สร้าง safety backup ก่อนเริ่มกู้คืน</span>
                                </label>
                                <label class="flex items-start gap-3 text-sm text-slate-700">
                                    <input type="checkbox" name="confirm_understand" value="1" class="mt-1" @checked(old('confirm_understand'))>
                                    <span>ฉันเข้าใจว่าการกู้คืนนี้อาจเขียนทับข้อมูลในฐานข้อมูลที่เลือก</span>
                                </label>
                            </div>
                        </div>

                        @if ($errors->any())
                            <div class="rounded-3xl bg-rose-50 p-4 text-sm text-rose-700">
                                {{ $errors->first() }}
                            </div>
                        @endif

                        @if (session('restore_precheck'))
                            <div class="rounded-3xl border {{ session('restore_precheck.passed') ? 'border-emerald-200 bg-emerald-50' : 'border-amber-200 bg-amber-50' }} p-5">
                                <div class="flex flex-col gap-2 sm:flex-row sm:items-center sm:justify-between">
                                    <div>
                                        <h3 class="text-lg font-semibold {{ session('restore_precheck.passed') ? 'text-emerald-900' : 'text-amber-900' }}">ผลตรวจสอบก่อน Restore</h3>
                                        <p class="mt-1 text-sm {{ session('restore_precheck.passed') ? 'text-emerald-700' : 'text-amber-700' }}">
                                            {{ session('restore_precheck.passed') ? 'ตรวจสอบผ่าน สามารถ Restore ต่อได้' : 'พบรายการที่ควรแก้ไขก่อน Restore' }}
                                        </p>
                                    </div>
                                    <span class="rounded-full bg-white px-3 py-1 text-xs font-semibold {{ session('restore_precheck.passed') ? 'text-emerald-700' : 'text-amber-700' }}">
                                        {{ session('restore_precheck.passed') ? 'PASSED' : 'CHECK ISSUES' }}
                                    </span>
                                </div>

                                <div class="mt-4 grid gap-3">
                                    @foreach (session('restore_precheck.checks', []) as $check)
                                        <div class="rounded-2xl bg-white p-4">
                                            <div class="flex flex-col gap-1 sm:flex-row sm:items-start sm:justify-between">
                                                <p class="font-semibold text-slate-900">{{ $check['label'] }}</p>
                                                <span class="rounded-full px-3 py-1 text-xs font-semibold {{ $check['status'] === 'passed' ? 'bg-emerald-100 text-emerald-700' : 'bg-rose-100 text-rose-700' }}">
                                                    {{ strtoupper($check['status']) }}
                                                </span>
                                            </div>
                                            <p class="mt-2 break-words text-sm leading-6 text-slate-600">{{ $check['message'] }}</p>
                                        </div>
                                    @endforeach
                                </div>
                            </div>
                        @endif

                        <div class="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-end">
                            <a href="{{ route('backup-targets.show', $selectedTarget) }}" class="rounded-2xl border border-slate-200 px-5 py-3 text-center text-sm font-semibold text-slate-700 transition hover:bg-slate-50">
                                ตรวจสอบ Target
                            </a>
                            <button name="intent" value="precheck" data-skip-confirm="1" class="rounded-2xl border border-amber-200 bg-amber-50 px-5 py-3 text-sm font-semibold text-amber-700 transition hover:bg-amber-100">
                                ตรวจสอบก่อน Restore
                            </button>
                            <button name="intent" value="restore" class="rounded-2xl bg-rose-500 px-5 py-3 text-sm font-semibold text-white shadow-lg shadow-rose-200 transition hover:-translate-y-0.5 hover:bg-rose-600">
                                กู้คืนฐานข้อมูล
                            </button>
                        </div>
                    </form>
                @else
                    <div class="mt-6 rounded-3xl bg-slate-50 p-8 text-center text-slate-500">
                        กรุณาสร้างและเปิดใช้งาน backup target ก่อนใช้การกู้คืน
                    </div>
                @endif
            </article>
        </section>

        <section class="mt-6 overflow-hidden rounded-[2rem] border border-white bg-white shadow-sm shadow-slate-200/80">
            <div class="flex flex-col gap-3 p-6 sm:flex-row sm:items-center sm:justify-between">
                <div>
                    <h2 class="text-2xl font-semibold text-slate-950">ประวัติ Restore ล่าสุด</h2>
                    <p class="mt-2 text-sm text-slate-500">รายการ restore ล่าสุดของ target ที่เลือก แยกจาก audit log เพื่อดูสถานะได้เร็วขึ้น</p>
                </div>
                <a href="{{ route('restore-history.index', ['target_id' => $selectedTarget?->id]) }}" class="rounded-2xl border border-slate-200 px-4 py-2 text-center text-sm font-semibold text-slate-700 transition hover:bg-slate-50">
                    ดูทั้งหมด
                </a>
            </div>

            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-slate-100">
                    <thead class="bg-slate-50">
                        <tr>
                            <th class="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-slate-500">สถานะ</th>
                            <th class="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-slate-500">แหล่งข้อมูล</th>
                            <th class="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-slate-500">เวลา</th>
                            <th class="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-slate-500">Safety Backup</th>
                            <th class="px-6 py-4 text-left text-xs font-semibold uppercase tracking-wider text-slate-500">Error</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-slate-100">
                        @forelse ($recentRestoreJobs as $job)
                            <tr class="align-top transition hover:bg-slate-50">
                                <td class="px-6 py-5">
                                    <span class="rounded-full px-3 py-1 text-xs font-semibold {{ $job->status === 'success' ? 'bg-emerald-100 text-emerald-700' : ($job->status === 'failed' ? 'bg-rose-100 text-rose-700' : ($job->status === 'queued' ? 'bg-amber-100 text-amber-700' : 'bg-orange-100 text-orange-700')) }}">
                                        {{ strtoupper($job->status) }}
                                    </span>
                                    <div class="mt-2 text-xs text-slate-500">#{{ $job->id }}</div>
                                    <div class="mt-3 w-36">
                                        <div class="flex items-center justify-between text-xs text-slate-500">
                                            <span>{{ $job->current_step ? str_replace('_', ' ', $job->current_step) : '-' }}</span>
                                            <span>{{ (int) $job->progress_percent }}%</span>
                                        </div>
                                        <div class="mt-2 h-2 rounded-full bg-slate-100">
                                            <div class="h-2 rounded-full {{ $job->status === 'failed' ? 'bg-rose-500' : ($job->status === 'success' ? 'bg-emerald-500' : 'bg-amber-500') }}" style="width: {{ (int) $job->progress_percent }}%"></div>
                                        </div>
                                    </div>
                                </td>
                                <td class="px-6 py-5">
                                    <div class="text-sm font-semibold text-slate-900">{{ $job->source_type === 'backup_job' ? 'Backup Job' : 'Upload' }}</div>
                                    <div class="mt-1 max-w-md break-all text-xs text-slate-500">{{ $job->source_name ?: '-' }}</div>
                                </td>
                                <td class="px-6 py-5 text-sm text-slate-600">
                                    <div class="font-medium text-slate-800">{{ $job->started_at?->format('Y-m-d H:i:s') ?? '-' }}</div>
                                    <div class="mt-1 text-xs text-slate-500">{{ $job->duration_seconds !== null ? $job->duration_seconds.' sec' : '-' }}</div>
                                </td>
                                <td class="px-6 py-5 text-sm text-slate-600">
                                    @if ($job->safetyBackupJob)
                                        <a href="{{ route('backup-jobs.index', ['q' => $job->safetyBackupJob->file_name]) }}" class="font-semibold text-emerald-700 hover:text-emerald-800">
                                            #{{ $job->safetyBackupJob->id }}
                                        </a>
                                    @else
                                        <span class="text-slate-400">-</span>
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
                                <td colspan="5" class="px-6 py-14 text-center text-slate-500">
                                    ยังไม่มีประวัติ Restore สำหรับ target นี้
                                </td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </section>
    </div>
@endsection
