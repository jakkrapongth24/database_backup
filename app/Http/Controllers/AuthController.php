<?php

namespace App\Http\Controllers;

use App\Services\AuditLogger;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\View\View;

class AuthController extends Controller
{
    public function showLogin(): View
    {
        return view('auth.login');
    }

    public function login(Request $request, AuditLogger $audit): RedirectResponse
    {
        $credentials = $request->validate([
            'username' => ['required', 'string'],
            'password' => ['required', 'string'],
        ]);

        $remember = $request->boolean('remember');

        if (Auth::attempt([...$credentials, 'status' => 'active'], $remember)) {
            $request->session()->regenerate();
            $audit->log('auth.login', 'User logged in.', metadata: [
                'username' => $credentials['username'],
            ]);

            return redirect()->intended(route('dashboard'));
        }

        $audit->log('auth.login_failed', 'Login failed.', metadata: [
            'username' => $credentials['username'],
        ]);

        return back()
            ->withErrors(['username' => 'ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง หรือบัญชีไม่ได้เปิดใช้งาน'])
            ->onlyInput('username');
    }

    public function logout(Request $request, AuditLogger $audit): RedirectResponse
    {
        $audit->log('auth.logout', 'User logged out.');

        Auth::logout();

        $request->session()->invalidate();
        $request->session()->regenerateToken();

        return redirect()->route('login');
    }
}
