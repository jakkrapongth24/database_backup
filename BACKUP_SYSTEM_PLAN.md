# DB Backup Management System

## ภาพรวมระบบ

ระบบนี้เป็นเว็บสำหรับจัดการการ backup ฐานข้อมูล `MariaDB` และ `MySQL` หลายระบบผ่าน Laravel  
ฐานข้อมูลหลักของระบบคือ `db_backup` และผู้ใช้สำหรับ login อ่านจาก `bp_webapp.personel`

---

## สถานะล่าสุดของโปรเจกต์

### ทำเสร็จแล้ว

#### 1. Authentication และ User

- Login ด้วย `username` และ `password`
- อ่านผู้ใช้จาก `bp_webapp.personel` โดยตรง
- model `User` ผูกกับ connection `bp_webapp`
- บัญชีที่ login ได้ถือเป็น Admin ทั้งหมด

#### 2. Backup Targets

- เพิ่ม / แก้ไข / ลบ Backup Target ได้
- รองรับ `MariaDB` และ `MySQL`
- ตั้งค่า `host`, `port`, `database`, `username`, `password` ได้
- ช่อง `password` เว้นว่างได้
- ตั้งค่า `backup_path` แยกแต่ละ target ได้
- ตั้งค่า `dump_binary_path` แยกแต่ละ target ได้
- รองรับ `notification_emails` ต่อ target
- มีปุ่ม `Test Connection`
- รองรับ `127.0.0.1` แทน `localhost` สำหรับเครื่อง Windows/WAMP

#### 3. Manual Backup

- มีปุ่ม `Backup Now`
- สร้างไฟล์ backup เป็น `.sql.gz`
- เก็บประวัติลงตาราง `backup_jobs`
- มีสถานะ `queued`, `running`, `success`, `failed`
- เก็บชื่อไฟล์, path, ขนาดไฟล์, เวลาเริ่ม, เวลาสิ้นสุด, ระยะเวลา และ error
- ถ้า dump tool ภายนอกมีปัญหา จะ fallback ไปใช้ `PHP/PDO dump`

#### 4. Queue และ Background Job

- ย้ายงาน `Backup Now` ไปทำผ่าน queue แล้ว
- งาน scheduled backup ก็เข้า queue เช่นกัน
- ถ้ามีงาน `queued` หรือ `running` อยู่แล้ว ระบบจะไม่คิวซ้ำ target เดิม
- หน้า `Backup History` และ `Dashboard` แสดงสถานะ `queued`
- มีคำสั่ง/สคริปต์สำหรับเปิด `queue worker`
- มีหน้า `Queue Monitor` สำหรับดู `jobs` และ `failed_jobs`
- retry failed job จากหน้าเว็บได้

#### 5. Notification เมื่อ Backup Fail

- ส่ง email แจ้งเตือนเมื่อ backup ล้มเหลว
- ใช้อีเมลจาก `notification_emails` ของ target ก่อน
- ถ้า target ไม่ได้ตั้งไว้ จะ fallback ไปที่ `BACKUP_ALERT_EMAILS` ใน `.env`
- มี mail view สำหรับข้อความแจ้งเตือนแล้ว
- มีคำสั่ง `backup:send-daily-summary`
- ส่ง daily summary email ให้ admin ได้
- scheduler เรียก daily summary อัตโนมัติได้

#### 6. Dashboard และ UI

- มี Dashboard แสดงสถิติหลักของระบบ
- มี sidebar navigation
- มีหน้า `Backup Targets`, `Backup History`, `Reports`, `Audit Logs`, `Automation Guide`
- ใช้ `SweetAlert2` สำหรับแจ้งเตือนและ confirm action
- รองรับการใช้งานทั้ง desktop และ mobile

#### 7. Backup History

- มีหน้า `Backup History`
- ค้นหาได้จาก keyword
- filter ตาม `target`
- filter ตาม `status`
- filter ตามช่วงวันที่
- มี summary ด้านบน
- แสดงสถานะ `queued`, `running`, `success`, `failed`

#### 8. Reports

- มีหน้า `Reports`
- สรุปจำนวนงาน backup
- แสดง success rate
- แสดงจำนวน failed
- แสดงขนาดไฟล์รวม
- แสดงเวลาเฉลี่ยที่ใช้ backup
- แสดงสรุปรายวัน
- แสดงสรุปตาม target
- แสดง target ที่ควรตรวจสอบ
- export รายงานเป็น CSV ได้
- export รายงานเป็น Excel ได้
- export รายงานเป็น PDF ได้

