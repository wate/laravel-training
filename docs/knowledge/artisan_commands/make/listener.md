Laravelのmake:listener
=========================

概要
-------------------------

`make:listener`はイベントリスナークラスを生成します。
イベントリスナーは、アプリケーション内で発行されたイベントを受け取り、後続の処理を実行する仕組みです。

オブザーバーとの違い
-------------------------

| 仕組み           | 対象                       | 向いている用途                            |
| ---------------- | -------------------------- | ----------------------------------------- |
| オブザーバー     | Eloquentモデルのイベント   | 監査ログ、スラッグ生成、キャッシュ削除    |
| イベントリスナー | アプリケーションのイベント | 通知、外部API連携、複数モデルをまたぐ処理 |

モデルイベントだけを扱う場合はオブザーバー、アプリケーションの出来事を扱う場合はイベントリスナーを使います。

生成物と生成先
-------------------------

| 生成物           | 生成先                     |
| ---------------- | -------------------------- |
| イベントリスナー | `app/Listeners/<Name>.php` |

オプション
-------------------------

| オプション      | 短縮 | 用途                                 |
| --------------- | ---- | ------------------------------------ |
| `--event=EVENT` | `-e` | 受け取るイベントクラスを指定します   |
| `--queued`      | なし | キューで実行するリスナーを生成します |
| `--force`       | `-f` | 同名ファイルを上書きします           |
| `--test`        | なし | 既定の形式のテストを生成します       |
| `--pest`        | なし | Pestテストを生成します               |
| `--phpunit`     | なし | PHPUnitテストを生成します            |

生成内容
-------------------------

### イベントを指定しない場合

`php artisan make:listener SendPostCreatedNotification`は`handle(object $event)`を持つクラスを生成します。

```php
class SendPostCreatedNotification
{
    public function handle(object $event): void
    {
        //
    }
}
```

### イベントを指定した場合

`php artisan make:listener SendPostCreatedNotification --event=PostCreated`は型付きの`handle`を生成します。
`PostCreated`は`App\Events\PostCreated`として解決されます。

```php
use App\Events\PostCreated;

class SendPostCreatedNotification
{
    public function handle(PostCreated $event): void
    {
        //
    }
}
```

`\App\Events\PostCreated`のように先頭に`\`を付けると、そのクラス名がそのまま使われます。

### キューで実行する場合

`--queued`を付けると`ShouldQueue`を実装し、`InteractsWithQueue`トレイトを持つクラスを生成します。

```php
class SendPostCreatedNotification implements ShouldQueue
{
    use InteractsWithQueue;

    public function handle(PostCreated $event): void
    {
        //
    }
}
```

イベントクラスの作成
-------------------------

イベントクラスは`make:event`で先に作ります。

```text
php artisan make:event PostCreated
php artisan make:listener SendPostCreatedNotification --event=PostCreated --queued
```

イベントクラスには、リスナーへ渡すデータをプロパティとして持たせます。

```php
class PostCreated
{
    use Dispatchable, SerializesModels;

    public function __construct(public Post $post)
    {
    }
}
```

登録方法
-------------------------

Laravel 11以降は`app/Listeners`のリスナーを自動検出します。
イベントクラスの型ヒントから、対応するイベントを判断します。

自動検出を使わない場合は、`AppServiceProvider`などで登録します。

```php
public function boot(): void
{
    Event::listen(
        PostCreated::class,
        SendPostCreatedNotification::class,
    );
}
```

`EventServiceProvider`を使う場合は`$listen`に追加します。

```php
protected $listen = [
    PostCreated::class => [
        SendPostCreatedNotification::class,
    ],
];
```

使いどころ
-------------------------

- 投稿作成後に通知を送る
- 注文完了後に外部APIを呼ぶ
- 複数のモデルをまたぐ後続処理を実行する
- 監査ログや分析イベントを記録する

注意点
-------------------------

- リスナーは既定で同期実行されます。重い処理は`--queued`を付けます
- キューを使う場合はワーカーが必要です
- 失敗時の再試行や冪等性を確認します
- 必ず実行する必要がある処理は、イベント任せにせずトランザクション内のサービスに置きます
- イベントクラスには必要最小限のデータだけを持たせます
- `--queued`を付けない場合でも、stubによっては`ShouldQueue`と`InteractsWithQueue`のuse文が残ります。不要なら削除します

関連ドキュメント
-------------------------

- [makeコマンド索引](index.md)
- [make:observer](observer.md)
- [make:event](event.md)
- [make:notification](notification.md)
