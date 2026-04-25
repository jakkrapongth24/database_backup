<?php

namespace App\Support;

use Illuminate\Support\Facades\Crypt;
use Throwable;

class UrlId
{
    public static function encode(int|string|null $id): string
    {
        if ($id === null || $id === '') {
            return '';
        }

        $encrypted = Crypt::encryptString((string) $id);

        return rtrim(strtr(base64_encode($encrypted), '+/', '-_'), '=');
    }

    public static function decode(mixed $value): ?int
    {
        if ($value === null || $value === '') {
            return null;
        }

        if (is_int($value) || (is_string($value) && ctype_digit($value))) {
            return (int) $value;
        }

        if (! is_string($value)) {
            return null;
        }

        try {
            $normalized = strtr($value, '-_', '+/');
            $padding = strlen($normalized) % 4;

            if ($padding > 0) {
                $normalized .= str_repeat('=', 4 - $padding);
            }

            $encrypted = base64_decode($normalized, true);

            if ($encrypted === false) {
                return null;
            }

            $decrypted = Crypt::decryptString($encrypted);

            return ctype_digit($decrypted) ? (int) $decrypted : null;
        } catch (Throwable) {
            return null;
        }
    }
}
