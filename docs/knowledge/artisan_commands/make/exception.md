Laravelのmake:exception
=========================

概要
-------------------------

`make:exception`はアプリケーション固有の例外クラスを生成します。
例外は、正常な処理を続けられない状態を表す仕組みです。
独自例外を使うと、エラーの種類、HTTPレスポンス、ログを1つのクラスにまとめられます。

このページで分かること
-------------------------

- 独自例外をいつ作るか
- `--render`と`--report`の違い
- Laravelが例外をどう処理するか
- 実際の例外クラス、投げ方、捕まえ方
- テストの書き方

例外とは
-------------------------

例外は「このまま処理を続けると困る」ことを、呼び出し元へ伝える仕組みです。
呼び出し元は例外を捕まえて、エラーメッセージを出したり、別の処理へ切り替えたりできます。

独自例外が向いている例は次のとおりです。

- 残高不足
- 注文の状態が不正
- 外部APIの契約違反
- 業務ルール違反

一方、次の場合はLaravelの標準機能で足ります。

- 入力チェック: FormRequest
- 権限チェック: ポリシー
- 404: `abort(404)`や`ModelNotFoundException`
- 認証: 認証ミドルウェア

独自例外は「業務上の意味を持つエラー」に限定すると、使いどころが明確になります。

生成物と生成先
-------------------------

| 生成物     | 生成先                      |
| ---------- | --------------------------- |
| 例外クラス | `app/Exceptions/<Name>.php` |

オプション
-------------------------

| オプション          | 短縮 | 生成内容                             |
| ------------------- | ---- | ------------------------------------ |
| `--render`          | なし | `render(Request $request): Response` |
| `--report`          | なし | `report(): void`                     |
| `--render --report` | なし | 両方のメソッド                       |
| `--force`           | `-f` | 同名ファイルを上書きします           |

生成内容
-------------------------

### 最小構成

`php artisan make:exception InsufficientBalanceException`は次の形を生成します。

```php
namespace App\Exceptions;

use Exception;

class InsufficientBalanceException extends Exception
{
    //
}
```

### report付き

`--report`を付けると、ログや通知のための`report()`が生成されます。

```php
class InsufficientBalanceException extends Exception
{
    public function report(): void
    {
        //
    }
}
```

### render付き

`--render`を付けると、HTTPレスポンスを返す`render()`が生成されます。

```php
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class InsufficientBalanceException extends Exception
{
    public function render(Request $request): Response
    {
        //
    }
}
```

Laravelが例外を処理する流れ
---------------------------

1. アプリケーションが例外を投げる
2. Laravelの例外ハンドラが`report()`を呼ぶ
3. ハンドラが`render()`を呼ぶ
4. `render()`が返したレスポンスをクライアントへ返す

`render()`がレスポンスを返すと、そのレスポンスが使われます。
例外クラスの`render()`は、`bootstrap/app.php`のグローバルな`render`コールバックより優先されます。

`report()`を実装すると、その例外の既定ログ処理は置き換わります。
既定のログも続けたい場合は、`report()`から`false`を返します。

```php
public function report(): bool
{
    Log::warning('残高不足', [
        'required' => $this->required,
        'available' => $this->available,
    ]);

    return false;
}
```

サンプル: 残高不足
-------------------------

### 例外クラス

```php
namespace App\Exceptions;

use Exception;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Log;

class InsufficientBalanceException extends Exception
{
    public function __construct(
        public readonly int $required,
        public readonly int $available,
    ) {
        parent::__construct('残高が不足しています。');
    }

    public function report(): void
    {
        Log::warning('残高不足', [
            'required' => $this->required,
            'available' => $this->available,
        ]);
    }

    public function render(Request $request): Response
    {
        if ($request->expectsJson()) {
            return response()->json([
                'message' => $this->getMessage(),
                'required' => $this->required,
                'available' => $this->available,
            ], 422);
        }

        return response()->view('errors.insufficient-balance', [
            'required' => $this->required,
            'available' => $this->available,
        ], 422);
    }
}
```

### 例外を投げる

```php
if ($balance < $amount) {
    throw new InsufficientBalanceException($amount, $balance);
}
```

### 例外を捕まえる

```php
try {
    $service->withdraw($amount);
} catch (InsufficientBalanceException $e) {
    return back()->withErrors([
        'amount' => $e->getMessage(),
    ]);
}
```

グローバルハンドラで描画する
----------------------------

例外クラスに`render()`を書かず、`bootstrap/app.php`でまとめて描画できます。

```php
->withExceptions(function (Exceptions $exceptions): void {
    $exceptions->render(function (InsufficientBalanceException $e, Request $request) {
        return response()->json([
            'message' => $e->getMessage(),
            'required' => $e->required,
            'available' => $e->available,
        ], 422);
    });
})
```

`Exceptions`は`Illuminate\Foundation\Configuration\Exceptions`、`Request`は`Illuminate\Http\Request`です。

使い分けは次のとおりです。

- 例外ごとにレスポンスが決まる: `render()`
- アプリ全体で同じ形式にしたい: `withExceptions()`
- 例外ごとにログを変えたい: `report()`

レポート対象から外す
-------------------------

想定内の例外は、ログに出さないようにできます。

```php
->withExceptions(function (Exceptions $exceptions): void {
    $exceptions->dontReport([
        InsufficientBalanceException::class,
    ]);
})
```

テスト
-------------------------

### HTTPレスポンスを確認する

```php
$this->post('/withdraw', ['amount' => 1000])
    ->assertStatus(422)
    ->assertJson([
        'message' => '残高が不足しています。',
    ]);
```

### 例外そのものを確認する

```php
$this->expectException(InsufficientBalanceException::class);

$service->withdraw(1000);
```

`withoutExceptionHandling()`を使うと、Laravelの例外ハンドラを通さずに例外を確認できます。

注意点
-------------------------

- 想定内の入力エラーはFormRequestで扱います
- 権限エラーはポリシーで扱います
- 例外メッセージに機密情報を入れません
- `render()`で内部情報を出しすぎません
- `report()`の戻り値で既定ログの扱いが変わります
- 例外を通常の分岐代わりに使いすぎません
- 独自例外を増やしすぎず、共通の基底例外を検討します

関連ドキュメント
-------------------------

- [makeコマンド索引](index.md)
- [make:request](request.md)
- [make:policy](policy.md)
- [make:class](class.md)
