Laravelのmake:notification
==========================

概要
-------------------------

`make:notification`は通知クラスを生成します。
通知は、メール、データベース、ブロードキャストなどの複数チャンネルへ同じ出来事を届ける仕組みです。

メールとの違い
-------------------------

| 仕組み | 向いている用途                   |
| ------ | -------------------------------- |
| 通知   | 複数チャンネルへ同じ内容を届ける |
| メール | 1通のメールを細かく制御する      |

通知の`via()`でチャンネルを選びます。
メールだけを送る場合でも、通知の`mail`チャンネルを使えます。
添付ファイルや件名を細かく制御する場合は、Mailableを使います。

生成物と生成先
-------------------------

| 生成物 | 生成先                         |
| ------ | ------------------------------ |
| 通知   | `app/Notifications/<Name>.php` |

オプション
-------------------------

| オプション              | 短縮 | 用途                             |
| ----------------------- | ---- | -------------------------------- |
| `--force`               | `-f` | 同名ファイルを上書きします       |
| `--markdown[=MARKDOWN]` | `-m` | Markdownテンプレートも生成します |
| `--test`                | なし | 既定の形式のテストを生成します   |
| `--pest`                | なし | Pestテストを生成します           |
| `--phpunit`             | なし | PHPUnitテストを生成します        |

生成内容
-------------------------

`php artisan make:notification PostPublished`は次の形を生成します。

```php
class PostPublished extends Notification
{
    use Queueable;

    public function via(object $notifiable): array
    {
        return ['mail'];
    }

    public function toMail(object $notifiable): MailMessage
    {
        return (new MailMessage)
            ->line('The introduction to the notification.')
            ->action('Notification Action', url('/'))
            ->line('Thank you for using our application!');
    }

    public function toArray(object $notifiable): array
    {
        return [
            //
        ];
    }
}
```

`via()`に配信チャンネルを書きます。
`toMail()`はメール、`toArray()`はデータベース通知の内容を返します。

チャンネル
-------------------------

| チャンネル  | 用途                       |
| ----------- | -------------------------- |
| `mail`      | メールで送る               |
| `database`  | アプリ内通知として保存する |
| `broadcast` | リアルタイム配信する       |

複数チャンネルへ送る場合は`via()`に追加します。

```php
public function via(object $notifiable): array
{
    return ['mail', 'database'];
}
```

送信方法
-------------------------

```php
$user->notify(new PostPublished($post));
```

複数ユーザーへ送る場合は`Notification::send()`を使います。

```php
Notification::send($users, new PostPublished($post));
```

キューで送る
-------------------------

通知クラスに`ShouldQueue`を実装すると、キューで送信されます。

```php
class PostPublished extends Notification implements ShouldQueue
{
    use Queueable;
}
```

`Queueable`トレイトは生成時から含まれています。
`ShouldQueue`の実装を追加します。

Markdownテンプレート
-------------------------

`--markdown=mail.post-published`を付けると、Markdownテンプレートも生成します。

```text
php artisan make:notification PostPublished --markdown=mail.post-published
```

`toMail()`は次の形になります。

```php
public function toMail(object $notifiable): MailMessage
{
    return (new MailMessage)->markdown('mail.post-published');
}
```

使いどころ
-------------------------

- 投稿公開をメールとアプリ内通知で知らせる
- 注文完了を複数チャンネルで通知する
- ユーザーごとに通知の受け取り方を変える

注意点
-------------------------

- `via()`にないチャンネルのメソッドは呼ばれません
- データベース通知を使う場合は`notifications`テーブルが必要です
- キューで送る場合はワーカーが必要です
- メールの添付や細かいヘッダー制御はMailableの方が向いています

関連ドキュメント
-------------------------

- [makeコマンド索引](index.md)
- [make:mail](mail.md)
- [make:event](event.md)
- [インフラ用テーブルのマイグレーション](infra_tables.md)
