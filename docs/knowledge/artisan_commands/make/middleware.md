Laravelのmake:middleware
=========================

概要
-------------------------

`make:middleware`はHTTPミドルウェアクラスを生成します。
ミドルウェアは、リクエストがコントローラへ届く前、またはレスポンスが返る後に処理を挟む仕組みです。

ミドルウェアの役割
-------------------------

ミドルウェアは次のような処理に向いています。

- `Accept-Language`を見て表示言語を切り替える
- 認証や権限を確認する
- セキュリティヘッダーを付ける
- リクエストのログを取る
- メンテナンス中は処理を中断する

処理の流れ
-------------------------

リクエストは次の順序で処理されます。

1. グローバルミドルウェア
2. グループまたはルートのミドルウェア
3. コントローラ
4. ミドルウェアの後処理
5. レスポンス

`handle()`の`$next($request)`を呼ぶと、次の処理へ進みます。
`$next($request)`を呼ばずにレスポンスを返すと、処理を中断できます。

生成物と生成先
-------------------------

| 生成物       | 生成先                           |
| ------------ | -------------------------------- |
| ミドルウェア | `app/Http/Middleware/<Name>.php` |

オプション
-------------------------

| オプション  | 短縮 | 用途                           |
| ----------- | ---- | ------------------------------ |
| `--test`    | なし | 既定の形式のテストを生成します |
| `--pest`    | なし | Pestテストを生成します         |
| `--phpunit` | なし | PHPUnitテストを生成します      |

`make:middleware`には`--force`がありません。
同名ファイルがある場合はエラーになります。

生成内容
-------------------------

`php artisan make:middleware SetLocaleFromAcceptLanguage`は次の形を生成します。

```php
namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class SetLocaleFromAcceptLanguage
{
    public function handle(Request $request, Closure $next): Response
    {
        return $next($request);
    }
}
```

`handle()`にリクエスト前後の処理を書きます。

Accept-Languageで言語を切り替える
---------------------------------

ブラウザは`Accept-Language`ヘッダーで優先言語を送ります。
ミドルウェアでその値を見て、アプリケーションのロケールを切り替えます。

```php
namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\App;
use Symfony\Component\HttpFoundation\Response;

class SetLocaleFromAcceptLanguage
{
    public function handle(Request $request, Closure $next): Response
    {
        $locale = $request->getPreferredLanguage(['ja', 'en'])
            ?? config('app.locale');

        App::setLocale($locale);

        return $next($request);
    }
}
```

`getPreferredLanguage(['ja', 'en'])`は`Accept-Language`を解析し、対応している言語を返します。
一致する言語がない場合は`ja`を返します。
`App::setLocale()`は`lang/ja`や`lang/en`の言語ファイルを切り替えます。

例えば`Accept-Language: en-US,en;q=0.9,ja;q=0.8`なら`en`が選ばれます。

ミドルウェアの登録
-------------------------

`bootstrap/app.php`の`withMiddleware()`で登録します。

```php
->withMiddleware(function (Middleware $middleware): void {
    $middleware->web(append: [
        \App\Http\Middleware\SetLocaleFromAcceptLanguage::class,
    ]);
})
```

`web`グループに追加すると、Web画面のすべてのリクエストで実行されます。
APIでも言語を切り替える場合は`$middleware->api(append: [...])`を使います。

特定のルートだけに適用する場合は、エイリアスを登録します。

```php
->withMiddleware(function (Middleware $middleware): void {
    $middleware->alias([
        'set.locale' => \App\Http\Middleware\SetLocaleFromAcceptLanguage::class,
    ]);
})
```

```php
Route::get('/posts', PostController::class)->middleware('set.locale');
```

手動の言語切り替え
-------------------------

ブラウザの設定ではなく、画面の言語切替ボタンで言語を変える場合は、セッションに保存します。

```php
$locale = $request->session()->get('locale')
    ?? $request->getPreferredLanguage(['ja', 'en'])
    ?? config('app.locale');

App::setLocale($locale);
```

言語切替ボタンでは`session(['locale' => $locale])`を保存します。

セキュリティヘッダーの例
-------------------------

`$next($request)`の戻り値はレスポンスです。
レスポンスにヘッダーを追加できます。

```php
public function handle(Request $request, Closure $next): Response
{
    $response = $next($request);

    $response->headers->set('X-Frame-Options', 'DENY');
    $response->headers->set('X-Content-Type-Options', 'nosniff');

    return $response;
}
```

注意点
-------------------------

- ミドルウェアは対象範囲のすべてのリクエストで実行されます
- 重いDB処理や外部API呼び出しは避けます
- グローバルミドルウェアはヘルスチェックなどにも適用されます
- 登録順序によって処理順が変わります
- レスポンス後に処理する場合は`terminate()`を使います
- CSRF検証は`web`グループに既定で含まれています

関連ドキュメント
-------------------------

- [makeコマンド索引](index.md)
- [make:controller](controller.md)
- [make:request](request.md)
