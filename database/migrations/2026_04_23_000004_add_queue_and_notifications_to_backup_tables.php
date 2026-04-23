<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('backup_targets', function (Blueprint $table) {
            $table->text('notification_emails')->nullable()->after('backup_path');
        });

        if (in_array(DB::getDriverName(), ['mysql', 'mariadb'], true)) {
            DB::statement("ALTER TABLE backup_jobs MODIFY status ENUM('queued', 'running', 'success', 'failed') NOT NULL DEFAULT 'queued'");
        }
    }

    public function down(): void
    {
        if (in_array(DB::getDriverName(), ['mysql', 'mariadb'], true)) {
            DB::statement("ALTER TABLE backup_jobs MODIFY status ENUM('running', 'success', 'failed') NOT NULL DEFAULT 'running'");
        }

        Schema::table('backup_targets', function (Blueprint $table) {
            $table->dropColumn('notification_emails');
        });
    }
};
