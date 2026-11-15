Laravelのmake:event
=========================

概要
-------------------------

`make:event`はイベントクラスを生成します。
イベントは、アプリケーション内で起きた出来事を表すデータオブジェクトです。
リスナーと組み合わせて、後続の処理を分離します。

イベントとリスナーの関係
-------------------------

| 役割     | 生成コマンド    | 役割                     |
| -------- | --------------- | ------------------------ |
| イベント | `make:event`    | 何が起きたかを表す       |
| リスナー | `make:listener` | イベントを受けて処理する |

イベントクラスはデータを持ち、リスナーがそのデータを使って処理します。

生成物と生成先
-------------------------

| 生成物   | 生成先                  |
| -------- | ----------------------- |
| イベント | `app/Events/<Name>.php` |

オプション
-------------------------

| オプション | 短縮 | 用途                       |
| ---------- | ---- | -------------------------- |
| `--force`  | `-f` | 同名ファイルを上書きします |

生成内容
-------------------------

`php artisan make:event PostCreated`は次の形を生成します。

```php
class PostCreated
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public function __construct()
    {
        //
    }

    public function broadcastOn(): array
    {
        return [
            new PrivateChannel('channel-name'),
        ];
    }
}
```

`Dispatchable`は`PostCreated::dispatch()`を可能にします。
`SerializesModels`はキューに渡すときのモデル復元に使います。

イベントにデータを持たせる
--------------------------

```php
class PostCreated
{
    use Dispatchable, SerializesModels;

    public function __construct(public Post $post)
    {
    }
}
```

発行方法
-------------------------

```php
PostCreated::dispatch($post);
```

または次のように発行します。

```php
event(new PostCreated($post));
```

リスナーの作成
-------------------------

```text
php artisan make:listener SendPostCreatedNotification --event=PostCreated --queued
```

`--queued`を付けると、リスナーはキューで実行されます。
イベントクラスは`app/Events`、リスナーは`app/Listeners`に生成されます。

ブロードキャスト
-------------------------

ブラウザへリアルタイム配信する場合は、イベントに`ShouldBroadcast`を実装します。

```php
class PostCreated implements ShouldBroadcast
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public function broadcastOn(): array
    {
        return [
            new PrivateChannel('posts'),
        ];
    }
}
```

`broadcastOn()`は配信先のチャンネルを返します。
生成直後のstubは`ShouldBroadcast`を実装していないため、必要に応じて追加します。

使いどころ
-------------------------

- 投稿作成後に通知や集計を走らせる
- 注文完了後に外部APIを呼ぶ
- 複数のリスナーで同じ出来事を処理する
- ブロードキャストで画面を更新する

注意点
-------------------------

- イベントクラスには必要最小限のデータだけを持たせます
- イベント名は「何が起きたか」が分かる名前にします
- キューで使う場合は`SerializesModels`を残します
- 同期的に必ず実行する処理は、イベント任せにせずサービスに置きます

関連ドキュメント
-------------------------

- [makeコマンド索引](index.md)
- [make:listener](listener.md)
- [make:channel](channel.md)
