@extends('layouts.app')

@section('title', 'Automation Guide | DB Backup')

@section('body')
    <div class="w-full px-4 py-6 sm:px-6 lg:px-10 lg:py-8">
        <header class="overflow-hidden rounded-[2rem] bg-[#0b2f28] text-white shadow-2xl shadow-emerald-950/20">
            <div class="relative p-6 sm:p-8 lg:p-10">
                <div class="absolute inset-y-0 right-0 hidden w-1/2 bg-[radial-gradient(circle_at_center,_rgba(52,211,153,0.35),_transparent_55%)] lg:block"></div>
                <div class="relative max-w-4xl">
                    <p class="text-xs font-semibold uppercase tracking-[0.32em] text-emerald-300">Automation Guide</p>
                    <h1 class="mt-4 text-3xl font-semibold tracking-tight sm:text-4xl">คู่มือตั้งค่า Windows Task Scheduler</h1>
                    <p class="mt-4 max-w-3xl text-base leading-7 text-emerald-50/80">
                        ใช้หน้านี้เป็น checklist สำหรับตั้งให้ระบบ Backup ทำงานอัตโนมัติ โดย Windows จะเรียก Laravel Scheduler ทุก 1 ชั่วโมง แล้ว Laravel จะเลือกเองว่างานไหนถึงรอบต้องทำ
                    </p>
                </div>
            </div>
        </header>

        <section class="mt-6 grid gap-5 xl:grid-cols-[1fr_0.9fr]">
            <article class="rounded-[2rem] border border-white bg-white p-6 shadow-sm shadow-slate-200/80">
                <div class="flex items-start gap-4">
                    <div class="grid h-12 w-12 shrink-0 place-items-center rounded-2xl bg-emerald-100 text-lg font-semibold text-emerald-700">1</div>
                    <div>
                        <h2 class="text-2xl font-semibold text-slate-950">ค่าที่ต้องใส่ใน Task Scheduler</h2>
                        <p class="mt-2 text-sm leading-6 text-slate-500">คัดลอกค่าด้านล่างไปใส่ในหน้า Actions ของ Windows Task Scheduler ได้เลย</p>
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
                <h2 class="mt-2 text-2xl font-semibold text-slate-950">ระบบนี้ตั้งให้เรียกทุก 1 ชั่วโมงได้</h2>
                <p class="mt-3 text-sm leading-7 text-amber-900/75">
                    ไม่ต้องตั้ง command backup แยกเอง ให้ตั้ง Windows Task Scheduler เรียกแค่ <span class="font-mono font-medium">php artisan schedule:run</span> ทุก 1 ชั่วโมงพอครับ Laravel จะตรวจว่า target ไหนถึงรอบตามเวลาที่ตั้งไว้ และจะลบไฟล์เก่าตาม retention ให้อัตโนมัติ
                </p>
                <div class="mt-5 rounded-3xl bg-white p-5">
                    <p class="text-sm font-medium text-slate-600">ตรวจสอบ schedule ที่ Laravel รู้จัก</p>
                    <p class="mt-2 break-all font-mono text-sm text-slate-900">php artisan schedule:list</p>
                </div>
            </article>
        </section>

        <section class="mt-6 rounded-[2rem] border border-white bg-white p-6 shadow-sm shadow-slate-200/80">
            <div class="flex items-start gap-4">
                <div class="grid h-12 w-12 shrink-0 place-items-center rounded-2xl bg-sky-100 text-lg font-semibold text-sky-700">2</div>
                <div>
                    <h2 class="text-2xl font-semibold text-slate-950">ขั้นตอนตั้งค่าใน Windows</h2>
                    <p class="mt-2 text-sm leading-6 text-slate-500">ทำตามลำดับนี้ครั้งเดียว หลังจากนั้นระบบจะรันเองอัตโนมัติ</p>
                </div>
            </div>

            <div class="mt-6 grid gap-4 lg:grid-cols-2">
                @foreach ([
                    ['title' => 'เปิด Task Scheduler', 'desc' => 'กด Start Menu แล้วค้นหา Task Scheduler จากนั้นเลือก Create Task...'],
                    ['title' => 'แท็บ General', 'desc' => 'Name: DB Backup Laravel Scheduler, เลือก Run whether user is logged on or not และ Run with highest privileges'],
                    ['title' => 'แท็บ Triggers', 'desc' => 'กด New..., เลือก Daily, ตั้ง Repeat task every: 1 hour และ for a duration of: Indefinitely'],
                    ['title' => 'แท็บ Actions', 'desc' => 'กด New..., เลือก Start a program แล้วใส่ Program/script, Add arguments และ Start in ตามค่าด้านบน'],
                    ['title' => 'แท็บ Conditions', 'desc' => 'ถ้าเป็นเครื่อง Server แนะนำเอาเงื่อนไข Start only if on AC power ออก เพื่อไม่ให้ task ถูกบล็อก'],
                    ['title' => 'ทดสอบ', 'desc' => 'คลิกขวา task ที่สร้างแล้วกด Run จากนั้นเปิด Backup History หรือรัน php artisan schedule:list เพื่อตรวจสอบ'],
                ] as $index => $step)
                    <div class="rounded-3xl border border-slate-200 bg-slate-50 p-5">
                        <div class="flex items-center gap-3">
                            <span class="grid h-8 w-8 place-items-center rounded-xl bg-white text-sm font-semibold text-slate-700">{{ $index + 1 }}</span>
                            <h3 class="font-semibold text-slate-950">{{ $step['title'] }}</h3>
                        </div>
                        <p class="mt-3 text-sm leading-6 text-slate-500">{{ $step['desc'] }}</p>
                    </div>
                @endforeach
            </div>
        </section>

        <section class="mt-6 grid gap-5 xl:grid-cols-2">
            <article class="rounded-[2rem] border border-white bg-white p-6 shadow-sm shadow-slate-200/80">
                <h2 class="text-2xl font-semibold text-slate-950">คำสั่งทดสอบก่อนใช้งานจริง</h2>
                <p class="mt-2 text-sm leading-6 text-slate-500">ใช้คำสั่งแบบ dry-run เพื่อดูผลโดยยังไม่ backup หรือลบไฟล์จริง</p>
                <div class="mt-5 space-y-3">
                    <div class="rounded-2xl bg-slate-50 p-4 font-mono text-sm text-slate-900">{{ $scheduledBackupCommand }}</div>
                    <div class="rounded-2xl bg-slate-50 p-4 font-mono text-sm text-slate-900">{{ $cleanupCommand }}</div>
                </div>
            </article>

            <article class="rounded-[2rem] border border-white bg-white p-6 shadow-sm shadow-slate-200/80">
                <h2 class="text-2xl font-semibold text-slate-950">ถ้า Task ไม่ทำงานให้เช็คอะไร</h2>
                <div class="mt-5 space-y-3 text-sm leading-6 text-slate-600">
                    <p>1. ช่อง Start in ต้องเป็น path โปรเจกต์นี้เท่านั้น: <span class="font-mono text-slate-900">{{ $projectPath }}</span></p>
                    <p>2. Program/script ต้องชี้ไปที่ <span class="font-mono text-slate-900">php.exe</span> ของ WAMP ที่ใช้งานจริง</p>
                    <p>3. ถ้าแก้ไฟล์ <span class="font-mono text-slate-900">.env</span> ให้รัน <span class="font-mono text-slate-900">php artisan optimize:clear</span></p>
                    <p>4. ตรวจสอบว่า target ตั้ง Schedule เป็น Daily, Weekly หรือ Monthly ไม่ใช่ Manual</p>
                </div>
            </article>
        </section>
    </div>
@endsection
