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

---

## อัปเดตงานต่อเนื่อง (2026-04-24 รอบ Backup Verification)

### ทำเพิ่มแล้ว

- เพิ่มระบบตรวจสอบไฟล์ backup หลัง backup สำเร็จ
- เพิ่ม migration `2026_04_24_000004_add_verification_to_backup_jobs_table.php`
- เพิ่ม field ใน `backup_jobs`
  - `verification_status`
  - `verified_at`
  - `verification_message`
- เพิ่ม `BackupVerificationService`
  - ตรวจว่า backup job มี path ของไฟล์
  - ตรวจว่าไฟล์มีอยู่จริง
  - ตรวจว่าไฟล์อ่านได้
  - ตรวจว่าไฟล์ไม่ว่าง
  - ถ้าเป็น `.gz` จะลองเปิดอ่านด้วย `gzopen/gzread`
- ผูก verification เข้า `DatabaseBackupService`
  - หลัง dump สำเร็จ ระบบจะ verify ไฟล์ทันที
  - ถ้า verify ผ่าน จะบันทึก `verification_status = passed`
  - ถ้า verify ไม่ผ่าน จะบันทึก `verification_status = failed` และถือว่า backup job ล้มเหลว
- เพิ่ม audit log
  - `backup.verified`
  - `backup.verification_failed`
- เพิ่มคำสั่ง Artisan สำหรับตรวจ backup ย้อนหลัง

```bash
php artisan backup:verify --dry-run
php artisan backup:verify
php artisan backup:verify --target=1
php artisan backup:verify --job=1
```

- เพิ่มสถานะ verification ในหน้า `Backup History`
  - summary `Verified`
  - summary `Verify Failed`
  - badge `VERIFY PASSED` / `VERIFY FAILED` ในแต่ละรายการ
  - แสดงข้อความผล verification ใต้ path ของไฟล์
- เพิ่ม test ใหม่ `tests/Feature/BackupVerificationTest.php`
  - verify ไฟล์ `.sql.gz` ที่อ่านได้
  - บันทึก failure เมื่อไฟล์หาย
  - ตรวจคำสั่ง `backup:verify --dry-run`
- รัน migration เฉพาะไฟล์ใหม่ในฐานข้อมูลจริงสำเร็จแล้ว

```bash
php artisan migrate --path=database/migrations/2026_04_24_000004_add_verification_to_backup_jobs_table.php --force
```

### ตรวจสอบแล้ว

- `php artisan test` ผ่าน 12 tests
- `vendor\bin\pint.bat --dirty` ผ่าน
- `npm.cmd run build` ผ่าน
- `php -l app\Services\BackupVerificationService.php` ผ่าน
- `php -l routes\console.php` ผ่าน
- `php -l tests\Feature\BackupVerificationTest.php` ผ่าน

### งานที่ยังเหลือ / ควรทำต่อ

- เพิ่ม Offsite Copy เช่น copy backup ไปอีก drive หรือ network share หลัง verify ผ่าน
- เพิ่ม Restore Drill / Restore Report รายเดือน เพื่อสุ่มทดสอบว่า backup restore ได้จริง
- เพิ่ม notification เมื่อ verification failed แยกจาก backup failed ถ้าต้องการข้อความเฉพาะทาง
- เพิ่ม coverage flow อื่น ๆ เช่น create/edit target, backup now, download, queue monitor, reports
- ค่อย ๆ แก้ encoding ภาษาไทยในไฟล์เก่าที่แสดงเป็น mojibake ในบางจุด

---

## อัปเดตงานต่อเนื่อง (2026-04-24 รอบทำ Restore Drill ให้ง่ายขึ้น)

### ทำเพิ่มแล้ว

- ปรับหน้า `Restore Drills` ให้ใช้งานผ่านหน้าเว็บแบบกดปุ่มเดียว
- เพิ่มปุ่ม `ตรวจ Restore ตอนนี้`
- เพิ่ม dropdown ให้เลือกได้ว่าจะตรวจ
  - ทุก target ที่เปิดใช้งาน
  - หรือเลือก target เดียว
- เพิ่มคำอธิบายบนหน้าเว็บเป็น 3 ขั้นตอนสั้น ๆ
  - เลือก target หรือปล่อยเป็นตรวจทั้งหมด
  - กดปุ่มตรวจ Restore ตอนนี้
  - ดูผลด้านล่าง ถ้าขึ้น SUCCESS คือ backup พร้อมใช้
