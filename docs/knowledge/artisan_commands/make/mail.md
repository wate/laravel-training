Laravelのmake:mail
=========================

概要
-------------------------

`make:mail`はMailableクラスを生成します。
Mailableは、1通のメールの件名、本文、添付ファイルをまとめて定義するクラスです。

通知との違い
-------------------------

| 仕組み | 向いている用途                   |
| ------ | -------------------------------- |
| 通知   | 複数チャンネルへ同じ内容を届ける |
| メール | 1通のメールを細かく制御する      |

添付ファイル、件名、宛先、本文のレイアウトを細かく制御する場合はMailableを使います。

生成物と生成先
-------------------------

| 生成物 | 生成先                |
| ------ | --------------------- |
| メール | `app/Mail/<Name>.php` |

オプション
-------------------------

| オプション              | 短縮 | 用途                             |
| ----------------------- | ---- | -------------------------------- |
| `--force`               | `-f` | 同名ファイルを上書きします       |
| `--markdown[=MARKDOWN]` | `-m` | Markdownテンプレートも生成します |
| `--view[=VIEW]`         | なし | Bladeテンプレートも生成します    |
| `--test`                | なし | 既定の形式のテストを生成します   |
| `--pest`                | なし | Pestテストを生成します           |
| `--phpunit`             | なし | PHPUnitテストを生成します        |

`--markdown`と`--view`を同時に指定すると`--markdown`が優先されます。

生成内容
-------------------------

`php artisan make:mail OrderShipped`は次の形を生成します。

```php
class OrderShipped extends Mailable
{
    use Queueable, SerializesModels;

    public function envelope(): Envelope
    {
        return new Envelope(
            subject: 'Order Shipped',
        );
    }

    public function content(): Content
    {
        return new Content(
            view: 'view.name',
        );
    }

    public function attachments(): array
    {
        return [];
    }
}
```

`envelope()`は件名や送信元、`content()`は本文、`attachments()`は添付ファイルを定義します。

送信方法
-------------------------

```php
Mail::to($user)->send(new OrderShipped($order));
```

キューで送る場合は`queue()`を使います。

```php
Mail::to($user)->queue(new OrderShipped($order));
```

Mailableに`ShouldQueue`を実装する方法もあります。

テンプレート
-------------------------

### Markdownテンプレート

`--markdown=mail.order-shipped`を付けると、Markdownテンプレートも生成します。

```text
php artisan make:mail OrderShipped --markdown=mail.order-shipped
```

`content()`は次の形になります。

```php
public function content(): Content
{
    return new Content(
        markdown: 'mail.order-shipped',
    );
}
```

### Bladeテンプレート

`--view=mail.order-shipped`を付けると、Bladeテンプレートも生成します。

```text
php artisan make:mail OrderShipped --view=mail.order-shipped
```

`content()`は次の形になります。

```php
public function content(): Content
{
    return new Content(
        view: 'mail.order-shipped',
    );
}
```

テンプレートは`resources/views/mail/order-shipped.blade.php`に生成されます。

データを渡す
-------------------------

```php
class OrderShipped extends Mailable
{
    use Queueable, SerializesModels;

    public function __construct(public Order $order)
    {
    }

    public function content(): Content
    {
        return new Content(
            view: 'mail.order-shipped',
            with: [
                'order' => $this->order,
            ],
        );
    }
}
```

`with`でテンプレートへ渡すデータを指定できます。
`SerializesModels`はキューで送るときにモデルを復元します。

添付ファイル
-------------------------

```php
public function attachments(): array
{
    return [
        Attachment::fromPath('/path/to/file.pdf')
            ->as('invoice.pdf')
            ->withMime('application/pdf'),
    ];
}
```

使いどころ
-------------------------

- 注文確認メールを送る
- 請求書PDFを添付する
- パスワードリセットメールを送る
- メール本文をBladeやMarkdownで管理する

注意点
-------------------------

- メール送信にはSMTPなどの設定が必要です
- キューで送る場合はワーカーが必要です
- 添付ファイルのパスとMIMEタイプを確認します
- 複数チャンネルへ同じ内容を届ける場合は通知を使います

関連ドキュメント
-------------------------

- [makeコマンド索引](index.md)
- [make:notification](notification.md)
- [make:event](event.md)
