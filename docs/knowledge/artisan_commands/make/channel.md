Laravelのmake:channel
=========================

概要
-------------------------

`make:channel`はブロードキャストチャンネルの認可クラスを生成します。
ブラウザがプライベートチャンネルやプレゼンスチャンネルを購読するとき、
そのユーザーが参加してよいかを判定します。

ブロードキャストチャンネルとは
------------------------------

ブロードキャストは、サーバー側のイベントをブラウザへリアルタイム配信する仕組みです。
チャンネルは配信先の単位です。

| 種類         | 例                               | 認可 | 用途                 |
| ------------ | -------------------------------- | ---- | -------------------- |
| パブリック   | `new Channel('orders')`          | 不要 | 誰でも購読できる通知 |
| プライベート | `new PrivateChannel('orders.1')` | 必要 | 注文者だけに届ける   |
| プレゼンス   | `new PresenceChannel('chat.1')`  | 必要 | 参加者一覧も共有する |

`make:channel`が生成するのは、プライベートとプレゼンスの認可クラスです。
パブリックチャンネルだけなら生成は不要です。

生成物と生成先
-------------------------

| 生成物         | 生成先                        |
| -------------- | ----------------------------- |
| チャンネル認可 | `app/Broadcasting/<Name>.php` |

オプション
-------------------------

| オプション | 短縮 | 用途                       |
| ---------- | ---- | -------------------------- |
| `--force`  | `-f` | 同名ファイルを上書きします |

生成内容
-------------------------

`php artisan make:channel OrderChannel`は次の形を生成します。

```php
class OrderChannel
{
    public function join(User $user): array|bool
    {
        //
    }
}
```

`join()`で参加可否を返します。
`true`なら参加、`false`なら拒否です。
プレゼンスチャンネルでは、参加者情報の配列を返します。

認可の実装
-------------------------

```php
public function join(User $user, int $orderId): bool
{
    return $user->id === Order::findOrNew($orderId)->user_id;
}
```

`routes/channels.php`に登録します。

```php
Broadcast::channel('orders.{orderId}', OrderChannel::class);
```

イベント側
-------------------------

イベントに`ShouldBroadcast`を実装し、`broadcastOn()`でチャンネルを返します。

```php
public function broadcastOn(): array
{
    return [
        new PrivateChannel('orders.'.$this->order->id),
    ];
}
```

ブラウザ側
-------------------------

Laravel Echoで購読します。

```js
Echo.private(`orders.${orderId}`)
    .listen('OrderShipped', (event) => {
        console.log(event);
    });
```

セットアップ
-------------------------

ブロードキャストを使うには、先に設定を追加します。

```text
php artisan install:broadcasting
```

`routes/channels.php`が作成され、ブロードキャストの設定が追加されます。
登録済みのプライベートチャンネルは`php artisan channel:list`で確認できます。

注意点
-------------------------

- パブリックチャンネルは認可されません
- 機密情報はパブリックチャンネルへ流しません
- プライベートとプレゼンスは認可が必須です
- `join()`の引数はチャンネル名のプレースホルダーと一致させます
- ブロードキャストにはキューワーカーが必要な場合があります

関連ドキュメント
-------------------------

- [makeコマンド索引](index.md)
- [make:event](event.md)
