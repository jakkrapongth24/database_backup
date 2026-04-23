<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('backup_targets', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->text('description')->nullable();
            $table->enum('db_type', ['mariadb', 'mysql'])->default('mariadb');
            $table->string('host', 191);
            $table->unsignedInteger('port')->default(3306);
            $table->string('database_name', 191);
            $table->string('username');
            $table->text('password')->nullable();
            $table->string('dump_binary_path')->nullable();
            $table->string('backup_path')->nullable();
            $table->enum('schedule_frequency', ['manual', 'daily', 'weekly', 'monthly'])->default('manual');
            $table->time('schedule_time')->nullable();
            $table->unsignedInteger('retention_days')->default(14);
            $table->boolean('is_active')->default(true);
            $table->boolean('last_connection_status')->nullable();
            $table->timestamp('last_connection_checked_at')->nullable();
            $table->text('last_connection_error')->nullable();
            $table->unsignedBigInteger('created_by')->nullable()->index();
            $table->unsignedBigInteger('updated_by')->nullable()->index();
            $table->timestamps();

            $table->index(['is_active', 'db_type']);
            $table->index('host');
            $table->index('database_name');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('backup_targets');
    }
};