#### 9. Download Backup

- ดาวน์โหลดไฟล์ backup ได้จากหน้า `Backup History`
- ดาวน์โหลดได้เฉพาะรายการที่ `success`
- ตรวจสอบว่าไฟล์มีอยู่จริงก่อนดาวน์โหลด
- จำกัด path ให้อยู่ใน backup directory ที่ระบบอนุญาต

#### 10. Schedule และ Automation

- มีคำสั่ง `php artisan backup:run-scheduled`
- มี `--dry-run`
- มี `--target=ID`
- ตั้ง Laravel Scheduler ใน `bootstrap/app.php` แล้ว
- รองรับ schedule แบบ `manual`, `daily`, `weekly`, `monthly`
- มีหน้า `Automation Guide`
- มี `.bat` สำหรับ
  - เปิด dev stack
  - เปิด worker
  - เปิด scheduler worker
  - import tasks เข้า Windows Task Scheduler
- มีไฟล์ `.xml` สำหรับ import เข้า Windows Task Scheduler
- มี PowerShell script สำหรับ import tasks อัตโนมัติ 2 ตัวรวดเดียว

#### 11. Retention Cleanup

- มีคำสั่ง `php artisan backup:cleanup`
- มี `--dry-run`
- มี `--target=ID`
- ลบไฟล์ backup เก่าตาม `retention_days`
- ลบ record เก่าที่เกี่ยวข้อง
- scheduler เรียก cleanup อัตโนมัติได้
- หลัง backup สำเร็จ ระบบ trigger cleanup ของ target นั้นให้แล้ว

#### 12. Audit Logs

- มีตาราง `audit_logs`
- มีหน้า `Audit Logs`
- filter ตาม `action` และช่วงวันที่ได้
- บันทึกเหตุการณ์สำคัญ เช่น
  - login
  - logout
  - login failed
  - create / update / delete target
  - test connection
  - backup queued / completed / failed
  - download backup
  - retention cleanup
  - notification sent / notification failed
- ซ่อนข้อมูล password ใน metadata อัตโนมัติ

#### 13. UX ที่เพิ่งปรับเพิ่ม

- หลังแก้ไข `Backup Target` แล้วจะ redirect กลับมาหน้า edit เดิม
- หน้า edit แสดง `Last saved` เพื่อให้เห็นว่าบันทึกแล้วจริง
- มีหน้า detail ของแต่ละ target
- ดู summary และประวัติ backup ล่าสุดของ target เดียวได้
- กด `Backup Now` จากหน้า detail ได้

---

## งานที่เพิ่งเพิ่มในรอบล่าสุด

- เปลี่ยน auth ให้ใช้ `bp_webapp.personel` โดยตรง
- เพิ่ม `notification_emails` ใน target
- เพิ่มสถานะ `queued` ใน backup jobs
- ย้าย backup ไปทำผ่าน queue
- เพิ่ม email แจ้งเตือน backup fail
- เพิ่ม `RunBackupJob`
- เพิ่ม `BackupFailedMail`
- เพิ่มหน้า/คู่มือ Automation Guide ใหม่
- เพิ่ม export CSV จากหน้า Reports
- เพิ่มหน้า Target Detail
- เพิ่มหน้า Queue Monitor และปุ่ม retry failed job
- เพิ่ม daily backup summary email
- เพิ่ม export Reports เป็น Excel และ PDF
- เพิ่มไฟล์:
  - `scripts/windows/start-dev.bat`
  - `scripts/windows/start-worker.bat`
  - `scripts/windows/start-scheduler.bat`
  - `scripts/windows/import-task-scheduler-tasks.ps1`
  - `scripts/windows/import-task-scheduler-tasks.bat`
  - `scripts/windows/task-scheduler/db-backup-scheduler.xml`
  - `scripts/windows/task-scheduler/db-backup-queue-worker.xml`

---

## คำสั่งที่ใช้ได้ตอนนี้

```bash
php artisan serve --host=127.0.0.1 --port=8081
php artisan optimize:clear
php artisan test

php artisan queue:work --tries=1
php artisan schedule:work
php artisan schedule:list

php artisan backup:run-scheduled --dry-run
php artisan backup:run-scheduled --target=1
php artisan backup:cleanup --dry-run
php artisan backup:cleanup --target=1
php artisan backup:send-daily-summary --dry-run
```

