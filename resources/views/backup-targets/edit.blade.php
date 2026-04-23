@extends('layouts.app')

@section('title', 'แก้ไข Backup Target | DB Backup')

@section('body')
    <div class="w-full px-4 py-6 sm:px-6 lg:px-10 lg:py-8">
        <header class="mb-6 rounded-[2rem] bg-white p-6 shadow-sm shadow-slate-200/80">
            <p class="text-xs font-black uppercase tracking-[0.28em] text-emerald-600">Backup Target</p>
            <div class="mt-3 flex flex-col gap-4 lg:flex-row lg:items-end lg:justify-between">
                <div>
                    <h1 class="text-3xl font-black tracking-tight text-slate-950">แก้ไข {{ $target->name }}</h1>
                    <p class="mt-2 text-sm text-slate-500">ปรับข้อมูล connection, path และรอบการ backup</p>
                </div>
                <a href="{{ route('backup-targets.index') }}" class="rounded-2xl border border-slate-200 bg-white px-5 py-3 text-center text-sm font-black text-slate-700 transition hover:bg-slate-50">
                    กลับรายการ
                </a>
            </div>
        </header>

        <form method="POST" action="{{ route('backup-targets.update', $target) }}">
            @method('PUT')
            @include('backup-targets._form')
        </form>
    </div>
@endsection
