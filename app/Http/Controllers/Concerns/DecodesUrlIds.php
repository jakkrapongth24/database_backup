<?php

namespace App\Http\Controllers\Concerns;

use App\Support\UrlId;
use Illuminate\Http\Request;

trait DecodesUrlIds
{
    /**
     * @param  array<int, string>  $keys
     */
    protected function decodeUrlIds(Request $request, array $keys): void
    {
        foreach ($keys as $key) {
            if (! $request->filled($key)) {
                continue;
            }

            $decoded = UrlId::decode($request->input($key));

            $request->merge([
                $key => $decoded ?? '__invalid_url_id__',
            ]);
        }
    }

    /**
     * @param  array<int, string>  $keys
     */
    protected function encodeUrlIds(Request $request, array $keys): void
    {
        foreach ($keys as $key) {
            if (! $request->filled($key)) {
                continue;
            }

            $decoded = UrlId::decode($request->input($key));

            if ($decoded !== null) {
                $request->merge([
                    $key => UrlId::encode($decoded),
                ]);
            }
        }
    }
}
