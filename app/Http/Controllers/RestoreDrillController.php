<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Concerns\DecodesUrlIds;
use App\Models\BackupTarget;
use App\Models\RestoreDrill;
use App\Services\RestoreDrillService;
use Carbon\Carbon;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\Auth;
use Illuminate\View\View;
use Symfony\Component\HttpFoundation\StreamedResponse;

class RestoreDrillController extends Controller
{
    use DecodesUrlIds;

    public function index(Request $request): View
    {
        $filters = $this->filters($request);
        $query = $this->filteredQuery($filters);
        $summaryQuery = clone $query;

        $drills = $query
            ->latest('started_at')
            ->paginate(15)
            ->withQueryString();

        $targets = BackupTarget::query()
            ->orderBy('name')
            ->get(['id', 'name']);

        $summary = $this->summary($summaryQuery);

        return view('restore-drills.index', compact('drills', 'targets', 'filters', 'summary'));
    }

    public function run(Request $request, RestoreDrillService $restoreDrillService): RedirectResponse
    {
        $this->decodeUrlIds($request, ['backup_target_id']);

        $payload = $request->validate([
            'backup_target_id' => ['nullable', 'integer', 'exists:backup_targets,id'],
            'actual_restore' => ['nullable', 'boolean'],
            'test_database' => ['nullable', 'string', 'max:191', 'regex:/^[A-Za-z0-9_{}]+$/'],
            'keep_database' => ['nullable', 'boolean'],
        ]);

        $options = [
            'actual_restore' => $request->boolean('actual_restore'),
            'test_database' => trim((string) ($payload['test_database'] ?? '')) ?: null,
            'keep_database' => $request->boolean('keep_database'),
        ];

        $targets = BackupTarget::query()
            ->where('is_active', true)
            ->when($payload['backup_target_id'] ?? null, fn (Builder $query, int $targetId) => $query->whereKey($targetId))
            ->orderBy('name')
            ->get();

        if ($targets->isEmpty()) {
            return back()->with('error', 'ไม่พบ target ที่เปิดใช้งานสำหรับตรวจ Restore Drill');
        }

        $passed = 0;
        $failed = 0;

        foreach ($targets as $target) {
            $drill = $restoreDrillService->runForTarget($target, userId: Auth::id(), options: $options);

            if ($drill->status === 'success') {
                $passed++;
            } else {
                $failed++;
            }
        }

        $message = "ตรวจ Restore Drill แล้ว {$targets->count()} target: ผ่าน {$passed}, ไม่ผ่าน {$failed}";

        return redirect()
            ->route('restore-drills.index')
            ->with($failed > 0 ? 'error' : 'status', $message);
    }

    public function exportCsv(Request $request): StreamedResponse
    {
        $report = $this->exportReport($request);
        $fileName = 'restore-drill-report_'.$report['dateFrom']->format('Ymd').'_to_'.$report['dateTo']->format('Ymd').'.csv';

        return response()->streamDownload(function () use ($report): void {
            $handle = fopen('php://output', 'wb');

            if ($handle === false) {
                return;
            }

            fwrite($handle, chr(0xEF).chr(0xBB).chr(0xBF));
            fputcsv($handle, ['Restore Drill Report']);
            fputcsv($handle, ['Date From', $report['dateFrom']->toDateString()]);
            fputcsv($handle, ['Date To', $report['dateTo']->toDateString()]);
            fputcsv($handle, ['Exported At', $report['exportedAt']->format('Y-m-d H:i:s')]);
            fputcsv($handle, []);
            fputcsv($handle, ['Summary']);
            fputcsv($handle, ['Total', $report['summary']['total']]);
            fputcsv($handle, ['Success', $report['summary']['success']]);
            fputcsv($handle, ['Failed', $report['summary']['failed']]);
            fputcsv($handle, ['Running', $report['summary']['running']]);
            fputcsv($handle, []);
            fputcsv($handle, ['Target', 'Status', 'Backup Job', 'Source', 'Started At', 'Duration', 'Error', 'Checks']);

            foreach ($report['drills'] as $drill) {
                fputcsv($handle, [
                    $drill->target?->name ?? 'Deleted target',
                    strtoupper($drill->status),
                    $drill->backup_job_id ? '#'.$drill->backup_job_id : '-',
                    $drill->source_name ?: '-',
                    $drill->started_at?->format('Y-m-d H:i:s') ?? '-',
                    $drill->duration_seconds !== null ? $drill->duration_seconds.' sec' : '-',
                    $drill->error_message ?: '-',
                    $this->checkSummary($drill->checks ?? []),
                ]);
            }

            fclose($handle);
        }, $fileName, ['Content-Type' => 'text/csv; charset=UTF-8']);
    }

