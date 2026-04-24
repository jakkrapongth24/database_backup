<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('restore_jobs', function (Blueprint $table) {
            $table->id();
            $table->foreignId('backup_target_id')->constrained()->cascadeOnDelete();
            $table->foreignId('backup_job_id')->nullable()->constrained('backup_jobs')->nullOnDelete();
            $table->foreignId('safety_backup_job_id')->nullable()->constrained('backup_jobs')->nullOnDelete();
            $table->enum('source_type', ['backup_job', 'upload']);
            $table->enum('status', ['queued', 'running', 'success', 'failed'])->default('queued');
            $table->timestamp('started_at')->nullable();
            $table->timestamp('finished_at')->nullable();
            $table->unsignedInteger('duration_seconds')->nullable();
            $table->string('source_name', 191)->nullable();
            $table->text('source_path')->nullable();
            $table->text('restore_binary_path')->nullable();
            $table->boolean('create_safety_backup')->default(true);
            $table->text('error_message')->nullable();
            $table->unsignedBigInteger('created_by')->nullable()->index();
            $table->timestamps();

            $table->index(['status', 'started_at']);
            $table->index(['backup_target_id', 'started_at']);
            $table->index('source_type');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('restore_jobs');
    }
};