- แก้ข้อความในหน้า `Restore Drills` ให้เป็นภาษาไทยอ่านง่ายขึ้น
- เพิ่ม route `POST /restore-drills/run`
- เพิ่ม `RestoreDrillController::run()`
  - รับ target ที่เลือก
  - รัน `RestoreDrillService` ให้ทันที
  - redirect กลับมาหน้าเดิมพร้อมสรุปผลผ่าน/ไม่ผ่าน
- เพิ่ม test ว่ากดปุ่มจากหน้าเว็บแล้วสร้าง restore drill record ได้จริง

### วิธีใช้งานแบบง่าย

1. เข้าเมนู `Restore Drills`
2. เลือก target หรือปล่อยเป็น `ตรวจทุก Target ที่เปิดใช้งาน`
3. กด `ตรวจ Restore ตอนนี้`
4. ดูผลด้านล่าง
   - `SUCCESS` = backup พร้อมใช้
   - `FAILED` = มีจุดที่ต้องแก้ เช่น ไฟล์หาย หรือ backup ยังไม่ผ่าน verification

### งานที่ยังเหลือ / ควรทำต่อ

- เพิ่มปุ่ม export รายงาน Restore Drill เป็น CSV/Excel/PDF
- เพิ่ม drill แบบ restore เข้า test database จริง โดยใช้ target ทดสอบแยกจาก production
- เพิ่ม retention cleanup ฝั่ง offsite path ถ้าต้องการลบไฟล์สำรองปลายทางตามอายุ

---

## อัปเดตงานต่อเนื่อง (2026-04-24 รอบ Export Restore Drill Report)

### ทำเพิ่มแล้ว

- เพิ่มปุ่ม export ในหน้า `Restore Drills`
  - `CSV`
  - `Excel`
  - `PDF`
- export จะใช้ filter ปัจจุบันจากหน้าเว็บร่วมด้วย เช่น target, status, date range
- เพิ่ม routes
  - `GET /restore-drills/export/csv`
  - `GET /restore-drills/export/excel`
  - `GET /restore-drills/export/pdf`
- เพิ่ม method ใน `RestoreDrillController`
  - `exportCsv()`
  - `exportExcel()`
  - `exportPdf()`
- เพิ่ม view export
  - `resources/views/restore-drills/export-excel.blade.php`
  - `resources/views/restore-drills/export-pdf.blade.php`
- ปรับ `RestoreDrillController` ให้แยก logic filter/query/summary/export report ออกเป็น helper method เพื่อใช้ซ้ำระหว่างหน้าเว็บและ export
- แก้ข้อความไทยใน `RestoreDrillController` ให้แสดงถูกต้อง
- เขียน `tests/Feature/RestoreDrillTest.php` ใหม่ให้สะอาดจาก mojibake
- เพิ่ม test สำหรับ export Restore Drill report

### ตรวจสอบแล้ว

- `php artisan test --filter=RestoreDrillTest` ผ่าน 7 tests
- `php -l app\Http\Controllers\RestoreDrillController.php` ผ่าน
- `php -l tests\Feature\RestoreDrillTest.php` ผ่าน

### งานที่ยังเหลือ / ควรทำต่อ

- เพิ่ม drill แบบ restore เข้า test database จริง โดยใช้ target ทดสอบแยกจาก production
- เพิ่ม retention cleanup ฝั่ง offsite path ถ้าต้องการลบไฟล์สำรองปลายทางตามอายุ
- เพิ่ม coverage flow อื่น ๆ เช่น create/edit target, backup now, download, queue monitor, reports

---

## อัปเดตงานต่อเนื่อง (2026-04-24 รอบ Offsite Copy)

### ทำเพิ่มแล้ว

- เพิ่มระบบ Offsite Copy หลัง backup ผ่าน verification
- เพิ่ม migration `2026_04_24_000005_add_offsite_copy_to_backup_jobs_table.php`
- เพิ่ม field ใน `backup_jobs`
  - `offsite_status`
  - `offsite_copied_at`
  - `offsite_path`
  - `offsite_message`
