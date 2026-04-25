@csrf

<div class="grid gap-6 xl:grid-cols-[1fr_360px]">
    <section class="space-y-6">
        <div class="rounded-[2rem] border border-slate-100 bg-white p-6 shadow-sm shadow-slate-200/80">
            <div class="mb-6">
                <p class="text-xs font-black uppercase tracking-[0.22em] text-emerald-600">Connection</p>
                <h2 class="mt-2 text-2xl font-black text-slate-950">ข้อมูลเชื่อมต่อฐานข้อมูล</h2>
                <p class="mt-2 text-sm text-slate-500">กรอกข้อมูลตาม server จริงของระบบที่ต้องการ backup</p>
            </div>

            <div class="grid gap-5 md:grid-cols-2">
                <div class="md:col-span-2">
                    <label for="name" class="block text-sm font-black text-slate-700">ชื่อระบบ</label>
                    <input id="name" name="name" value="{{ old('name', $target->name) }}" required class="mt-2 w-full rounded-2xl border border-slate-200 bg-white px-4 py-3 text-slate-950 outline-none ring-emerald-400/20 transition placeholder:text-slate-400 focus:border-emerald-400 focus:ring-4">
                    @error('name') <p class="mt-2 text-sm font-bold text-rose-600">{{ $message }}</p> @enderror
                </div>

                <div>
                    <label for="db_type" class="block text-sm font-black text-slate-700">ประเภทฐานข้อมูล</label>
                    <select id="db_type" name="db_type" required class="mt-2 w-full rounded-2xl border border-slate-200 bg-white px-4 py-3 text-slate-950 outline-none ring-emerald-400/20 transition focus:border-emerald-400 focus:ring-4">
                        @foreach (['mariadb' => 'MariaDB', 'mysql' => 'MySQL'] as $value => $label)
                            <option value="{{ $value }}" @selected(old('db_type', $target->db_type) === $value)>{{ $label }}</option>
                        @endforeach
                    </select>
                </div>

                <div>
                    <label for="host" class="block text-sm font-black text-slate-700">Host/IP</label>
                    <input id="host" name="host" value="{{ old('host', $target->host) }}" required placeholder="127.0.0.1 หรือ 192.168.x.x" class="mt-2 w-full rounded-2xl border border-slate-200 bg-white px-4 py-3 text-slate-950 outline-none ring-emerald-400/20 transition placeholder:text-slate-400 focus:border-emerald-400 focus:ring-4">
                    @error('host') <p class="mt-2 text-sm font-bold text-rose-600">{{ $message }}</p> @enderror
                </div>

                <div>
                    <label for="port" class="block text-sm font-black text-slate-700">Port</label>
                    <input id="port" name="port" type="number" min="1" max="65535" value="{{ old('port', $target->port) }}" required class="mt-2 w-full rounded-2xl border border-slate-200 bg-white px-4 py-3 text-slate-950 outline-none ring-emerald-400/20 transition focus:border-emerald-400 focus:ring-4">
                </div>

                <div>
                    <label for="database_name" class="block text-sm font-black text-slate-700">Database</label>
                    <input id="database_name" name="database_name" value="{{ old('database_name', $target->database_name) }}" required class="mt-2 w-full rounded-2xl border border-slate-200 bg-white px-4 py-3 text-slate-950 outline-none ring-emerald-400/20 transition focus:border-emerald-400 focus:ring-4">
                    @error('database_name') <p class="mt-2 text-sm font-bold text-rose-600">{{ $message }}</p> @enderror
                </div>

                <div>
                    <label for="username" class="block text-sm font-black text-slate-700">Username</label>
                    <input id="username" name="username" value="{{ old('username', $target->username) }}" required class="mt-2 w-full rounded-2xl border border-slate-200 bg-white px-4 py-3 text-slate-950 outline-none ring-emerald-400/20 transition focus:border-emerald-400 focus:ring-4">
                </div>

                <div>
                    <label for="password" class="block text-sm font-black text-slate-700">Password</label>
                    <input id="password" name="password" type="password" placeholder="เว้นว่างได้ถ้าไม่มีรหัสผ่าน" class="mt-2 w-full rounded-2xl border border-slate-200 bg-white px-4 py-3 text-slate-950 outline-none ring-emerald-400/20 transition placeholder:text-slate-400 focus:border-emerald-400 focus:ring-4">
                    <p class="mt-2 text-xs text-slate-500">{{ $target->exists ? 'เว้นว่างไว้ถ้าไม่ต้องการเปลี่ยนรหัสผ่าน' : 'ระบบจะเข้ารหัสก่อนเก็บลงฐานข้อมูล' }}</p>
                    @error('password') <p class="mt-2 text-sm font-bold text-rose-600">{{ $message }}</p> @enderror
                </div>
            </div>
        </div>

        <div class="rounded-[2rem] border border-slate-100 bg-white p-6 shadow-sm shadow-slate-200/80">
            <div class="mb-6">
                <p class="text-xs font-black uppercase tracking-[0.22em] text-emerald-600">Storage & Schedule</p>
                <h2 class="mt-2 text-2xl font-black text-slate-950">ตำแหน่งไฟล์และรอบเวลา</h2>
            </div>

            <div class="grid gap-5 md:grid-cols-2">
                <div>
                    <label for="dump_binary_path" class="block text-sm font-black text-slate-700">Path mysqldump/mariadb-dump</label>
                    <input id="dump_binary_path" name="dump_binary_path" value="{{ old('dump_binary_path', $target->dump_binary_path) }}" placeholder="เว้นว่างได้ ระบบเลือกให้อัตโนมัติ" class="mt-2 w-full rounded-2xl border border-slate-200 bg-white px-4 py-3 text-slate-950 outline-none ring-emerald-400/20 transition placeholder:text-slate-400 focus:border-emerald-400 focus:ring-4">
                    <p class="mt-2 text-xs text-slate-500">แนะนำให้เว้นว่าง ยกเว้นต้องใช้ dump tool เฉพาะระบบ</p>
                </div>

                <div>
                    <label for="backup_path" class="block text-sm font-black text-slate-700">Backup Path</label>
                    <input id="backup_path" name="backup_path" value="{{ old('backup_path', $target->backup_path) }}" placeholder="storage/app/backups" class="mt-2 w-full rounded-2xl border border-slate-200 bg-white px-4 py-3 text-slate-950 outline-none ring-emerald-400/20 transition placeholder:text-slate-400 focus:border-emerald-400 focus:ring-4">
                    <p class="mt-2 text-xs text-slate-500">ใส่ relative path หรือ absolute path ได้ เช่น D:\DBBackups</p>
                </div>

                <div class="md:col-span-2">
                    <label for="notification_emails" class="block text-sm font-black text-slate-700">Notification Emails</label>
                    <textarea id="notification_emails" name="notification_emails" rows="3" placeholder="admin@example.com, dba@example.com" class="mt-2 w-full rounded-2xl border border-slate-200 bg-white px-4 py-3 text-slate-950 outline-none ring-emerald-400/20 transition placeholder:text-slate-400 focus:border-emerald-400 focus:ring-4">{{ old('notification_emails', $target->notification_emails) }}</textarea>
                    <p class="mt-2 text-xs text-slate-500">ใส่อีเมลคั่นด้วย comma หรือขึ้นบรรทัดใหม่ ระบบจะแจ้งเตือนเมื่อ backup ล้มเหลว ถ้าเว้นว่างจะใช้ `BACKUP_ALERT_EMAILS` ใน `.env`</p>
                    @error('notification_emails') <p class="mt-2 text-sm font-bold text-rose-600">{{ $message }}</p> @enderror
                </div>

                <div>
                    <label for="schedule_frequency" class="block text-sm font-black text-slate-700">รอบการ Backup</label>
                    <select id="schedule_frequency" name="schedule_frequency" class="mt-2 w-full rounded-2xl border border-slate-200 bg-white px-4 py-3 text-slate-950 outline-none ring-emerald-400/20 transition focus:border-emerald-400 focus:ring-4">
                        @foreach (['manual' => 'Manual', 'daily' => 'Daily', 'weekly' => 'Weekly', 'monthly' => 'Monthly'] as $value => $label)
                            <option value="{{ $value }}" @selected(old('schedule_frequency', $target->schedule_frequency) === $value)>{{ $label }}</option>
                        @endforeach
                    </select>
                </div>

                <div>
                    <label for="schedule_time" class="block text-sm font-black text-slate-700">เวลา</label>
                    <input id="schedule_time" name="schedule_time" type="time" value="{{ old('schedule_time', $target->schedule_time) }}" class="mt-2 w-full rounded-2xl border border-slate-200 bg-white px-4 py-3 text-slate-950 outline-none ring-emerald-400/20 transition focus:border-emerald-400 focus:ring-4">
                </div>

                <div>
                    <label for="retention_days" class="block text-sm font-black text-slate-700">เก็บย้อนหลัง (วัน)</label>
                    <input id="retention_days" name="retention_days" type="number" min="1" max="3650" value="{{ old('retention_days', $target->retention_days) }}" required class="mt-2 w-full rounded-2xl border border-slate-200 bg-white px-4 py-3 text-slate-950 outline-none ring-emerald-400/20 transition focus:border-emerald-400 focus:ring-4">
                </div>

                <div class="md:col-span-2">
                    <label for="description" class="block text-sm font-black text-slate-700">รายละเอียด</label>
                    <textarea id="description" name="description" rows="4" class="mt-2 w-full rounded-2xl border border-slate-200 bg-white px-4 py-3 text-slate-950 outline-none ring-emerald-400/20 transition focus:border-emerald-400 focus:ring-4">{{ old('description', $target->description) }}</textarea>
                </div>
            </div>
        </div>
    </section>

    <aside class="space-y-5">
        <div class="rounded-[2rem] border border-emerald-100 bg-emerald-50 p-6">
            <h3 class="text-lg font-black text-slate-950">สถานะระบบ</h3>
            <label class="mt-5 flex items-center gap-3 rounded-2xl bg-white p-4 text-sm font-bold text-slate-700">
                <input name="is_active" type="checkbox" value="1" @checked(old('is_active', $target->is_active)) class="h-5 w-5 rounded border-slate-300 text-emerald-500">
                เปิดใช้งาน target นี้
            </label>
            <p class="mt-4 text-sm leading-6 text-slate-500">ถ้าปิดใช้งาน ระบบจะไม่อนุญาตให้ Backup Now สำหรับ target นี้</p>
        </div>

        <div class="rounded-[2rem] border border-slate-100 bg-white p-6 shadow-sm shadow-slate-200/80">
            <h3 class="text-lg font-black text-slate-950">คำแนะนำ</h3>
            <ul class="mt-4 space-y-3 text-sm leading-6 text-slate-500">
                <li>ใช้ `127.0.0.1` แทน `localhost` สำหรับฐานในเครื่องเดียวกัน</li>
                <li>MariaDB บน WAMP มักใช้ port `3307`</li>
                <li>MySQL บน WAMP มักใช้ port `3306`</li>
                <li>ถ้าไม่มี password ให้เว้นช่อง password ว่างได้</li>
            </ul>
        </div>

        <div class="flex flex-col gap-3">
            <button class="rounded-2xl bg-emerald-500 px-6 py-4 text-sm font-black text-white shadow-lg shadow-emerald-200 transition hover:-translate-y-0.5 hover:bg-emerald-600">บันทึกข้อมูล</button>
            <a href="{{ route('backup-targets.index') }}" class="rounded-2xl border border-slate-200 bg-white px-6 py-4 text-center text-sm font-black text-slate-700 transition hover:bg-slate-50">ยกเลิก</a>
        </div>
    </aside>
</div>
