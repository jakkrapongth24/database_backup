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
