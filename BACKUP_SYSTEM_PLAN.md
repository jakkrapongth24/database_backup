# DB Backup Management System

## Automation Update

- Added scheduled backup command: `php artisan backup:run-scheduled`
- Preview due scheduled targets without running backup: `php artisan backup:run-scheduled --dry-run`
- Run one target only: `php artisan backup:run-scheduled --target=1`
- Added retention cleanup command: `php artisan backup:cleanup`
- Preview expired files before deleting: `php artisan backup:cleanup --dry-run`
- Run cleanup for one target only: `php artisan backup:cleanup --target=1`
- Laravel Scheduler is configured in `bootstrap/app.php`.
- `backup:run-scheduled` is checked whenever Windows calls `php artisan schedule:run`.
- `backup:cleanup` runs hourly, but only removes files older than each target retention setting.
- For Windows Task Scheduler, call this command from the project folder every 1 hour: `php artisan schedule:run`
- Successful manual or scheduled backups also trigger retention cleanup for that target.
- Added Backup History filters by keyword, target, status, and date range.
- Added Reports page with success rate, total backup size, daily summary, target summary, and stale target warning.
- Added secure backup download from Backup History.
- Download is allowed only for successful jobs with an existing file inside the configured backup directory.
- Added Audit Logs table and page.
- Audit Logs capture login, logout, failed login, target create/update/delete, connection tests, backup requests, backup success/failure, downloads, and retention cleanup.
- Audit Logs can be filtered by keyword, action, and date range.

## สถานะปัจจุบัน

ระบบนี้เป็นเว็บสำหรับจัดการการ backup ฐานข้อมูล MariaDB/MySQL หลายระบบผ่าน Laravel โดยใช้บัญชีผู้ใช้จากตาราง `personel` ของระบบเดิม และให้ผู้ที่ login ได้เป็น Admin ทั้งหมด

## งานที่ทำได้แล้ว

- Login ด้วยข้อมูลจากตาราง `personel`
- Sync ข้อมูล `personel` จากฐาน `bp_webapp` บน server เดิม
- ใช้ฐานข้อมูลหลักของระบบนี้ชื่อ `db_backup`
- Dashboard แสดงสถิติพื้นฐานของระบบ backup
- จัดการ Backup Targets ได้
- เพิ่ม แก้ไข ลบ target ที่ต้องการ backup
- กำหนดชนิดฐานข้อมูล `MariaDB` หรือ `MySQL`
- กำหนด host, port, database, username, password ได้
- password ของ target สามารถเว้นว่างได้
- กำหนด Backup Path แยกแต่ละ target ได้
- Path `mysqldump/mariadb-dump` สามารถเว้นว่างได้ และระบบเลือกจากค่า default ให้
- ทดสอบ connection ของ target ได้
- กด Backup Now ได้
- สร้างไฟล์ backup เป็น `.sql.gz`
- เก็บประวัติ backup ใน `backup_jobs`
- มีหน้า Backup History
- แสดงสถานะ backup `success` หรือ `failed`
- แสดง file path, file size, เวลาเริ่ม, เวลาที่ใช้ และ error message
- รองรับ fallback จาก external dump tool ไปใช้ PHP/PDO dump เมื่อเรียก `mariadb-dump/mysqldump` จากเว็บบน Windows/WAMP แล้วมีปัญหา socket

## ค่าตั้งต้นสำคัญใน `.env`

```env
DB_CONNECTION=mariadb
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=db_backup
DB_USERNAME=root
DB_PASSWORD=

BP_WEBAPP_DB_CONNECTION=mariadb
BP_WEBAPP_DB_HOST=192.168.60.201
BP_WEBAPP_DB_PORT=3306
BP_WEBAPP_DB_DATABASE=bp_webapp
BP_WEBAPP_DB_USERNAME=Admin11106
BP_WEBAPP_DB_PASSWORD="Bph11106+"

BACKUP_DEFAULT_PATH=storage/app/backups
BACKUP_DUMP_BINARY_PATH=C:/wamp64/bin/mariadb/mariadb11.4.9/bin/mariadb-dump.exe
BACKUP_MARIADB_DUMP_BINARY_PATH=C:/wamp64/bin/mariadb/mariadb11.4.9/bin/mariadb-dump.exe
BACKUP_MYSQL_DUMP_BINARY_PATH=C:/wamp64/bin/mysql/mysql8.4.7/bin/mysqldump.exe
```

## คำสั่งที่ใช้งานบ่อย

```bash
php artisan serve
php artisan migrate --force
php artisan personel:sync-remote --fresh
php artisan optimize:clear
npm.cmd run build
php artisan test
```