คำสั่งผ่าน Composer:

```bash
composer dev
composer dev:backend
composer queue:work
composer schedule:work
```

---

## ไฟล์ Automation ที่เพิ่มไว้แล้ว

### Batch files

- `scripts/windows/start-dev.bat`
- `scripts/windows/start-worker.bat`
- `scripts/windows/start-scheduler.bat`
- `scripts/windows/import-task-scheduler-tasks.bat`

### PowerShell

- `scripts/windows/import-task-scheduler-tasks.ps1`

### Windows Task Scheduler XML

- `scripts/windows/task-scheduler/db-backup-scheduler.xml`
- `scripts/windows/task-scheduler/db-backup-queue-worker.xml`

---

## ค่า `.env` สำคัญ

```env
DB_CONNECTION=mariadb
DB_HOST=127.0.0.1
DB_PORT=3307
DB_DATABASE=db_backup
DB_USERNAME=root
DB_PASSWORD=

BP_WEBAPP_DB_CONNECTION=mariadb
BP_WEBAPP_DB_HOST=127.0.0.1
BP_WEBAPP_DB_PORT=3307
BP_WEBAPP_DB_DATABASE=bp_webapp
BP_WEBAPP_DB_USERNAME=root
BP_WEBAPP_DB_PASSWORD=

BACKUP_DEFAULT_PATH=storage/app/backups
BACKUP_DUMP_BINARY_PATH=C:/wamp64/bin/mariadb/mariadb11.4.9/bin/mariadb-dump.exe
BACKUP_MARIADB_DUMP_BINARY_PATH=C:/wamp64/bin/mariadb/mariadb11.4.9/bin/mariadb-dump.exe
BACKUP_MYSQL_DUMP_BINARY_PATH=C:/wamp64/bin/mysql/mysql8.4.7/bin/mysqldump.exe
BACKUP_ALERT_EMAILS=
BACKUP_DAILY_SUMMARY_EMAILS=

QUEUE_CONNECTION=database
MAIL_MAILER=log
```

---

## ปัญหาที่เคยเจอและแนวทางแก้

- ถ้า backup ค้างที่ `QUEUED`
  - สาเหตุหลักคือยังไม่มี `queue worker` รันอยู่
  - ให้เปิด `php artisan queue:work --tries=1`

- ถ้าแก้ `.env` แล้วค่าระบบไม่เปลี่ยน
  - ให้รัน `php artisan optimize:clear`
  - แล้ว restart `artisan serve`

- `localhost` บน Windows/WAMP บางครั้ง resolve มีปัญหา
  - แนะนำใช้ `127.0.0.1`

- `mariadb-dump.exe` หรือ `mysqldump.exe` อาจมี error บางเครื่อง
  - ระบบมี fallback เป็น `PHP/PDO dump`

- ถ้า import Windows Task Scheduler ไม่ได้
  - ใช้ `import-task-scheduler-tasks.bat`
  - ตอน UAC เด้งต้องกด `Yes`

- ฐานข้อมูลเครื่องนี้เคยมี schema อยู่แล้ว แต่ตาราง `migrations` ว่าง
  - ได้ sync migration state ให้ตรงกับ schema จริงแล้ว
  - หลังจากนี้ไม่ควรใช้ `migrate:fresh` กับฐานใช้งานนี้

---

## งานที่ยังเหลือ / ควรทำต่อ

### 1. Restore แบบปลอดภัย

- upload หรือเลือกไฟล์ backup เพื่อ restore
- ต้องมี confirmation หลายชั้น
- ต้องมี audit log ทุกครั้ง
- ควรจำกัดสิทธิ์อย่างเข้มงวด

### 2. Security เพิ่มเติม

- ตรวจสิทธิ์การเข้าถึงไฟล์ backup ให้ละเอียดขึ้น
- ตรวจ permission ของ backup folder
- พิจารณาแยก role ในอนาคต

### 3. UX/Validation เพิ่มเติม

- แสดงผลการบันทึก target ให้ชัดในหน้า list/detail
- ปรับข้อความภาษาไทยที่ยังเพี้ยนจาก encoding ในบางไฟล์เก่า
- เพิ่ม test ครอบ flow create/edit/backup/download/queue

---

## ลำดับงานที่แนะนำต่อจากนี้