- เพิ่ม `BackupOffsiteCopyService`
  - ถ้าไม่ได้ตั้ง `BACKUP_OFFSITE_PATH` จะบันทึก `offsite_status = skipped`
  - ถ้าตั้ง `BACKUP_OFFSITE_PATH` จะ copy ไฟล์ backup ไปยังปลายทางสำรอง
  - แยกโฟลเดอร์ปลายทางตามชื่อ target
  - ตรวจขนาดไฟล์ต้นทางและปลายทางว่าตรงกันหลัง copy
  - ถ้า copy ไม่สำเร็จจะบันทึก `offsite_status = failed`
- ผูก Offsite Copy เข้า `DatabaseBackupService`
  - flow หลัง backup สำเร็จตอนนี้คือ dump -> verify -> offsite copy -> retention cleanup
- เพิ่ม audit log
  - `backup.offsite_copied`
  - `backup.offsite_failed`
- เพิ่มคำสั่ง Artisan สำหรับ copy backup ที่ verify ผ่านแล้วย้อนหลัง

```bash
php artisan backup:copy-offsite --dry-run
php artisan backup:copy-offsite
php artisan backup:copy-offsite --target=1
php artisan backup:copy-offsite --job=1
```

- เพิ่มค่าใน `.env.example`

```env
BACKUP_OFFSITE_PATH=
```

- เพิ่มสถานะ Offsite ในหน้า `Backup History`
  - summary `Offsite Copied`
  - summary `Offsite Failed`
  - badge `OFFSITE COPIED` / `OFFSITE FAILED` / `OFFSITE SKIPPED`
  - แสดง offsite path หรือข้อความสถานะใต้ path ของไฟล์
- เพิ่มคำอธิบายในหน้า `Automation Guide`
  - อธิบาย `BACKUP_OFFSITE_PATH`
  - เพิ่มตัวอย่าง `BACKUP_OFFSITE_PATH=D:/DB_Backup_Offsite`
  - เพิ่มคำสั่ง `php artisan backup:copy-offsite --dry-run`
- เพิ่ม test ใหม่ `tests/Feature/BackupOffsiteCopyTest.php`
  - copy ไฟล์ไป offsite path สำเร็จ
  - skip เมื่อไม่ได้ตั้ง `BACKUP_OFFSITE_PATH`
  - ตรวจคำสั่ง `backup:copy-offsite --dry-run`
- รัน migration เฉพาะไฟล์ใหม่ในฐานข้อมูลจริงสำเร็จแล้ว

```bash
php artisan migrate --path=database/migrations/2026_04_24_000005_add_offsite_copy_to_backup_jobs_table.php --force
```

### ตรวจสอบแล้ว

- `php artisan test` ผ่าน 15 tests
- `vendor\bin\pint.bat --dirty` ผ่าน
- `npm.cmd run build` ผ่าน
- `php artisan backup:copy-offsite --dry-run` ผ่าน และพบ backup ที่ verify ผ่านแล้ว 1 รายการที่ยังไม่ได้ copy
- `php -l app\Services\BackupOffsiteCopyService.php` ผ่าน
- `php -l routes\console.php` ผ่าน
- `php -l tests\Feature\BackupOffsiteCopyTest.php` ผ่าน
- `php -l app\Http\Controllers\AutomationGuideController.php` ผ่าน

### วิธีเปิดใช้งาน Offsite Copy

ตั้งค่าใน `.env` เป็น path ปลายทางที่ต้องการ เช่น:

```env
BACKUP_OFFSITE_PATH=D:/DB_Backup_Offsite
```

หลังจากตั้งค่าแล้ว backup ใหม่ที่ verify ผ่านจะถูก copy ไปปลายทางนี้อัตโนมัติ ถ้าต้องการ copy backup เก่าที่ยังไม่ได้ copy ให้รัน:

```bash
php artisan backup:copy-offsite
```

### งานที่ยังเหลือ / ควรทำต่อ

- เพิ่ม Restore Drill / Restore Report รายเดือน เพื่อสุ่ม restore backup ไปฐานทดสอบและยืนยันว่าใช้งานได้จริง
- เพิ่ม notification เฉพาะเมื่อ offsite copy failed หรือ verification failed
- เพิ่ม retention cleanup ฝั่ง offsite path ถ้าต้องการลบไฟล์สำรองปลายทางตามอายุ
- เพิ่ม coverage flow อื่น ๆ เช่น create/edit target, backup now, download, queue monitor, reports
- ค่อย ๆ แก้ encoding ภาษาไทยในไฟล์เก่าที่แสดงเป็น mojibake ในบางจุด

