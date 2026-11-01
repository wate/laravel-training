Laravelのmake:provider
=========================

概要
-------------------------

`make:provider`はサービスプロバイダクラスを生成します。
サービスプロバイダは、Laravelの起動時にアプリケーションの部品を配線する場所です。
処理そのものを書くクラスではなく、サービスコンテナへの登録や起動後の設定を担当します。

サービスプロバイダとは
-------------------------

サービスプロバイダは「起動時の配線盤」と考えると分かりやすいです。
アプリケーションが起動すると、Laravelは登録されたプロバイダの`register()`を順に呼び、その後ですべての`boot()`を呼びます。

| メソッド     | 役割                     | 向いている処理                                                 |
| ------------ | ------------------------ | -------------------------------------------------------------- |
| `register()` | サービスコンテナへの登録 | インターフェースと実装の紐付け、設定値を使ったインスタンス生成 |
| `boot()`     | 全プロバイダ登録後の設定 | イベント、ルート、Blade、バリデーション、レート制限            |

`register()`は他のプロバイダの登録が終わる前に呼ばれます。
そのため、DBや認証など他のサービスに依存する処理は書きません。
`boot()`は全プロバイダの`register()`が終わった後に呼ばれます。

生成物と生成先
-------------------------

| 生成物             | 生成先                     |
| ------------------ | -------------------------- |
| サービスプロバイダ | `app/Providers/<Name>.php` |

オプション
-------------------------

| オプション | 短縮 | 用途                       |
| ---------- | ---- | -------------------------- |
| `--force`  | `-f` | 同名ファイルを上書きします |

Laravel 11以降では、生成したプロバイダが`bootstrap/providers.php`へ自動で追加されます。

生成内容
-------------------------

`php artisan make:provider PaymentServiceProvider`は次の形を生成します。

```php
namespace App\Providers;

use Illuminate\Support\ServiceProvider;

class PaymentServiceProvider extends ServiceProvider
{
    public function register(): void
    {
        //
    }

    public function boot(): void
    {
        //
    }
}
```

`register()`と`boot()`の両方が空の状態です。

registerの例: インターフェースと実装を紐付ける
----------------------------------------------

```php
interface PaymentGateway
{
    public function charge(int $amount): void;
}
```

```php
class PaymentServiceProvider extends ServiceProvider
{
    public function register(): void
    {
        $this->app->bind(
            PaymentGateway::class,
            StripeGateway::class,
        );
    }
}
```

コントローラでインターフェースをタイプヒントすると、`StripeGateway`が自動で注入されます。

```php
public function store(Request $request, PaymentGateway $gateway)
{
    $gateway->charge(1000);
}
```

設定値を使う場合は`singleton()`でインスタンスを1つにできます。

```php
$this->app->singleton(PaymentGateway::class, function () {
    return new StripeGateway(config('services.stripe.secret'));
});
```

`bind()`は呼ばれるたびに新しいインスタンスを作ります。
`singleton()`は最初の1回だけ作り、同じインスタンスを共有します。

bootの例: 起動後の設定
-------------------------

```php
public function boot(): void
{
    RateLimiter::for('api', function (Request $request) {
        return Limit::perMinute(60)
            ->by($request->user()?->id ?: $request->ip());
    });
}
```

`boot()`は通常のPHP実行ではリクエストごとに実行されます。
重いDB処理や外部API呼び出しは書かず、設定や登録だけにします。

登録方法
-------------------------

このプロジェクトでは`bootstrap/providers.php`にプロバイダを登録します。

```php
return [
    AppServiceProvider::class,
    App\Providers\PaymentServiceProvider::class,
];
```

`make:provider`で生成した場合は自動追加されます。
手動で追加する場合も、この配列にクラスを追加します。

`AppServiceProvider`との使い分け
--------------------------------

このプロジェクトの`AppServiceProvider`は、`register()`と`boot()`が空の状態で用意されています。
小さなアプリ全体の紐付けは`AppServiceProvider`に置くと管理しやすいです。

一方、決済、レポート、外部APIなどまとまった領域は専用プロバイダに分けます。

- 小さな紐付け: `AppServiceProvider`
- 決済や外部連携: `PaymentServiceProvider`
- レポートや集計: `ReportingServiceProvider`

サービスプロバイダは何でも書く場所ではありません。
業務ロジックはサービスやアクションクラスへ置き、プロバイダは配線と設定に限定します。

よくある注意点
-------------------------

- `register()`でDBや認証を使いません
- `register()`でイベントやルートを登録しません
- `boot()`に重い処理を書きません
- `env()`は設定ファイル以外で使わず、`config()`を使います
- プロバイダを増やしすぎず、責務ごとにまとめます
- 設定キャッシュを使う場合、実行時に変わる値へ依存しません

使いどころ
-------------------------

- インターフェースと実装の紐付け
- 外部サービスのクライアント生成
- レート制限やモデルの厳格モード設定
- イベントリスナーやポリシーの登録
- Bladeディレクティブやビューコンポーザの登録

関連ドキュメント
-------------------------

- [makeコマンド索引](index.md)
- [make:class](class.md)
- [make:command](command.md)
- [make:exception](exception.md)