1. Restore แบบปลอดภัย
2. Security เพิ่มเติม
3. UX/Validation เพิ่มเติม

---

## หมายเหตุ

ระบบตอนนี้สามารถใช้งานจริงในระดับจัดการ backup ภายในองค์กรได้แล้ว  
โดยเฉพาะ flow หลักคือ login, จัดการ target, backup, history, reports, cleanup, audit logs และ automation

ถ้าจะใช้งาน production มากขึ้น แนะนำเพิ่มเรื่องต่อไปนี้ร่วมด้วย:

- backup verification
- offsite copy
- restore test
- queue monitoring
- notification summary
- policy ด้านสิทธิ์และ audit ที่เข้มขึ้น

---

## อัปเดตงานล่าสุด (2026-04-24)

### ทำไปแล้วในรอบล่าสุด

- เพิ่มหน้า `Restore` ที่ `/restore`
- เพิ่มเมนู `Restore` ใน sidebar
- เพิ่มปุ่ม `Restore` ในหน้า Target Detail
- เพิ่มลิงก์ `Restore` จากหน้า Backup History สำหรับ backup job ที่สำเร็จ
- รองรับการ Restore ได้ 2 แบบ
  - เลือก backup job ที่สำเร็จแล้วของ target นั้น
  - upload ไฟล์ `.sql` หรือ `.sql.gz`
- เพิ่ม confirmation หลายชั้นก่อน restore
  - ต้องเลือก target ปลายทาง
  - ต้องพิมพ์ชื่อ database ให้ตรงทุกตัวอักษร
  - ต้องติ๊กยืนยันว่าเข้าใจว่า restore อาจเขียนทับข้อมูล
  - เปิดตัวเลือกสร้าง safety backup ก่อน restore เป็นค่าเริ่มต้น
- เพิ่ม `DatabaseRestoreService`
  - แตกไฟล์ `.sql.gz` ก่อน restore ได้
  - เรียก `mariadb.exe` / `mysql.exe` เพื่อ restore เข้า target ที่เลือก
  - ใช้ `host`, `port`, `database_name`, `username`, `password` จาก Backup Target
  - บังคับ `--protocol=TCP`
  - ส่ง Windows environment เช่น `SystemRoot`, `WINDIR`, `PATH`, `TEMP`, `TMP` เข้า process เพื่อลดปัญหา socket บน Windows
  - ถ้า client ตัวแรก restore ไม่สำเร็จ จะลอง client ตัวถัดไป และแสดง error แยกตาม client
- เพิ่ม audit log สำหรับ restore
  - `restore.requested`
  - `restore.completed`
  - `restore.failed`
- เพิ่มค่า `BACKUP_RESTORE_BINARY_PATH` ใน `.env.example`
- แปลหน้า `/restore` เป็นภาษาไทยแล้ว
- เพิ่ม test สำหรับ restore
  - เปิดหน้า restore ได้เมื่อ login แล้ว
  - กัน restore ถ้าพิมพ์ชื่อ database ยืนยันไม่ตรง
- ตรวจสอบแล้ว
  - `php artisan test` ผ่าน
  - `npm.cmd run build` ผ่าน
  - `vendor\bin\pint.bat --dirty` ผ่าน

### หมายเหตุจากปัญหาที่พบล่าสุด

- Restore target id `8` แสดงปลายทางเป็น `192.168.60.201:3306/bp_webapp`
- ตรวจจากเครื่องที่รันระบบแล้ว `Test-NetConnection 192.168.60.201 -Port 3306` ผ่าน
- เคยพบ error `ERROR 2004 (HY000): Can't create TCP/IP socket (10106)` ตอน restore
- ได้ปรับ restore process ให้บังคับ TCP และส่ง Windows environment เข้า process แล้ว
- ถ้ายังเจอ error เดิม ให้ตรวจต่อที่
  - path ของ `BACKUP_RESTORE_BINARY_PATH`
  - version ของ `mariadb.exe` / `mysql.exe`
  - user/password ของ target ปลายทาง
  - permission ของ database user สำหรับ restore
  - firewall / antivirus ที่อาจ block process ลูกของ PHP

### งานที่ยังเหลือ / ควรทำต่อ

