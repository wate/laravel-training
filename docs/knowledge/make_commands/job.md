Laravelのmake:job
=========================

概要
-------------------------

`make:job`はキューで実行するジョブクラスを生成します。
ジョブは、重い処理や時間のかかる処理をリクエストから切り離して実行する単位です。

ジョブとは
-------------------------

ジョブは「あとで実行したい処理」を表します。
キューに投入し、ワーカーが取り出して実行します。

代表的な用途は次のとおりです。

- メールの遅延送信
- 一斉配信
- 画像変換やPDF生成
- 外部APIの呼び出し
- 集計やレポート作成

生成物と生成先
-------------------------

| 生成物 | 生成先                |
| ------ | --------------------- |
| ジョブ | `app/Jobs/<Name>.php` |

オプション
-------------------------

| オプション  | 短縮 | 用途                           |
| ----------- | ---- | ------------------------------ |
| `--force`   | `-f` | 同名ファイルを上書きします     |
| `--sync`    | なし | 同期実行用のジョブを生成します |
| `--batched` | なし | バッチ可能なジョブを生成します |
| `--test`    | なし | 既定の形式のテストを生成します |
| `--pest`    | なし | Pestテストを生成します         |
| `--phpunit` | なし | PHPUnitテストを生成します      |

`--sync`と`--batched`を同時に指定すると`--batched`が優先されます。

生成内容
-------------------------

### 既定のジョブ

`php artisan make:job ProcessPodcast`は`ShouldQueue`を実装したジョブを生成します。

```php
class ProcessPodcast implements ShouldQueue
{
    use Queueable;

    public function handle(): void
    {
        //
    }
}
```

`handle()`に実行したい処理を書きます。

### 同期ジョブ

`--sync`を付けると`ShouldQueue`を実装しないジョブを生成します。

```php
class ProcessPodcast
{
    use Dispatchable;

    public function handle(): void
    {
        //
    }
}
```

同期ジョブは`dispatch()`してもその場で実行されます。

### バッチジョブ

`--batched`を付けると`Batchable`を持つジョブを生成します。

```php
class ProcessPodcast implements ShouldQueue
{
    use Batchable, Queueable;

    public function handle(): void
    {
        if ($this->batch()->cancelled()) {
            return;
        }

        //
    }
}
```

`Bus::batch()`でまとめて実行し、進捗やキャンセルを管理できます。

ディスパッチ
-------------------------

```php
ProcessPodcast::dispatch($podcast);
```

遅延実行する場合は`delay()`を付けます。

```php
ProcessPodcast::dispatch($podcast)->delay(now()->addMinutes(10));
```

キューや接続を変える場合は`onQueue()`や`onConnection()`を使います。

```php
ProcessPodcast::dispatch($podcast)
    ->onQueue('podcasts')
    ->onConnection('redis');
```

`redis`接続を使う場合は、Redisの設定とサーバーが必要です。

バッチ実行
-------------------------

```php
Bus::batch([
    new ProcessPodcast($podcast1),
    new ProcessPodcast($podcast2),
])->dispatch();
```

一斉配信では、1つのジョブで全件処理せず、1件ずつジョブを分けます。
`Bus::batch()`や`chunkById()`を使うと、メモリと失敗の影響を抑えられます。

キューの実行
-------------------------

このプロジェクトは`.env`で`QUEUE_CONNECTION=database`になっています。
`jobs`テーブルにジョブが保存され、ワーカーが実行します。

```text
php artisan queue:work
```

`composer dev`にもキューリスナーが含まれています。
失敗したジョブは`php artisan queue:failed`で確認し、`queue:retry`で再実行します。

再試行と失敗
-------------------------

```php
class ProcessPodcast implements ShouldQueue
{
    public $tries = 3;

    public $backoff = 60;

    public function failed(Throwable $exception): void
    {
        // 失敗時の処理
    }
}
```

`tries`は試行回数、`backoff`は再試行までの秒数です。
ジョブは冪等になるように設計します。

使いどころ
-------------------------

- メールを遅延送信する
- 一斉配信を分割して実行する
- 外部APIの呼び出しをリクエストから切り離す
- 重い集計やレポート作成を非同期にする

注意点
-------------------------

- キューを使うにはワーカーが必要です
- `QUEUE_CONNECTION=sync`では同期実行になります
- ジョブには必要最小限のデータだけを持たせます
- 大きなコレクションを1つのジョブに詰め込まない
- 失敗時の再試行と冪等性を確認します

関連ドキュメント
-------------------------

- [makeコマンド索引](index.md)
- [make:command](command.md)
- [make:job-middleware](job-middleware.md)
- [make:event](event.md)
- [make:listener](listener.md)
- [インフラ用テーブルのマイグレーション](infra_tables.md)