    public function exportExcel(Request $request): StreamedResponse
    {
        $report = $this->exportReport($request);
        $fileName = 'restore-drill-report_'.$report['dateFrom']->format('Ymd').'_to_'.$report['dateTo']->format('Ymd').'.xls';

        return response()->streamDownload(function () use ($report): void {
            echo view('restore-drills.export-excel', ['report' => $report])->render();
        }, $fileName, ['Content-Type' => 'application/vnd.ms-excel; charset=UTF-8']);
    }

    public function exportPdf(Request $request): View
    {
        return view('restore-drills.export-pdf', [
            'report' => $this->exportReport($request),
        ]);
    }

    /**
     * @return array{status?:string,target_id?:string,date_from?:string,date_to?:string}
     */
    private function filters(Request $request): array
    {
        $this->decodeUrlIds($request, ['target_id']);

        $filters = $request->validate([
            'status' => ['nullable', 'in:running,success,failed'],
            'target_id' => ['nullable', 'integer', 'exists:backup_targets,id'],
            'date_from' => ['nullable', 'date'],
            'date_to' => ['nullable', 'date'],
        ]);

        $this->encodeUrlIds($request, ['target_id']);

        return $filters;
    }

    /**
     * @param  array<string, mixed>  $filters
     */
    private function filteredQuery(array $filters): Builder
    {
        return RestoreDrill::query()
            ->with(['target', 'backupJob'])
            ->when($filters['status'] ?? null, fn (Builder $query, string $status) => $query->where('status', $status))
            ->when($filters['target_id'] ?? null, fn (Builder $query, string $targetId) => $query->where('backup_target_id', $targetId))
            ->when($filters['date_from'] ?? null, fn (Builder $query, string $date) => $query->whereDate('started_at', '>=', $date))
            ->when($filters['date_to'] ?? null, fn (Builder $query, string $date) => $query->whereDate('started_at', '<=', $date));
    }

    /**
     * @return array<string, int>
     */
    private function summary(Builder $query): array
    {
        return [
            'total' => (clone $query)->count(),
            'success' => (clone $query)->where('status', 'success')->count(),
            'failed' => (clone $query)->where('status', 'failed')->count(),
            'running' => (clone $query)->where('status', 'running')->count(),
        ];
    }

    /**
     * @return array{filters:array<string, mixed>, dateFrom:Carbon, dateTo:Carbon, exportedAt:Carbon, summary:array<string, int>, drills:Collection<int, RestoreDrill>}
     */
    private function exportReport(Request $request): array
    {
        $filters = $this->filters($request);
        $query = $this->filteredQuery($filters);

        return [
            'filters' => $filters,
            'dateFrom' => ($filters['date_from'] ?? null) ? Carbon::parse($filters['date_from']) : now()->subDays(29),
            'dateTo' => ($filters['date_to'] ?? null) ? Carbon::parse($filters['date_to']) : now(),
            'exportedAt' => now(),
            'summary' => $this->summary(clone $query),
            'drills' => $query->latest('started_at')->get(),
        ];
    }

    /**
     * @param  array<int, array<string, string>>  $checks
     */
    private function checkSummary(array $checks): string
    {
        if ($checks === []) {
            return '-';
        }

        return collect($checks)
            ->map(fn (array $check): string => ($check['label'] ?? '-').': '.strtoupper($check['status'] ?? '-').' - '.($check['message'] ?? '-'))
            ->implode(' | ');
    }
}
