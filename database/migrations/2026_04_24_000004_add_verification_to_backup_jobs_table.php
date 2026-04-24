<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('backup_jobs', function (Blueprint $table) {
            $table->string('verification_status', 20)->nullable()->after('dump_binary_path')->index();
            $table->timestamp('verified_at')->nullable()->after('verification_status');
            $table->text('verification_message')->nullable()->after('verified_at');
        });
    }

    public function down(): void
    {
        Schema::table('backup_jobs', function (Blueprint $table) {
            $table->dropColumn([
                'verification_status',
                'verified_at',
                'verification_message',
            ]);
        });
    }
};