- ทดสอบ restore กับฐานข้อมูลจริงขนาดเล็กก่อนใช้งาน production
- เพิ่มหน้าจอแสดง restore history แยกจาก audit log
- เพิ่มตาราง restore jobs ถ้าต้องการเก็บสถานะ restore แบบละเอียด เช่น `queued`, `running`, `success`, `failed`
- พิจารณาย้าย restore ไปทำผ่าน queue เพื่อไม่ให้ request หน้าเว็บค้างเมื่อไฟล์ใหญ่
- เพิ่ม progress/status สำหรับ restore ขนาดใหญ่
- เพิ่ม policy/role แยกสิทธิ์ restore ออกจาก admin ทั่วไป
- เพิ่ม validation ตรวจว่า backup job ที่เลือกเป็นของ target เดียวกัน และไฟล์ยังอยู่ใน path ที่อนุญาต ซึ่งตอนนี้ฝั่ง backend ตรวจแล้ว แต่อาจแสดงข้อความใน UI ให้ชัดขึ้น
- เพิ่ม restore dry-run หรือ pre-check เช่น ตรวจไฟล์ gzip, ตรวจ connection, ตรวจสิทธิ์ user ก่อนเริ่ม restore จริง
- เพิ่มคู่มือการตั้งค่า `BACKUP_RESTORE_BINARY_PATH` ในหน้า Automation Guide
- เพิ่ม test ครอบคลุม flow restore จาก upload และ restore จาก backup job โดย mock process ไม่ให้แตะ database จริง

---

## อัปเดตงานต่อเนื่อง (2026-04-24)

### ทำเพิ่มแล้ว

- เพิ่มตาราง `restore_jobs` สำหรับเก็บประวัติ Restore แยกจาก `audit_logs`
- เพิ่ม model `RestoreJob`
- เพิ่ม relation จาก `BackupTarget` ไปยัง restore jobs
- ปรับ `DatabaseRestoreService` ให้บันทึก restore job ทุกครั้ง
  - เริ่มงานเป็น `running`
  - สำเร็จเป็น `success`
  - ล้มเหลวเป็น `failed`
  - เก็บ `source_type`, `source_name`, `source_path`
  - เก็บ backup job ต้นทาง ถ้า restore จาก backup เดิม
  - เก็บ safety backup job ถ้ามีการสร้างก่อน restore
  - เก็บ error message เมื่อ restore ไม่สำเร็จ
- เพิ่มหน้า `Restore History` ที่ `/restore-history`
- เพิ่มเมนู `Restore History` ใน sidebar
- หน้า Restore หลักแสดงประวัติ Restore ล่าสุดของ target ที่เลือก
- หน้า Restore History รองรับ filter
  - keyword
  - target
  - status
  - source type
  - ช่วงวันที่
- เพิ่ม test สำหรับหน้า Restore History
- รัน migration เฉพาะไฟล์ใหม่ `2026_04_24_000001_create_restore_jobs_table.php` สำเร็จแล้ว

### ตรวจสอบแล้ว

- `php artisan test` ผ่าน 5 tests
- `npm.cmd run build` ผ่าน
- `vendor\bin\pint.bat --dirty` ผ่าน

### หมายเหตุ migration

- ตอนรัน `php artisan migrate --force` แบบปกติ พบว่า migration state ของฐานเดิมยังไม่ตรงกับ schema จริง เพราะตาราง `personel` มีอยู่แล้ว
- จึงรันเฉพาะ migration ใหม่ด้วยคำสั่ง:

```bash
php artisan migrate --path=database/migrations/2026_04_24_000001_create_restore_jobs_table.php --force
```

### งานที่ยังเหลือต่อจากนี้

- ย้าย Restore ไปทำผ่าน queue เพื่อรองรับไฟล์ใหญ่และลดโอกาส request timeout
- เพิ่ม restore pre-check/dry-run ก่อนเริ่มจริง
- เพิ่ม progress/status ระหว่าง restore
- เพิ่ม role/policy แยกสิทธิ์ Restore
- เพิ่มคู่มือ Restore และ `BACKUP_RESTORE_BINARY_PATH` ใน Automation Guide
- เพิ่ม test แบบ mock process สำหรับ restore จาก backup job และ upload โดยไม่แตะ database จริง

---

## อัปเดตงานต่อเนื่อง (2026-04-24 รอบ Restore Progress)

### ทำเพิ่มแล้ว

- เพิ่ม progress รายขั้นใน `restore_jobs`
  - `current_step`
  - `progress_percent`
  - `progress_message`
