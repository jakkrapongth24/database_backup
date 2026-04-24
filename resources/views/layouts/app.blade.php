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
            ['label' => 'Backup History', 'route' => 'backup-jobs.*', 'href' => route('backup-jobs.index'), 'icon' => 'history'],
            ['label' => 'Queue Monitor', 'route' => 'queue-monitor.*', 'href' => route('queue-monitor.index'), 'icon' => 'history'],
            ['label' => 'Reports', 'route' => 'reports.*', 'href' => route('reports.index'), 'icon' => 'report'],
            ['label' => 'Audit Logs', 'route' => 'audit-logs.*', 'href' => route('audit-logs.index'), 'icon' => 'audit'],
            ['label' => 'Automation Guide', 'route' => 'automation-guide', 'href' => route('automation-guide'), 'icon' => 'clock'],
        ];
    @endphp

    @auth
        <div
            data-flash-success="{{ session('status') }}"
            data-flash-error="{{ session('error') }}"
            class="min-h-screen lg:grid lg:grid-cols-[280px_1fr]"
        >
            <aside class="hidden border-r border-emerald-950/10 bg-[#09251f] text-white lg:flex lg:min-h-screen lg:flex-col">
                <div class="px-7 py-7">
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

                <nav class="flex-1 space-y-2 px-4">
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
                                @else
                                    <span class="text-lg">↺</span>
                                @endif
                            </span>
                            {{ $item['label'] }}
                        </a>
                    @endforeach
                </nav>

                <div class="px-4 py-5">
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