---

## อัปเดตงานต่อเนื่อง (2026-04-24 รอบ Restore Drill Report)

### ทำเพิ่มแล้ว

- เพิ่มระบบ Restore Drill / Restore Report สำหรับซ้อมตรวจความพร้อมของ backup โดยยังไม่ restore ทับฐานข้อมูลจริง
- เพิ่ม migration `2026_04_24_000006_create_restore_drills_table.php`
- เพิ่มตาราง `restore_drills`
  - `backup_target_id`
  - `backup_job_id`
  - `status`
  - `started_at`
  - `finished_at`
  - `duration_seconds`
  - `source_name`
  - `source_path`
  - `checks`
  - `error_message`
  - `created_by`
- เพิ่ม model `RestoreDrill`
- เพิ่ม relation
  - `BackupTarget::restoreDrills()`
  - `BackupJob::restoreDrills()`
- เพิ่ม `RestoreDrillService`
  - เลือก backup ล่าสุดที่ `success` ของ target
  - ตรวจว่า backup job สำเร็จ
  - ตรวจว่า backup เป็นของ target นั้นจริง
  - ตรวจว่า `verification_status = passed`
  - ตรวจว่าไฟล์มี path, มีอยู่จริง, อ่านได้ และไม่ว่าง
  - ถ้าเป็น `.gz` จะลองเปิดอ่านด้วย `gzopen/gzread`
  - บันทึกผลตรวจเป็น JSON ใน `checks`
- เพิ่มคำสั่ง Artisan

```bash
php artisan backup:restore-drill --dry-run
php artisan backup:restore-drill
php artisan backup:restore-drill --target=1
php artisan backup:restore-drill --job=1
```

- เพิ่ม scheduler ให้รัน restore drill รายเดือนทุกวันที่ 1 เวลา 08:00
- เพิ่มหน้า `Restore Drills` ที่ `/restore-drills`
  - ดู summary ทั้งหมด/ผ่าน/ไม่ผ่าน/กำลังตรวจ
  - filter ตาม target, status, วันที่
  - ดู checks รายข้อของแต่ละ drill
- เพิ่มเมนู `Restore Drills` ใน sidebar พร้อม icon ใหม่
- เพิ่มคำสั่ง restore drill ในหน้า `Automation Guide`
- เพิ่ม test ใหม่ `tests/Feature/RestoreDrillTest.php`
  - drill ผ่านเมื่อ backup ล่าสุด verify ผ่านและไฟล์อ่านได้
  - drill ไม่ผ่านเมื่อ backup verification ไม่ผ่าน
  - command `backup:restore-drill --dry-run`
  - หน้า `/restore-drills` แสดงรายการได้
- รัน migration เฉพาะไฟล์ใหม่ในฐานข้อมูลจริงสำเร็จแล้ว

```bash
php artisan migrate --path=database/migrations/2026_04_24_000006_create_restore_drills_table.php --force
```

### ตรวจสอบแล้ว

- `php artisan test --filter=RestoreDrillTest` ผ่าน 4 tests
- `php -l app\Services\RestoreDrillService.php` ผ่าน
- `php -l app\Http\Controllers\RestoreDrillController.php` ผ่าน
- `php -l tests\Feature\RestoreDrillTest.php` ผ่าน
- `php -l routes\console.php` ผ่าน

### งานที่ยังเหลือ / ควรทำต่อ

- เพิ่ม drill แบบ restore เข้า test database จริง โดยใช้ target ทดสอบแยกจาก production
- เพิ่ม notification เมื่อ restore drill failed
- เพิ่ม export restore drill report เป็น CSV/Excel/PDF
- เพิ่ม retention cleanup ฝั่ง offsite path ถ้าต้องการลบไฟล์สำรองปลายทางตามอายุ
- เพิ่ม coverage flow อื่น ๆ เช่น create/edit target, backup now, download, queue monitor, reports
- ค่อย ๆ แก้ encoding ภาษาไทยในไฟล์เก่าที่แสดงเป็น mojibake ในบางจุด

---

## อัปเดตงานต่อเนื่อง (2026-04-24 รอบ Health Check Notifications)

### ทำเพิ่มแล้ว

