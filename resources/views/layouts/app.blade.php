<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <title>@yield('title', config('app.name', 'DB Backup'))</title>
    @vite(['resources/css/app.css', 'resources/js/app.js'])
</head>
<body class="min-h-screen bg-[#eef4f0] text-slate-900 antialiased">
    @php
        $navItems = [
            ['label' => 'Dashboard', 'route' => 'dashboard', 'href' => route('dashboard'), 'icon' => 'grid'],
            ['label' => 'Backup Targets', 'route' => 'backup-targets.*', 'href' => route('backup-targets.index'), 'icon' => 'database'],
            ['label' => 'Backup History', 'route' => 'backup-jobs.*', 'href' => route('backup-jobs.index'), 'icon' => 'backup-history'],
            ['label' => 'Restore', 'route' => 'restore.*', 'href' => route('restore.index'), 'icon' => 'restore'],
            ['label' => 'Restore History', 'route' => 'restore-history.*', 'href' => route('restore-history.index'), 'icon' => 'restore-history'],
            ['label' => 'Restore Drills', 'route' => 'restore-drills.*', 'href' => route('restore-drills.index'), 'icon' => 'drill'],
            ['label' => 'Queue Monitor', 'route' => 'queue-monitor.*', 'href' => route('queue-monitor.index'), 'icon' => 'queue'],
            ['label' => 'Reports', 'route' => 'reports.*', 'href' => route('reports.index'), 'icon' => 'reports'],
            ['label' => 'Audit Logs', 'route' => 'audit-logs.*', 'href' => route('audit-logs.index'), 'icon' => 'audit'],
            ['label' => 'Automation Guide', 'route' => 'automation-guide', 'href' => route('automation-guide'), 'icon' => 'automation'],
        ];
    @endphp

    @auth
        <div
            data-flash-success="{{ session('status') }}"
            data-flash-error="{{ session('error') }}"
            class="min-h-screen lg:grid lg:grid-cols-[280px_1fr]"
        >
            <aside class="hidden border-r border-emerald-950/10 bg-[#09251f] text-white lg:sticky lg:top-0 lg:flex lg:h-screen lg:flex-col">
                <div class="shrink-0 px-7 py-7">
                    <div class="flex items-center gap-3">
                        <div class="grid h-12 w-12 place-items-center rounded-2xl bg-emerald-400 text-xl font-black text-emerald-950 shadow-lg shadow-emerald-950/30">
                            DB
                        </div>
                        <div>
                            <p class="text-xs font-bold uppercase tracking-[0.28em] text-emerald-300">Backup Center</p>
                            <h1 class="text-lg font-black text-white">DB Backup</h1>
                        </div>
                    </div>
                </div>

                <nav class="min-h-0 flex-1 space-y-2 overflow-y-auto px-4 pb-4">
                    @foreach ($navItems as $item)
                        <a
                            href="{{ $item['href'] }}"
                            class="group flex items-center gap-3 rounded-2xl px-4 py-3 text-sm font-bold transition {{ request()->routeIs($item['route']) ? 'bg-emerald-400 text-emerald-950 shadow-lg shadow-emerald-950/30' : 'text-emerald-50/75 hover:bg-white/10 hover:text-white' }}"
                        >
                            <span class="grid h-9 w-9 place-items-center rounded-xl {{ request()->routeIs($item['route']) ? 'bg-emerald-950/10' : 'bg-white/10 group-hover:bg-white/15' }}">
                                @if ($item['icon'] === 'grid')
                                    <span class="text-lg">▦</span>
                                @elseif ($item['icon'] === 'database')
                                    <span class="text-lg">◉</span>
                                @elseif ($item['icon'] === 'backup-history')
                                    <svg class="h-[18px] w-[18px]" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M3 12a9 9 0 1 0 3-6.7"></path><path d="M3 4v6h6"></path><path d="M12 7v5l3 2"></path></svg>
                                @elseif ($item['icon'] === 'restore')
                                    <svg class="h-[18px] w-[18px]" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M21 12a9 9 0 1 1-3-6.7"></path><path d="M21 4v6h-6"></path><path d="M12 8v8"></path><path d="M8 12l4 4 4-4"></path></svg>
                                @elseif ($item['icon'] === 'restore-history')
                                    <svg class="h-[18px] w-[18px]" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M4 5v5h5"></path><path d="M4.6 10A8 8 0 1 0 7 5.5"></path><path d="M12 8v4l2.5 1.5"></path><path d="M16 19h5"></path></svg>
                                @elseif ($item['icon'] === 'drill')
                                    <svg class="h-[18px] w-[18px]" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M14 4l6 6"></path><path d="M18 8l-9.5 9.5a3 3 0 0 1-4.2 0 3 3 0 0 1 0-4.2L13.8 3.8"></path><path d="M5 19l-2 2"></path><path d="M9 15l-3-3"></path></svg>
                                @elseif ($item['icon'] === 'queue')
                                    <svg class="h-[18px] w-[18px]" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M8 6h13"></path><path d="M8 12h13"></path><path d="M8 18h13"></path><circle cx="4" cy="6" r="1"></circle><circle cx="4" cy="12" r="1"></circle><circle cx="4" cy="18" r="1"></circle></svg>
                                @elseif ($item['icon'] === 'reports')
                                    <svg class="h-[18px] w-[18px]" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M4 19V5"></path><path d="M4 19h16"></path><rect x="7" y="11" width="3" height="5" rx="1"></rect><rect x="12" y="7" width="3" height="9" rx="1"></rect><rect x="17" y="4" width="3" height="12" rx="1"></rect></svg>
                                @elseif ($item['icon'] === 'audit')
                                    <svg class="h-[18px] w-[18px]" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M12 3l7 3v5c0 4.5-3 8.2-7 10-4-1.8-7-5.5-7-10V6l7-3z"></path><path d="M9 12l2 2 4-4"></path></svg>
                                @elseif ($item['icon'] === 'automation')
                                    <svg class="h-[18px] w-[18px]" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><circle cx="12" cy="12" r="3"></circle><path d="M12 2v3"></path><path d="M12 19v3"></path><path d="M4.9 4.9l2.1 2.1"></path><path d="M17 17l2.1 2.1"></path><path d="M2 12h3"></path><path d="M19 12h3"></path><path d="M4.9 19.1 7 17"></path><path d="M17 7l2.1-2.1"></path></svg>
                                @else
                                    <span class="text-lg">↺</span>
                                @endif
                            </span>
                            {{ $item['label'] }}
                        </a>
                    @endforeach
                </nav>

                <div class="shrink-0 px-4 py-5">
                    <div class="rounded-3xl border border-white/10 bg-white/10 p-4">
                        <p class="text-sm font-bold text-white">{{ auth()->user()->name }}</p>
                        <p class="mt-1 text-xs text-emerald-100/70">Admin</p>
                        <form method="POST" action="{{ route('logout') }}" class="mt-4 js-confirm" data-confirm-title="ออกจากระบบ?" data-confirm-text="คุณต้องการออกจากระบบใช่ไหม">
                            @csrf
                            <button class="w-full rounded-2xl bg-white/10 px-4 py-2 text-sm font-bold text-white transition hover:bg-white/20">
                                ออกจากระบบ
                            </button>
                        </form>
                    </div>
                </div>
            </aside>

            <div class="min-w-0">
                <header class="sticky top-0 z-30 border-b border-slate-200/80 bg-white/85 px-4 py-3 shadow-sm backdrop-blur lg:hidden">
                    <div class="flex items-center justify-between gap-3">
                        <a href="{{ route('dashboard') }}" class="flex items-center gap-3">
                            <div class="grid h-10 w-10 place-items-center rounded-2xl bg-emerald-500 text-sm font-black text-white">DB</div>
                            <div>
                                <p class="text-xs font-bold uppercase tracking-[0.22em] text-emerald-700">Backup</p>
                                <p class="font-black">DB Backup</p>
                            </div>
                        </a>
                        <nav class="flex gap-2 overflow-x-auto">
                            @foreach ($navItems as $item)
                                <a href="{{ $item['href'] }}" class="whitespace-nowrap rounded-full px-3 py-2 text-xs font-bold {{ request()->routeIs($item['route']) ? 'bg-emerald-500 text-white' : 'bg-slate-100 text-slate-700' }}">
                                    {{ $item['label'] }}
                                </a>
                            @endforeach
                        </nav>
                    </div>
                </header>

                <main class="min-h-screen bg-[radial-gradient(circle_at_top_left,_rgba(16,185,129,0.16),_transparent_28%),linear-gradient(180deg,_#f8fbf9_0%,_#edf4f1_100%)]">
                    @yield('body')
                </main>
            </div>
        </div>
    @else
        <div data-flash-success="{{ session('status') }}" data-flash-error="{{ session('error') }}" class="min-h-screen">
            @yield('body')
        </div>
    @endauth
</body>
</html>
