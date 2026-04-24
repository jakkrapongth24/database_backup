<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('restore_drills', function (Blueprint $table) {
            $table->id();
            $table->foreignId('backup_target_id')->constrained()->cascadeOnDelete();
            $table->foreignId('backup_job_id')->nullable()->constrained()->nullOnDelete();
            $table->string('status', 20)->default('running')->index();
            $table->timestamp('started_at')->nullable();
            $table->timestamp('finished_at')->nullable();
            $table->unsignedInteger('duration_seconds')->nullable();
            $table->string('source_name')->nullable();
            $table->string('source_path')->nullable();
            $table->json('checks')->nullable();
            $table->text('error_message')->nullable();
            $table->unsignedBigInteger('created_by')->nullable()->index();
            $table->timestamps();

            $table->index(['backup_target_id', 'started_at']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('restore_drills');
    }
};
