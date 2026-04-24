<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('restore_jobs', function (Blueprint $table) {
            $table->string('current_step', 50)->nullable()->after('status');
            $table->unsignedTinyInteger('progress_percent')->default(0)->after('current_step');
            $table->string('progress_message')->nullable()->after('progress_percent');
        });
    }

    public function down(): void
    {
        Schema::table('restore_jobs', function (Blueprint $table) {
            $table->dropColumn(['current_step', 'progress_percent', 'progress_message']);
        });
    }
};