- เพิ่ม migration `2026_04_24_000003_add_progress_to_restore_jobs_table.php`
- Restore job ที่เพิ่ง queued จะเริ่มที่
  - `current_step = queued`
  - `progress_percent = 0`
  - `progress_message = Waiting for queue worker.`
- ระหว่าง worker ทำงาน จะอัปเดตขั้นตอนหลัก
  - `preparing`
  - `resolving_client`
  - `safety_backup`
  - `validating_source`
  - `preparing_sql`
  - `restoring`
  - `completed`
  - `failed`
- หน้า Restore History แสดง progress bar, step และข้อความล่าสุด
- หน้า Restore หลักแสดง progress ของรายการ Restore ล่าสุด
- เพิ่ม test ตรวจว่า restore job ที่ queued มี progress เริ่มต้นถูกต้อง

### ตรวจสอบแล้ว

- รัน migration progress ในฐานจริงสำเร็จแล้ว:

```bash
php artisan migrate --path=database/migrations/2026_04_24_000003_add_progress_to_restore_jobs_table.php --force
```

- `php artisan test` ผ่าน 7 tests
- `npm.cmd run build` ผ่าน
- `vendor\bin\pint.bat --dirty` ผ่าน

### งานที่เหลือหลังรอบนี้

- เพิ่ม test แบบ mock process สำหรับ restore จาก backup job และ upload โดยไม่แตะ database จริง

---

## อัปเดตงานต่อเนื่อง (2026-04-24 รอบ Restore Mock Tests)

### ทำเพิ่มแล้ว

- ปรับ `DatabaseRestoreService::runRestoreCommand()` จาก private เป็น protected เพื่อให้ mock ได้ใน automated tests
- เพิ่ม test restore จาก backup job โดย mock ขั้นตอนเรียก restore client
  - ไม่แตะ database จริง
  - ใช้ไฟล์ `.sql` จำลอง
  - ตรวจว่า restore job เปลี่ยนเป็น `success`
  - ตรวจว่า progress ไปถึง `completed` และ `100%`
- เพิ่ม test restore จาก uploaded file โดย mock ขั้นตอนเรียก restore client
  - ไม่แตะ database จริง
  - ใช้ไฟล์ `.sql` จำลองใน `storage/app/restore-uploads`
  - ตรวจว่า restore job เปลี่ยนเป็น `success`
  - ตรวจว่า source type ยังเป็น `upload`

### ตรวจสอบแล้ว

- `php artisan test` ผ่าน 9 tests
- `vendor\bin\pint.bat --dirty` ผ่าน
- `php -l app\Services\DatabaseRestoreService.php` ผ่าน

### สถานะงานคงเหลือ

- งานหลักตามแผนรอบ Restore/Security/UX ทำครบแล้ว
- งานเสริมที่อาจทำต่อในอนาคต
  - backup verification หลัง backup เสร็จ
  - offsite copy
  - restore drill/report รายเดือน
  - ปรับ encoding ภาษาไทยในไฟล์เก่าที่แสดงเป็น mojibake
  - เพิ่ม coverage สำหรับ flow create/edit/backup/download/queue แบบละเอียดขึ้น

---

## อัปเดตงานต่อเนื่อง (2026-04-24 รอบ Automation Guide)

### ทำเพิ่มแล้ว

- เพิ่มคู่มือ Restore Queue ในหน้า `Automation Guide`
- อธิบายว่า Restore ตอนนี้ทำงานผ่าน queue และต้องเปิด queue worker
- เพิ่มคำอธิบาย `BACKUP_RESTORE_BINARY_PATH`
- เพิ่มตัวอย่างค่า `.env` สำหรับ restore client
- เพิ่มคำแนะนำ Pre-check, Restore History และ Safety Backup

### งานที่ยังเหลือหลังรอบนี้

- เพิ่ม progress/status ระหว่าง restore ให้ละเอียดกว่า queued/running/success/failed
- เพิ่ม test แบบ mock process สำหรับ restore จาก backup job และ upload โดยไม่แตะ database จริง

---

## อัปเดตงานต่อเนื่อง (2026-04-24 รอบ Queue Restore)

### ทำเพิ่มแล้ว

- ย้าย Restore จริงไปทำผ่าน queue แล้ว
- เพิ่ม `RunRestoreJob`
- เพิ่มสถานะ `queued` ให้ `restore_jobs`
- เพิ่ม field `create_safety_backup` ใน `restore_jobs`
- เมื่อกดปุ่ม Restore ระบบจะ
  - validate และสร้าง restore job เป็น `queued`
  - dispatch job เข้า queue
  - redirect กลับหน้า Restore ทันที
  - แสดงข้อความว่า restore job กำลังรอ queue worker