- เพิ่ม email notification สำหรับ health check ที่ล้มเหลว
- เพิ่ม `BackupHealthCheckFailedMail`
- เพิ่ม view email `resources/views/emails/backup-health-check-failed.blade.php`
- เพิ่ม `BackupHealthAlertService`
  - ใช้อีเมลจาก `notification_emails` ของ target ก่อน
  - ถ้า target ไม่ได้ตั้งอีเมล จะ fallback ไปที่ `BACKUP_ALERT_EMAILS`
  - บันทึก audit log เมื่อส่งสำเร็จหรือส่งไม่สำเร็จ
- ผูก notification กับ failure สำคัญ 3 จุด
  - Backup verification failed
  - Offsite copy failed
  - Restore drill failed
- เพิ่ม audit log
  - `backup.health_notification_sent`
  - `backup.health_notification_failed`
- ปรับ `BackupOffsiteCopyService` ให้จัดการกรณี offsite path เป็นไฟล์แทนโฟลเดอร์ได้เรียบร้อยขึ้น โดยโยน error ที่อ่านเข้าใจได้
- เพิ่ม test
  - verification fail แล้วส่ง `BackupHealthCheckFailedMail`
  - offsite copy fail แล้วส่ง `BackupHealthCheckFailedMail`
  - restore drill fail แล้วส่ง `BackupHealthCheckFailedMail`

### ตรวจสอบแล้ว

- `php artisan test --filter=BackupVerificationTest` ผ่าน 4 tests
- `php artisan test --filter=BackupOffsiteCopyTest` ผ่าน 4 tests
- `php artisan test --filter=RestoreDrillTest` ผ่าน 5 tests
- `php -l app\Mail\BackupHealthCheckFailedMail.php` ผ่าน
- `php -l app\Services\BackupHealthAlertService.php` ผ่าน
- `php -l app\Services\BackupVerificationService.php` ผ่าน
- `php -l app\Services\BackupOffsiteCopyService.php` ผ่าน

### งานที่ยังเหลือ / ควรทำต่อ

- เพิ่ม drill แบบ restore เข้า test database จริง โดยใช้ target ทดสอบแยกจาก production
- เพิ่ม export restore drill report เป็น CSV/Excel/PDF
- เพิ่ม retention cleanup ฝั่ง offsite path ถ้าต้องการลบไฟล์สำรองปลายทางตามอายุ
- เพิ่ม coverage flow อื่น ๆ เช่น create/edit target, backup now, download, queue monitor, reports
- ค่อย ๆ แก้ encoding ภาษาไทยในไฟล์เก่าที่แสดงเป็น mojibake ในบางจุด

---

## อัปเดตงานต่อเนื่อง (2026-04-24 รอบ Restore Drill Actual Restore)

### ทำเพิ่มแล้ว

- เพิ่มโหมด actual restore สำหรับ Restore Drill แบบ opt-in
- ค่าเริ่มต้นยังเป็น readiness check เดิม ไม่ restore จริง เพื่อไม่ให้กระทบฐานข้อมูลโดยไม่ตั้งใจ
- ถ้าตั้ง `BACKUP_RESTORE_DRILL_ACTUAL_RESTORE=true` ระบบจะ:
  - เลือกชื่อฐานทดสอบจาก `BACKUP_RESTORE_DRILL_DATABASE`
  - ถ้าไม่ตั้ง จะใช้ชื่อ `{target_database}_restore_drill`
  - บังคับไม่ให้ชื่อฐานทดสอบตรงกับฐาน production
  - `DROP DATABASE IF EXISTS` แล้ว `CREATE DATABASE` สำหรับฐานทดสอบ
  - restore backup เข้า test database
  - นับจำนวน table หลัง restore
  - ลบ test database ทิ้งหลังจบงาน ยกเว้นตั้ง `BACKUP_RESTORE_DRILL_KEEP_DATABASE=true`
- เพิ่มค่า `.env.example`
  - `BACKUP_RESTORE_DRILL_ACTUAL_RESTORE=false`
  - `BACKUP_RESTORE_DRILL_DATABASE=`
  - `BACKUP_RESTORE_DRILL_DATABASE_SUFFIX=_restore_drill`
  - `BACKUP_RESTORE_DRILL_KEEP_DATABASE=false`
- เพิ่มคำอธิบายในหน้า `Automation Guide`
- เพิ่ม tests สำหรับ:
  - readiness-only mode จะ skip actual restore
  - actual restore mode จะปฏิเสธถ้าฐานทดสอบชื่อเดียวกับ production

