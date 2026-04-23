@extends('layouts.app')

@section('title', 'Automation Guide | DB Backup')

@section('body')
    <div class="w-full px-4 py-6 sm:px-6 lg:px-10 lg:py-8">
        <header class="overflow-hidden rounded-[2rem] bg-[#0b2f28] text-white shadow-2xl shadow-emerald-950/20">
            <div class="relative p-6 sm:p-8 lg:p-10">
                <div class="absolute inset-y-0 right-0 hidden w-1/2 bg-[radial-gradient(circle_at_center,_rgba(52,211,153,0.35),_transparent_55%)] lg:block"></div>
                <div class="relative max-w-4xl">
                    <p class="text-xs font-semibold uppercase tracking-[0.32em] text-emerald-300">Automation Guide</p>
                    <h1 class="mt-4 text-3xl font-semibold tracking-tight sm:text-4xl">คู่มือตั้งค่า Queue และ Scheduler บน Windows</h1>
                    <p class="mt-4 max-w-3xl text-base leading-7 text-emerald-50/80">
                        ระบบนี้ใช้ queue สำหรับรัน backup เบื้องหลัง ดังนั้นนอกจาก web server แล้ว ต้องมี queue worker ทำงานอยู่ด้วย
                        หน้านี้สรุปทั้งไฟล์ `.bat`, คำสั่ง dev, และไฟล์ `.xml` สำหรับ import เข้า Windows Task Scheduler ครับ
                    </p>
                </div>
            </div>
        </header>

        <section class="mt-6 grid gap-5 xl:grid-cols-[1fr_0.9fr]">
            <article class="rounded-[2rem] border border-white bg-white p-6 shadow-sm shadow-slate-200/80">
                <div class="flex items-start gap-4">
                    <div class="grid h-12 w-12 shrink-0 place-items-center rounded-2xl bg-emerald-100 text-lg font-semibold text-emerald-700">1</div>
                    <div>
                        <h2 class="text-2xl font-semibold text-slate-950">ค่าที่ใช้กับ Task Scheduler</h2>
                        <p class="mt-2 text-sm leading-6 text-slate-500">ถ้าจะตั้ง Task Scheduler แบบเรียก Laravel โดยตรง ให้ใช้ค่าเหล่านี้ในแท็บ Actions</p>
                    </div>
                </div>

                <div class="mt-6 space-y-4">
                    <div>
                        <label class="text-sm font-medium text-slate-600">Program/script</label>
                        <div class="mt-2 rounded-2xl border border-slate-200 bg-slate-50 p-4 font-mono text-sm text-slate-900">{{ $phpPath }}</div>
                    </div>
                    <div>
                        <label class="text-sm font-medium text-slate-600">Add arguments</label>
                        <div class="mt-2 rounded-2xl border border-slate-200 bg-slate-50 p-4 font-mono text-sm text-slate-900">{{ $schedulerCommand }}</div>
                    </div>
                    <div>
                        <label class="text-sm font-medium text-slate-600">Start in</label>
                        <div class="mt-2 rounded-2xl border border-slate-200 bg-slate-50 p-4 font-mono text-sm text-slate-900">{{ $projectPath }}</div>
                    </div>
                </div>
            </article>

            <article class="rounded-[2rem] border border-amber-200 bg-amber-50 p-6 shadow-sm shadow-amber-100/80">
                <p class="text-sm font-semibold uppercase tracking-[0.22em] text-amber-700">สำคัญ</p>
                <h2 class="mt-2 text-2xl font-semibold text-slate-950">Scheduler กับ Queue คนละตัว</h2>
                <p class="mt-3 text-sm leading-7 text-amber-900/75">
                    `schedule:run` ใช้ตรวจว่ามี target ไหนถึงรอบ ส่วน `queue:work` ใช้ประมวลผลงาน backup จริง
                    ถ้ามีแค่ scheduler แต่ไม่มี worker งานจะค้างที่สถานะ <span class="font-mono font-medium">QUEUED</span>
                </p>
                <div class="mt-5 rounded-3xl bg-white p-5">
                    <p class="text-sm font-medium text-slate-600">ตรวจสอบ schedule ที่ Laravel รู้จัก</p>
                    <p class="mt-2 break-all font-mono text-sm text-slate-900">php artisan schedule:list</p>
                </div>
                <div class="mt-4 rounded-3xl bg-white p-5">
                    <p class="text-sm font-medium text-slate-600">คำสั่ง queue worker</p>
                    <p class="mt-2 break-all font-mono text-sm text-slate-900">{{ $queueWorkCommand }}</p>
                </div>
            </article>
        </section>

        <section class="mt-6 rounded-[2rem] border border-white bg-white p-6 shadow-sm shadow-slate-200/80">
            <div class="flex items-start gap-4">
                <div class="grid h-12 w-12 shrink-0 place-items-center rounded-2xl bg-sky-100 text-lg font-semibold text-sky-700">2</div>
                <div>
                    <h2 class="text-2xl font-semibold text-slate-950">ไฟล์ .bat ที่เตรียมไว้ให้</h2>
                    <p class="mt-2 text-sm leading-6 text-slate-500">ใช้ได้ทันทีบน Windows เพื่อลดการลืมเปิด queue worker</p>
                </div>
            </div>

            <div class="mt-6 grid gap-4 lg:grid-cols-3">
                <div class="rounded-3xl border border-slate-200 bg-slate-50 p-5">
                    <p class="text-lg font-semibold text-slate-950">Start Dev</p>
                    <p class="mt-2 text-sm leading-6 text-slate-500">เปิด web server, queue worker และ Vite พร้อมกัน</p>
                    <p class="mt-4 break-all rounded-2xl bg-white p-3 font-mono text-xs text-slate-900">{{ $devBatPath }}</p>
                </div>
                <div class="rounded-3xl border border-slate-200 bg-slate-50 p-5">
                    <p class="text-lg font-semibold text-slate-950">Start Worker</p>
                    <p class="mt-2 text-sm leading-6 text-slate-500">เปิดเฉพาะ queue worker สำหรับให้ backup jobs ที่ queued ถูกหยิบไปทำ</p>
                    <p class="mt-4 break-all rounded-2xl bg-white p-3 font-mono text-xs text-slate-900">{{ $workerBatPath }}</p>
                </div>
                <div class="rounded-3xl border border-slate-200 bg-slate-50 p-5">
                    <p class="text-lg font-semibold text-slate-950">Start Scheduler</p>
                    <p class="mt-2 text-sm leading-6 text-slate-500">เปิด scheduler worker ต่อเนื่อง เหมาะกับเครื่องที่ใช้ให้ระบบทำงานอัตโนมัติ</p>
                    <p class="mt-4 break-all rounded-2xl bg-white p-3 font-mono text-xs text-slate-900">{{ $schedulerBatPath }}</p>
                </div>
            </div>
        </section>

        <section class="mt-6 rounded-[2rem] border border-white bg-white p-6 shadow-sm shadow-slate-200/80">
            <div class="flex items-start gap-4">
                <div class="grid h-12 w-12 shrink-0 place-items-center rounded-2xl bg-violet-100 text-lg font-semibold text-violet-700">XML</div>
                <div>
                    <h2 class="text-2xl font-semibold text-slate-950">ไฟล์ XML สำหรับ Import Task</h2>
                    <p class="mt-2 text-sm leading-6 text-slate-500">ใน Windows Task Scheduler ให้กด `Import Task...` แล้วเลือกไฟล์ตามหน้าที่ของงาน หรือใช้สคริปต์ PowerShell ด้านล่างเพื่อนำเข้าทั้งสองงานรวดเดียว</p>
                </div>
            </div>

            <div class="mt-6 grid gap-4 lg:grid-cols-2">
                <div class="rounded-3xl border border-slate-200 bg-slate-50 p-5">
                    <p class="text-lg font-semibold text-slate-950">DB Backup Scheduler</p>
                    <p class="mt-2 text-sm leading-6 text-slate-500">รัน `php artisan schedule:run` ทุก 1 ชั่วโมง โดยตั้ง path ของโปรเจกต์นี้ให้แล้ว</p>
                    <p class="mt-4 break-all rounded-2xl bg-white p-3 font-mono text-xs text-slate-900">{{ $schedulerXmlPath }}</p>
                </div>
                <div class="rounded-3xl border border-slate-200 bg-slate-50 p-5">
                    <p class="text-lg font-semibold text-slate-950">DB Backup Queue Worker</p>
                    <p class="mt-2 text-sm leading-6 text-slate-500">เริ่ม `start-worker.bat` ตอน login เพื่อให้ worker ค้างรับงาน backup อัตโนมัติ</p>
                    <p class="mt-4 break-all rounded-2xl bg-white p-3 font-mono text-xs text-slate-900">{{ $workerXmlPath }}</p>
                </div>
            </div>

            <div class="mt-6 rounded-3xl border border-slate-200 bg-slate-50 p-5">
                <p class="text-lg font-semibold text-slate-950">PowerShell Import Script</p>
                <p class="mt-2 text-sm leading-6 text-slate-500">รันสคริปต์นี้ครั้งเดียวเพื่อ import หรืออัปเดตทั้ง `DB Backup Scheduler` และ `DB Backup Queue Worker` อัตโนมัติ</p>
                <p class="mt-4 break-all rounded-2xl bg-white p-3 font-mono text-xs text-slate-900">{{ $importTasksScriptPath }}</p>
            </div>

            <div class="mt-4 rounded-3xl border border-slate-200 bg-slate-50 p-5">
                <p class="text-lg font-semibold text-slate-950">Double-click Import .bat</p>
                <p class="mt-2 text-sm leading-6 text-slate-500">ถ้าต้องการแบบง่ายที่สุด ให้ดับเบิลคลิกไฟล์นี้เพื่อเรียก PowerShell script และ import tasks ทั้งสองตัวอัตโนมัติ โดย Windows จะถามสิทธิ์ Administrator ผ่าน UAC ก่อน</p>
                <p class="mt-4 break-all rounded-2xl bg-white p-3 font-mono text-xs text-slate-900">{{ $importTasksBatPath }}</p>
            </div>
        </section>

        <section class="mt-6 rounded-[2rem] border border-white bg-white p-6 shadow-sm shadow-slate-200/80">
            <div class="flex items-start gap-4">
                <div class="grid h-12 w-12 shrink-0 place-items-center rounded-2xl bg-emerald-100 text-lg font-semibold text-emerald-700">3</div>
                <div>
                    <h2 class="text-2xl font-semibold text-slate-950">Task Scheduler ที่แนะนำ</h2>
                    <p class="mt-2 text-sm leading-6 text-slate-500">แนะนำให้แยกเป็น 2 งาน เพื่อให้ควบคุมง่ายและสังเกตปัญหาได้ชัด</p>
                </div>
            </div>

            <div class="mt-6 grid gap-4 lg:grid-cols-2">
                <div class="rounded-3xl border border-slate-200 bg-slate-50 p-5">
                    <p class="text-lg font-semibold text-slate-950">Task 1: Scheduler</p>
                    <p class="mt-2 text-sm leading-6 text-slate-500">ให้รันทุก 1 ชั่วโมง เพื่อเช็กว่ามี target ไหนถึงรอบ backup</p>
                    <div class="mt-4 space-y-2 text-sm text-slate-700">
                        <p>Name: `DB Backup Scheduler`</p>
                        <p>Import: `{{ $schedulerXmlPath }}`</p>
                        <p>Alternative: `php artisan schedule:run`</p>
                    </div>
                </div>

                <div class="rounded-3xl border border-slate-200 bg-slate-50 p-5">
                    <p class="text-lg font-semibold text-slate-950">Task 2: Queue Worker</p>
                    <p class="mt-2 text-sm leading-6 text-slate-500">ให้เริ่มตอน login เพื่อให้ worker ค้างรับงาน backup ต่อเนื่อง</p>
                    <div class="mt-4 space-y-2 text-sm text-slate-700">
                        <p>Name: `DB Backup Queue Worker`</p>
                        <p>Import: `{{ $workerXmlPath }}`</p>
                        <p>Alternative: `{{ $workerBatPath }}`</p>
                    </div>
                </div>
            </div>
        </section>

        <section class="mt-6 grid gap-5 xl:grid-cols-2">
            <article class="rounded-[2rem] border border-white bg-white p-6 shadow-sm shadow-slate-200/80">
                <h2 class="text-2xl font-semibold text-slate-950">คำสั่ง dev ที่ใช้ได้ทันที</h2>
                <p class="mt-2 text-sm leading-6 text-slate-500">เลือกใช้ได้ตามลักษณะงานของคุณ</p>
                <div class="mt-5 space-y-3">
                    <div class="rounded-2xl bg-slate-50 p-4 font-mono text-sm text-slate-900">composer dev</div>
                    <div class="rounded-2xl bg-slate-50 p-4 font-mono text-sm text-slate-900">composer dev:backend</div>
                    <div class="rounded-2xl bg-slate-50 p-4 font-mono text-sm text-slate-900">composer queue:work</div>
                    <div class="rounded-2xl bg-slate-50 p-4 font-mono text-sm text-slate-900">composer schedule:work</div>
                    <div class="rounded-2xl bg-slate-50 p-4 font-mono text-sm text-slate-900">{{ $scheduledBackupCommand }}</div>
                    <div class="rounded-2xl bg-slate-50 p-4 font-mono text-sm text-slate-900">{{ $cleanupCommand }}</div>
                </div>
            </article>

            <article class="rounded-[2rem] border border-white bg-white p-6 shadow-sm shadow-slate-200/80">
                <h2 class="text-2xl font-semibold text-slate-950">เช็กอาการเบื้องต้น</h2>
                <div class="mt-5 space-y-3 text-sm leading-6 text-slate-600">
                    <p>1. ถ้างานค้างที่ `QUEUED` แปลว่ายังไม่มี queue worker กำลังรัน</p>
                    <p>2. ถ้าแก้ `.env` แล้วค่าระบบไม่เปลี่ยน ให้รัน `php artisan optimize:clear`</p>
                    <p>3. ถ้าใช้ Task Scheduler ให้ตรวจ `Start in` ว่าเป็นโฟลเดอร์โปรเจกต์นี้: <span class="font-mono text-slate-900">{{ $projectPath }}</span></p>
                    <p>4. ถ้าจะเปิดใช้งานเร็วที่สุดบนเครื่องนี้ ให้ดับเบิลคลิก `{{ $devBatPath }}` หรือรัน `composer dev:backend`</p>
                </div>
            </article>
        </section>
    </div>
@endsection
