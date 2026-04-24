<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        if (! Schema::hasColumn('restore_jobs', 'create_safety_backup')) {
            Schema::table('restore_jobs', function (Blueprint $table) {
                $table->boolean('create_safety_backup')->default(true)->after('restore_binary_path');
            });
        }

        if (in_array(DB::getDriverName(), ['mysql', 'mariadb'], true)) {
            DB::statement("ALTER TABLE restore_jobs MODIFY status ENUM('queued', 'running', 'success', 'failed') NOT NULL DEFAULT 'queued'");
        }
    }

    public function down(): void
    {
        if (in_array(DB::getDriverName(), ['mysql', 'mariadb'], true)) {
            DB::statement("ALTER TABLE restore_jobs MODIFY status ENUM('running', 'success', 'failed') NOT NULL DEFAULT 'running'");
        }

        if (Schema::hasColumn('restore_jobs', 'create_safety_backup')) {
            Schema::table('restore_jobs', function (Blueprint $table) {
                $table->dropColumn('create_safety_backup');
            });
        }
    }
};