### งานที่ยังเหลือ / ควรทำต่อ

- ทดสอบ actual restore กับ MariaDB/MySQL จริงบนเครื่องที่ตั้งค่า test database ได้
- เพิ่ม export restore drill report เป็น CSV/Excel/PDF ถ้ายังไม่ได้ deploy ในฐาน/branch ปัจจุบัน
- เพิ่ม retention cleanup ฝั่ง offsite path ถ้าต้องการลบไฟล์สำรองปลายทางตามอายุ
- เพิ่ม coverage flow อื่น ๆ เช่น create/edit target, backup now, download, queue monitor, reports

---

## อัปเดตงานต่อเนื่อง (2026-04-24 รอบ Restore Drill ใช้งานง่าย)

### ทำเพิ่มแล้ว

- เพิ่มตัวเลือกหน้า `Restore Drills` ให้เปิด actual restore ได้จากหน้าเว็บ
  - checkbox `Run actual restore into test database`
  - ช่อง `Test database name`
  - checkbox `Keep test database after drill`
- ถ้าไม่ติ๊ก actual restore ระบบจะยังทำ readiness check แบบปลอดภัยเหมือนเดิม
- ถ้าติ๊ก actual restore ระบบจะใช้ค่าจากฟอร์มทันที ไม่ต้องแก้ `.env`
- เพิ่ม option ให้คำสั่ง Artisan:

```bash
php artisan backup:restore-drill --actual-restore
php artisan backup:restore-drill --actual-restore --target=1
php artisan backup:restore-drill --actual-restore --test-database=accounting_restore_drill
php artisan backup:restore-drill --actual-restore --keep-test-database
```

- เพิ่ม test สำหรับการส่ง actual restore options จากหน้าเว็บ

### วิธีใช้แบบง่าย

1. เข้าเมนู `Restore Drills`
2. เลือก target ที่ต้องการ หรือปล่อยว่างเพื่อตรวจทุก target
3. ถ้าต้องการ restore จริง ให้ติ๊ก `Run actual restore into test database`
4. ช่อง `Test database name` ปล่อยว่างได้ ระบบจะใช้ `{database}_restore_drill`
5. กดปุ่มตรวจ Restore

ระบบจะไม่ยอมใช้ชื่อ test database ที่ตรงกับ database จริง

---

## อัปเดตงานต่อเนื่อง (2026-04-24 รอบ Offsite Retention Cleanup)

### ทำเพิ่มแล้ว

- ปรับ `BackupRetentionService` ให้ cleanup ไฟล์ offsite ที่หมดอายุพร้อมไฟล์ local
- ใช้ `retention_days` ของแต่ละ target เหมือน cleanup เดิม
- dry-run จะแสดงด้วยว่า offsite file มีอยู่หรือไม่
- ตอนลบจริงจะนับเพิ่ม:
  - `deleted_offsite_files`
  - `freed_bytes` รวมขนาดไฟล์ offsite
- เพิ่ม safety guard: ลบ offsite file เฉพาะ path ที่อยู่ใต้ `BACKUP_OFFSITE_PATH` เท่านั้น
- ปรับคำสั่ง `php artisan backup:cleanup` ให้แสดงจำนวน local/offsite ที่ลบ
- เพิ่มคำอธิบายในหน้า `Automation Guide`
- เพิ่ม test ใหม่ `tests/Feature/BackupRetentionTest.php`
  - ลบไฟล์ local และ offsite ที่หมดอายุได้
  - ไม่ลบ offsite path ที่อยู่นอก `BACKUP_OFFSITE_PATH`

### วิธีใช้

ตรวจดูก่อนว่าจะลบอะไร:

```bash
php artisan backup:cleanup --dry-run
```

ลบจริง:

```bash
php artisan backup:cleanup
```

ลบเฉพาะ target:

```bash
php artisan backup:cleanup --target=1
```

### งานที่ยังเหลือ / ควรทำต่อ

- เพิ่ม coverage flow อื่น ๆ เช่น create/edit target, backup now, download, queue monitor, reports
- ค่อย ๆ แก้ encoding ภาษาไทยในไฟล์เก่าที่แสดงเป็น mojibake ในบางจุด

---

## อัปเดตงานต่อเนื่อง (2026-04-24 รอบแก้ภาษา Dashboard)