- queue worker จะทำงาน restore จริงผ่าน `DatabaseRestoreService::runQueuedJob`
- Restore History แสดงสถานะ `queued`, `running`, `success`, `failed`
- เพิ่ม summary `รอคิว` ในหน้า Restore History
- เพิ่ม audit log action `restore.queued`
- เพิ่ม test ว่าการกด Restore จะสร้าง restore job เป็น `queued` และ push `RunRestoreJob`
- รัน migration เฉพาะไฟล์ใหม่สำเร็จแล้ว:

```bash
php artisan migrate --path=database/migrations/2026_04_24_000002_add_queue_state_to_restore_jobs_table.php --force
```

### ตรวจสอบแล้ว

- `php artisan test` ผ่าน 7 tests
- `npm.cmd run build` ผ่าน
- `vendor\bin\pint.bat --dirty` ผ่าน

### วิธีใช้งานหลังเปลี่ยนเป็น Queue

- หลังจากกด Restore ต้องมี queue worker รันอยู่ ไม่เช่นนั้น restore job จะค้างที่ `QUEUED`
- คำสั่ง worker:

```bash
php artisan queue:work --tries=1
```

- หรือใช้ script เดิม:

```bash
scripts/windows/start-worker.bat
```

### งานที่ยังเหลือหลังรอบนี้

- เพิ่ม progress/status ระหว่าง restore ให้ละเอียดกว่า queued/running/success/failed
- เพิ่มคู่มือ Restore และ `BACKUP_RESTORE_BINARY_PATH` ใน Automation Guide
- เพิ่ม test แบบ mock process สำหรับ restore จาก backup job และ upload โดยไม่แตะ database จริง

---

## อัปเดตงานต่อเนื่อง (2026-04-24 รอบ Pre-check)

### ทำเพิ่มแล้ว

- เพิ่มปุ่ม `ตรวจสอบก่อน Restore` ในหน้า `/restore`
- Pre-check ยังไม่เขียนข้อมูลลง database ปลายทาง
- Pre-check ไม่ต้องพิมพ์ชื่อ database และไม่ต้องติ๊กยืนยัน final restore
- Pre-check ตรวจสอบรายการต่อไปนี้
  - target เปิดใช้งานอยู่หรือไม่
  - พบ restore client เช่น `mariadb.exe` / `mysql.exe` หรือไม่
  - เชื่อมต่อ database ปลายทางได้หรือไม่
  - backup job เป็นของ target เดียวกันหรือไม่
  - backup job มีสถานะ `success` หรือไม่
  - ไฟล์ restore มีอยู่จริง อ่านได้ และไม่ว่างหรือไม่
  - ไฟล์ `.gz` เปิดอ่านได้หรือไม่
  - ถ้าเปิด safety backup จะตรวจว่า backup folder มีอยู่หรือสร้างได้ และเขียนได้หรือไม่
- เพิ่ม audit log action `restore.prechecked`
- เพิ่มผล Pre-check แสดงในหน้า Restore เป็นรายการ `PASSED` / `FAILED`
- ปรับ JavaScript confirm ให้ปุ่ม Pre-check ไม่ต้องขึ้น SweetAlert ยืนยันเหมือนปุ่ม Restore จริง
- เพิ่ม test สำหรับ pre-check

### ตรวจสอบแล้ว

- `php artisan test` ผ่าน 6 tests
- `npm.cmd run build` ผ่าน
- `vendor\bin\pint.bat --dirty` ผ่าน

### หมายเหตุเรื่อง Role

- ผู้ใช้ยืนยันว่าใช้งานคนเดียวและมีแค่ Admin อย่างเดียว
- งาน role/policy แยกสิทธิ์ Restore จึงยังไม่จำเป็นในระบบนี้

### งานที่เหลือ

ตอนนี้งานหลักตามแผน Restore/Security/UX ที่เราต่อกันมาถือว่าครบแล้วครับ งานที่เหลือเป็นงานเสริมอนาคต เช่น backup verification, offsite copy, restore drill/report รายเดือน, แก้ encoding ภาษาไทยไฟล์เก่า และเพิ่ม coverage flow อื่น ๆ ให้ละเอียดขึ้น.
