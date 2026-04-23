@extends('layouts.app')

@section('title', 'Login | DB Backup')

@section('body')
    <main class="grid min-h-screen lg:grid-cols-[1.15fr_0.85fr]">
        <section class="relative hidden overflow-hidden bg-[#09251f] p-10 text-white lg:flex lg:flex-col lg:justify-between">
            <div class="absolute inset-0 bg-[radial-gradient(circle_at_20%_20%,_rgba(52,211,153,0.32),_transparent_34%),radial-gradient(circle_at_80%_70%,_rgba(16,185,129,0.22),_transparent_32%)]"></div>
            <div class="relative">
                <div class="flex items-center gap-3">
                    <div class="grid h-14 w-14 place-items-center rounded-2xl bg-emerald-400 text-xl font-black text-emerald-950">DB</div>
                    <div>
                        <p class="text-xs font-black uppercase tracking-[0.32em] text-emerald-300">Backup Center</p>
                        <p class="text-xl font-black">DB Backup Management</p>
                    </div>
                </div>
                <div class="mt-20 max-w-2xl">
                    <p class="text-sm font-black uppercase tracking-[0.36em] text-emerald-300">Secure Backup</p>
                    <h1 class="mt-5 text-5xl font-black leading-tight">จัดการ Backup หลายระบบในที่เดียว</h1>
                    <p class="mt-6 text-lg leading-8 text-emerald-50/75">ติดตามสถานะ กด backup ทันที ดูประวัติ และเตรียมต่อยอด schedule/report ได้ในระบบเดียว</p>
                </div>
            </div>
            <div class="relative grid grid-cols-3 gap-4">
                <div class="rounded-3xl bg-white/10 p-5">
                    <p class="text-2xl font-black">01</p>
                    <p class="mt-2 text-sm text-emerald-50/70">Targets</p>
                </div>
                <div class="rounded-3xl bg-white/10 p-5">
                    <p class="text-2xl font-black">02</p>
                    <p class="mt-2 text-sm text-emerald-50/70">Backup Now</p>
                </div>
                <div class="rounded-3xl bg-white/10 p-5">
                    <p class="text-2xl font-black">03</p>
                    <p class="mt-2 text-sm text-emerald-50/70">History</p>
                </div>
            </div>
        </section>

        <section class="flex items-center justify-center bg-[#f3f8f5] px-6 py-12">
            <div class="w-full max-w-md">
                <div class="mb-8 lg:hidden">
                    <div class="grid h-12 w-12 place-items-center rounded-2xl bg-emerald-500 text-lg font-black text-white">DB</div>
                    <p class="mt-4 text-xs font-black uppercase tracking-[0.28em] text-emerald-700">Backup Center</p>
                </div>

                <div class="rounded-[2rem] border border-white bg-white p-8 shadow-2xl shadow-slate-200/80">
                    <div class="mb-8">
                        <h1 class="text-3xl font-black tracking-tight text-slate-950">เข้าสู่ระบบผู้ดูแล</h1>
                        <p class="mt-3 text-sm leading-6 text-slate-500">
                            ใช้บัญชีจากตาราง <span class="font-black text-emerald-700">personel</span> ของระบบเดิม
                        </p>
                    </div>

                    <form method="POST" action="{{ route('login.store') }}" class="space-y-5">
                        @csrf

                        <div>
                            <label for="username" class="block text-sm font-black text-slate-700">Username</label>
                            <input id="username" name="username" value="{{ old('username') }}" required autofocus class="mt-2 w-full rounded-2xl border border-slate-200 bg-white px-4 py-3 text-slate-950 outline-none ring-emerald-400/20 transition focus:border-emerald-400 focus:ring-4">
                            @error('username')
                                <p class="mt-2 text-sm font-bold text-rose-600">{{ $message }}</p>
                            @enderror
                        </div>

                        <div>
                            <label for="password" class="block text-sm font-black text-slate-700">Password</label>
                            <input id="password" name="password" type="password" required class="mt-2 w-full rounded-2xl border border-slate-200 bg-white px-4 py-3 text-slate-950 outline-none ring-emerald-400/20 transition focus:border-emerald-400 focus:ring-4">
                        </div>

                        <label class="flex items-center gap-3 text-sm font-bold text-slate-600">
                            <input name="remember" type="checkbox" class="h-5 w-5 rounded border-slate-300 text-emerald-500">
                            จดจำการเข้าสู่ระบบ
                        </label>

                        <button class="w-full rounded-2xl bg-emerald-500 px-5 py-4 font-black text-white shadow-lg shadow-emerald-200 transition hover:-translate-y-0.5 hover:bg-emerald-600">
                            เข้าสู่ Dashboard
                        </button>
                    </form>
                </div>
            </div>
        </section>
    </main>
@endsection