### ทำเพิ่มแล้ว

- แก้ข้อความภาษาไทยบนหน้า `Dashboard` จาก mojibake ให้เป็นภาษาไทยอ่านง่าย
- ครอบคลุมส่วน:
  - hero ด้านบน
  - summary cards
  - scheduled backup warning
  - quick actions
  - กล่อง cleanup ผ่านหน้าเว็บ
  - automation command cards
- ไม่เปลี่ยน logic หรือข้อมูลที่หน้า Dashboard ใช้

### ตรวจสอบแล้ว

- `php -l resources/views/dashboard.blade.php` ผ่าน
- `php artisan test --filter=BackupRetentionTest` ผ่าน 3 tests

### งานที่ยังเหลือ / ควรทำต่อ

- ค่อย ๆ แก้ encoding ภาษาไทยในหน้าเก่าอื่น ๆ เช่น Backup Targets, Backup History, Reports, Restore Drills
- เพิ่ม coverage flow อื่น ๆ เช่น create/edit target, backup now, download, queue monitor, reports

---

## อัปเดตงานต่อเนื่อง (2026-04-24 รอบแก้ภาษา Backup Targets)

### ทำเพิ่มแล้ว

- แก้ข้อความภาษาไทยบนหน้า Backup Targets ให้เป็นภาษาไทยอ่านง่าย
- ครอบคลุมไฟล์:
  - `resources/views/backup-targets/index.blade.php`
  - `resources/views/backup-targets/create.blade.php`
  - `resources/views/backup-targets/edit.blade.php`
  - `resources/views/backup-targets/_form.blade.php`
  - `resources/views/backup-targets/show.blade.php`
- แก้ข้อความ confirm action สำคัญ:
  - Backup Now
  - Delete target
- แก้ข้อความบนฟอร์ม:
  - Connection
  - Storage & Schedule
  - Notification emails
  - Retention
  - คำแนะนำการกรอก host/port/password
- ไม่เปลี่ยน logic หรือข้อมูลที่หน้า Backup Targets ใช้

### ตรวจสอบแล้ว

- `php -l` สำหรับ Blade ใน `resources/views/backup-targets/*` ผ่าน

### งานที่ยังเหลือ / ควรทำต่อ

- แก้ encoding ภาษาไทยในหน้า Backup History, Reports, Restore Drills, Restore
- เพิ่ม coverage flow อื่น ๆ เช่น create/edit target, backup now, download, queue monitor, reports

---

## อัปเดตงานต่อเนื่อง (2026-04-24 รอบ Cleanup ใช้งานผ่านหน้าเว็บ)

### ทำเพิ่มแล้ว

- เพิ่ม controller `BackupCleanupController`
- เพิ่ม route สำหรับกดจากหน้าเว็บ:
  - `POST /backup-cleanup/preview`
  - `DELETE /backup-cleanup`
- เพิ่มกล่อง `ล้างไฟล์ Backup หมดอายุ` บนหน้า Dashboard
- เพิ่มปุ่ม:
  - `ตรวจไฟล์หมดอายุ` สำหรับ dry-run และแสดงรายการก่อนลบ
  - `ลบไฟล์หมดอายุ` สำหรับลบจริง พร้อม confirm
- หลังตรวจหรือลบ ระบบจะแสดง summary:
  - พบรายการ
  - ลบไฟล์ local
  - ลบไฟล์ offsite
  - ลบ record
  - คืนพื้นที่
- แสดงรายการตัวอย่างสูงสุด 20 รายการบน Dashboard
- เพิ่ม test ว่ากด preview แล้วไม่ลบไฟล์ และกดลบจริงแล้วลบไฟล์ local/offsite ได้

### วิธีใช้แบบไม่ต้องพิมพ์คำสั่ง

1. เข้า Dashboard
2. ไปที่กล่อง `ล้างไฟล์ Backup หมดอายุ`
3. กด `ตรวจไฟล์หมดอายุ`
4. ถ้ารายการถูกต้อง ค่อยกด `ลบไฟล์หมดอายุ`

### งานที่ยังเหลือ / ควรทำต่อ

- เพิ่ม coverage flow อื่น ๆ เช่น create/edit target, backup now, download, queue monitor, reports
- ค่อย ๆ แก้ encoding ภาษาไทยในไฟล์เก่าที่แสดงเป็น mojibake ในบางจุด
