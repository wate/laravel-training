Laravelのその他のmakeコマンド
=============================

概要
-------------------------

このページでは、個別ページを作っていない`make:enum`、`make:interface`、`make:trait`、`make:config`を扱います。
生成先の一覧は[makeコマンド索引](index.md)を参照してください。
各コマンドの全オプションは`php artisan help make:<command>`で確認できます。

クラスと設定
-------------------------

| コマンド         | 主なオプション                 | 用途                         |
| ---------------- | ------------------------------ | ---------------------------- |
| `make:enum`      | `--string`、`--int`、`--force` | 列挙型を生成します           |
| `make:interface` | `--force`                      | インターフェースを生成します |
| `make:trait`     | `--force`                      | トレイトを生成します         |
| `make:config`    | `--force`                      | 設定ファイルを生成します     |

`make:class`の詳細は[class.md](class.md)を参照してください。
`make:exception`の詳細は[exception.md](exception.md)を参照してください。
`make:provider`の詳細は[provider.md](provider.md)を参照してください。
`make:command`の詳細は[command.md](command.md)を参照してください。

### make:enum

`make:enum`は列挙型を生成します。
`--string`は文字列、`--int`は整数の値付き列挙型です。
省略すると値を持たない純粋な列挙型になります。

```text
php artisan make:enum Status --string
```

```php
enum Status: string
{
    case Draft = 'draft';
    case Published = 'published';
}
```

固定の状態を表すときに使います。
例えば投稿の状態、ユーザーの役割、注文のステータスです。

```php
$status = Status::from($request->status);
$status->value; // 'draft'
Status::cases();
```

モデルのキャストやバリデーションでも使えます。

```php
protected function casts(): array
{
    return [
        'status' => Status::class,
    ];
}
```

```php
'status' => ['required', Rule::enum(Status::class)],
```

値付き列挙型の値はDBに保存されます。
後から値を変更すると既存データと一致しなくなるため、値は慎重に決めます。
ユーザーが自由に追加するような分類には向いていません。

生成先は`app/Enums`、`app/Enumerations`、`app`の順に解決されます。

### make:interface

`make:interface`はインターフェースを生成します。
実装を持たず、メソッドの形だけを定義します。

```text
php artisan make:interface PaymentGateway
```

```php
interface PaymentGateway
{
    public function charge(int $amount): void;
}
```

実装クラスを作り、サービスプロバイダで紐付けます。

```php
class StripeGateway implements PaymentGateway
{
    public function charge(int $amount): void
    {
        // Stripeで決済する
    }
}
```

```php
$this->app->bind(
    PaymentGateway::class,
    StripeGateway::class,
);
```

テストでは偽の実装に差し替えられます。
複数の実装を切り替えたい場合や、外部サービスとの境界を分けたい場合に使います。

生成先は`app/Contracts`、`app/Interfaces`、`app`の順に解決されます。

### make:trait

`make:trait`はトレイトを生成します。
複数のクラスで共有するメソッドをまとめる仕組みです。

```text
php artisan make:trait HasUuid
```

```php
trait HasUuid
{
    protected static function bootHasUuid(): void
    {
        static::creating(function ($model) {
            $model->uuid ??= (string) Str::uuid();
        });
    }
}
```

モデルで`use`すると、UUIDの設定を共通化できます。

```php
class Post extends Model
{
    use HasUuid;
}
```

Laravelのモデルは`boot{TraitName}`メソッドを自動で呼びます。
この例では`bootHasUuid`が起動時に実行されます。

同じメソッド名が衝突する場合は`insteadof`や`as`で解決します。
状態を多く持つ処理はトレイトに詰め込まず、サービスへ分けます。

生成先は`app/Concerns`、`app/Traits`、`app`の順に解決されます。

### make:config

`make:config`は`config`ディレクトリに設定ファイルを生成します。
ファイル名がそのまま設定キーの名前空間になります。

```text
php artisan make:config payment
```

`config/payment.php`が生成されます。

```php
return [
    'stripe' => [
        'key' => env('STRIPE_KEY'),
        'secret' => env('STRIPE_SECRET'),
    ],
    'currency' => 'jpy',
];
```

値は`config()`で読みます。

```php
config('payment.stripe.secret');
config('payment.currency', 'jpy');
```

`.env`には秘密情報を置き、設定ファイルから`env()`で読みます。

```text
STRIPE_KEY=pk_test_...
STRIPE_SECRET=sk_test_...
```

設定ファイル以外では`env()`を直接使わず、`config()`を使います。
`php artisan config:cache`を実行すると設定がキャッシュされ、`env()`は設定ファイル内でしか期待通りに動きません。

設定を変更した後は、必要に応じて次のコマンドを実行します。

```text
php artisan config:cache
php artisan config:clear
```

`make:config`は空の配列を生成するだけです。
キーは自分で追加します。
既存ファイルを上書きする場合は`--force`を使いますが、設定を失わないよう注意します。

設定はデプロイ単位の固定値に向いています。
ユーザーごとに変わる値や実行中に更新する値は、DBなど別の保存先を検討します。

注意点
-------------------------

- `make:seeder`には`--force`がありません
- 周辺コマンドのオプションはLaravelのバージョンで変わる場合があります
- 生成したクラスの登録が必要な場合は、サービスプロバイダや`bootstrap/app.php`を確認します

関連ドキュメント
-------------------------

- [makeコマンド索引](index.md)
- [make:model](model.md)
- [make:controller](controller.md)
