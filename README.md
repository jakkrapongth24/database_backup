# DB Backup Management System

Laravel application for managing MariaDB/MySQL backup targets, running manual and scheduled backups, keeping backup history, and auditing actions.

## Quick Start

1. Configure `.env`
2. Clear cached config when `.env` changes
3. Start the web app
4. Start the queue worker

```bash
php artisan optimize:clear
php artisan serve --host=127.0.0.1 --port=8081
php artisan queue:work --tries=1
```

If you use Vite during development:

```bash
npm run dev
```

Or use the prepared shortcuts:

```bash
composer dev
composer dev:backend
composer queue:work
composer schedule:work
```

Windows `.bat` helpers are available here:

- `scripts/windows/start-dev.bat`
- `scripts/windows/start-worker.bat`
- `scripts/windows/start-scheduler.bat`
- `scripts/windows/import-task-scheduler-tasks.bat`
- `scripts/windows/import-task-scheduler-tasks.ps1`

Windows Task Scheduler import files are available here:

- `scripts/windows/task-scheduler/db-backup-scheduler.xml`
- `scripts/windows/task-scheduler/db-backup-queue-worker.xml`

The one-click importer will request Administrator permission through Windows UAC before importing tasks.

## Important Queue Note

Manual backup now runs through Laravel queue.

If a backup stays at `QUEUED`, the usual cause is that no queue worker is running.

## Useful Commands

```bash
php artisan backup:run-scheduled --dry-run
php artisan backup:cleanup --dry-run
php artisan backup:send-daily-summary --dry-run
php artisan schedule:list
php artisan queue:work --tries=1
php artisan schedule:work
```

## Authentication

Login users are read from `bp_webapp.personel`.

## Default Local Paths

```env
BACKUP_DEFAULT_PATH=storage/app/backups
BACKUP_MARIADB_DUMP_BINARY_PATH=C:/wamp64/bin/mariadb/mariadb11.4.9/bin/mariadb-dump.exe
BACKUP_MYSQL_DUMP_BINARY_PATH=C:/wamp64/bin/mysql/mysql8.4.7/bin/mysqldump.exe
BACKUP_DAILY_SUMMARY_EMAILS=
```
