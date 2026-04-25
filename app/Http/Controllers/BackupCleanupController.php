<?php

namespace App\Http\Controllers;

use App\Services\BackupRetentionService;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Collection;

class BackupCleanupController extends Controller
{
    public function preview(BackupRetentionService $retentionService): RedirectResponse
    {
        $result = $retentionService->cleanup(dryRun: true);

        return redirect()
            ->route('dashboard')
            ->with('cleanup_result', $this->sessionResult($result, true))
            ->with('status', "ตรวจพบ backup หมดอายุ {$result['checked']} รายการ ยังไม่ได้ลบไฟล์");
    }

    public function destroy(Request $request, BackupRetentionService $retentionService): RedirectResponse
    {
        $request->validate([
            'confirm_cleanup' => ['required', 'accepted'],
        ]);

        $result = $retentionService->cleanup();

        return redirect()
            ->route('dashboard')
            ->with('cleanup_result', $this->sessionResult($result, false))
            ->with('status', "ลบไฟล์ local {$result['deleted_files']} ไฟล์, offsite {$result['deleted_offsite_files']} ไฟล์ และ record {$result['deleted_records']} รายการแล้ว");
    }

    /**
     * @param  array{checked:int, deleted_files:int, deleted_offsite_files:int, deleted_records:int, freed_bytes:int, items:Collection<int, array<string, mixed>>}  $result
     * @return array<string, mixed>
     */
    private function sessionResult(array $result, bool $dryRun): array
    {
        return [
            'dry_run' => $dryRun,
            'checked' => $result['checked'],
            'deleted_files' => $result['deleted_files'],
            'deleted_offsite_files' => $result['deleted_offsite_files'],
            'deleted_records' => $result['deleted_records'],
            'freed_bytes' => $result['freed_bytes'],
            'items' => $result['items']
                ->take(20)
                ->map(fn (array $item): array => [
                    'target' => $item['target'],
                    'job_id' => $item['job_id'],
                    'finished_at' => $item['finished_at'],
                    'file_exists' => $item['file_exists'],
                    'offsite_file_exists' => $item['offsite_file_exists'],
                    'file_size' => $item['file_size'],
                    'offsite_file_size' => $item['offsite_file_size'],
                ])
                ->values()
                ->all(),
        ];
    }
}