## ตัวอย่างการกรอก Backup Target

สำหรับ MariaDB บน WAMP:

```text
DB Type: MariaDB
Host: 127.0.0.1
Port: 3307
Database: bp_webapp
Username: root
Password: ว่างได้
Path mysqldump/mariadb-dump: เว้นว่างได้
Backup Path: storage/app/backups
```

สำหรับ MySQL บน WAMP:

```text
DB Type: MySQL
Host: 127.0.0.1
Port: 3306
Database: ชื่อฐานข้อมูล
Username: root
Password: ว่างได้ถ้าไม่มี
Path mysqldump/mariadb-dump: เว้นว่างได้
Backup Path: storage/app/backups
```

## ปัญหาที่เจอและแนวทางแก้

- `localhost` บน Windows/WAMP อาจ resolve ไม่ได้ในบาง process
- แนะนำใช้ `127.0.0.1` แทน `localhost`
- `mariadb-dump.exe` และ `mysqldump.exe` อาจมีปัญหา `Can't create TCP/IP socket (10106)` เมื่อเรียกผ่านเว็บ
- ระบบจึงมี fallback เป็น PHP/PDO dump
- MySQL dump tool อาจไม่เข้ากับ MariaDB 11 บางกรณี
- ระบบจึงเลือก dump binary ตาม `db_type`
- ถ้าแก้ `.env` หรือ service แล้วเว็บยังใช้ค่าเดิม ให้รัน `php artisan optimize:clear` และ restart `php artisan serve`

## งานที่ควรทำต่อ

### 1. Retention และลบไฟล์เก่า

- ลบไฟล์ backup ที่เก่ากว่า `retention_days`
- ลบ record เก่าหรือ mark เป็น expired
- แสดงจำนวนไฟล์ที่จะถูกลบในหน้า target

### 2. Schedule อัตโนมัติ

- ใช้ Laravel Scheduler เพื่อ backup ตาม `schedule_frequency`
- รองรับ `manual`, `daily`, `weekly`, `monthly`
- เพิ่ม command เช่น `php artisan backup:run-scheduled`
- ตั้ง Windows Task Scheduler ให้เรียก Laravel Scheduler ทุกนาทีหรือทุกช่วงเวลา

### 3. Queue Job

- ย้าย Backup Now ไปทำผ่าน queue
- ป้องกันหน้าเว็บค้างเมื่อฐานข้อมูลใหญ่
- แสดงสถานะ `running` แบบ real-time หรือ refresh ได้

### 4. Download และ Restore

- เพิ่มปุ่ม download ไฟล์ backup
- เพิ่มระบบ restore แบบเลือกไฟล์
- ก่อน restore ควรมี confirmation และบันทึก audit log
- จำกัด restore ให้ใช้เฉพาะ Admin

### 5. Reports

- รายงาน backup รายวัน
- รายงาน backup รายเดือน
- อัตราสำเร็จและล้มเหลว
- ขนาดไฟล์รวมตาม target
- target ที่ไม่ได้ backup ในช่วงเวลาที่กำหนด
- export Excel/PDF

### 6. Notification

- แจ้งเตือนเมื่อ backup fail
- แจ้งเตือนผ่าน Line Notify, Email หรือระบบภายใน
- สรุปผล backup รายวันให้ Admin

### 7. Security

- เข้ารหัส password ของ target แล้ว ปัจจุบันใช้ encrypted cast ของ Laravel
- ควรเพิ่ม audit log สำหรับการเพิ่ม แก้ไข ลบ target
- ควรจำกัดการเข้าถึงไฟล์ backup ไม่ให้ public download ได้โดยตรง
- ควรกำหนด permission ของ backup folder ให้เหมาะสม

### 8. UI/UX เพิ่มเติม

- เพิ่ม filter ใน Backup History
- ค้นหาตาม target, status, date range
- เพิ่มหน้า target detail
- เพิ่มปุ่ม Backup Now ในหน้า detail
- แสดง backup ล่าสุดของแต่ละ target ใน Dashboard

## โครงสร้างตารางหลัก

```text
personel
backup_targets
backup_jobs
cache
jobs
sessions
```

## หมายเหตุ

ระบบตอนนี้เหมาะสำหรับเริ่มใช้งานภายในองค์กรและ backup ฐานข้อมูลขนาดเล็กถึงกลาง หากฐานข้อมูลมีขนาดใหญ่มาก ควรพิจารณาใช้ physical backup, replication, snapshot หรือ backup tool เฉพาะของ MariaDB/MySQL เพิ่มเติม
