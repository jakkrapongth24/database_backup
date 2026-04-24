<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('backup_jobs', function (Blueprint $table) {
            $table->string('offsite_status', 20)->nullable()->after('verification_message')->index();
            $table->timestamp('offsite_copied_at')->nullable()->after('offsite_status');
            $table->string('offsite_path')->nullable()->after('offsite_copied_at');
            $table->text('offsite_message')->nullable()->after('offsite_path');
        });
    }

    public function down(): void
    {
        Schema::table('backup_jobs', function (Blueprint $table) {
            $table->dropColumn([
                'offsite_status',
                'offsite_copied_at',
                'offsite_path',
                'offsite_message',
            ]);
        });
    }
};
