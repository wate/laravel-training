Laravelのmake:command
=========================

概要
-------------------------

`make:command`はArtisanコマンドクラスを生成します。
Artisanコマンドは、`php artisan`から実行する定型処理をまとめる仕組みです。
手動実行とスケジュール実行の両方に向いています。

Artisanコマンドとは
-------------------------

Artisanコマンドは、CLIから実行する処理の単位です。
次のような定型処理に向いています。

- データの集計やクリーンアップ
- CSVの取り込み
- リマインドの送信
- 外部APIとの同期
- レポートの生成

コマンドは`php artisan app:send-reminders`のように実行します。
スケジュールに登録すると、毎日・毎時などの定期実行もできます。

生成物と生成先
-------------------------

| 生成物          | 生成先                            |
| --------------- | --------------------------------- |
| Artisanコマンド | `app/Console/Commands/<Name>.php` |

オプション
-------------------------

| オプション          | 短縮 | 用途                           |
| ------------------- | ---- | ------------------------------ |
| `--force`           | `-f` | 同名ファイルを上書きします     |
| `--command=COMMAND` | なし | 実行時のコマンド名を指定します |
| `--test`            | なし | 既定の形式のテストを生成します |
| `--pest`            | なし | Pestテストを生成します         |
| `--phpunit`         | なし | PHPUnitテストを生成します      |

`--command`を省略すると、クラス名をケバブケースにした`app:<name>`が使われます。
`SendEmails`なら`app:send-emails`です。

生成内容
-------------------------

`php artisan make:command SendReminders`は次の形を生成します。

```php
#[Signature('app:send-reminders')]
#[Description('Command description')]
class SendReminders extends Command
{
    public function handle()
    {
        //
    }
}
```

`#[Signature]`にコマンド名と引数・オプションを書きます。
`#[Description]`は`php artisan list`に表示される説明です。
属性を使う場合は`use Illuminate\Console\Attributes\Signature;`と`use Illuminate\Console\Attributes\Description;`を追加します。

処理の実装
-------------------------

```php
#[Signature('app:send-reminders {--dry-run}')]
#[Description('Send reminders to users')]
class SendReminders extends Command
{
    public function handle(): int
    {
        if ($this->option('dry-run')) {
            $this->info('Dry run: no reminders sent.');

            return self::SUCCESS;
        }

        // リマインド送信処理

        $this->info('Reminders sent.');

        return self::SUCCESS;
    }
}
```

`handle()`の戻り値は終了コードです。
`self::SUCCESS`は0、`self::FAILURE`は1として扱われます。

引数とオプション
-------------------------

```php
#[Signature('app:import {file} {--queue}')]
```

- `{file}`は必須の引数です
- `{file?}`は任意の引数です
- `{--queue}`は真偽値のオプションです
- `{--date=}`は値を受け取るオプションです

```php
$file = $this->argument('file');
$queue = $this->option('queue');
```

出力
-------------------------

```php
$this->info('完了しました。');
$this->error('失敗しました。');
$this->table(['ID', '名前'], [[1, '山田']]);
```

`$this->newLine()`で空行を入れられます。

登録方法
-------------------------

Laravel 11以降は`app/Console/Commands`のコマンドを自動検出します。
通常は登録不要です。

検出対象を変える場合は`bootstrap/app.php`で`withCommands()`を使います。

```php
->withCommands([
    __DIR__.'/../app/Console/Commands',
])
```

スケジュール実行
-------------------------

`routes/console.php`にスケジュールを登録します。

```php
use Illuminate\Support\Facades\Schedule;

Schedule::command('app:send-reminders')->dailyAt('09:00');
```

重複実行を防ぐ場合は`withoutOverlapping()`を付けます。

```php
Schedule::command('app:send-reminders')
    ->dailyAt('09:00')
    ->withoutOverlapping();
```

複数サーバーで1回だけ実行する場合は`onOneServer()`を使います。

```php
Schedule::command('app:send-reminders')
    ->dailyAt('09:00')
    ->onOneServer();
```

本番ではcronに`php artisan schedule:run`を毎分実行させます。
ローカルでは`php artisan schedule:work`で確認できます。

コマンドとジョブの違い
-------------------------

| 仕組み   | 実行方法          | 向いている用途                   |
| -------- | ----------------- | -------------------------------- |
| コマンド | CLI、スケジュール | 定型処理、手動実行、バッチの入口 |
| ジョブ   | キュー、ワーカー  | 重い処理、非同期処理、再試行     |

重い処理はコマンドからジョブをdispatchし、キューで実行する形に分けます。

使いどころ
-------------------------

- 毎日の集計やクリーンアップ
- CSVの定期取り込み
- リマインドの一括送信
- 外部APIとの同期
- レポートの生成

注意点
-------------------------

- `handle()`の戻り値で成功・失敗を返します
- スケジュール実行にはcronまたは`schedule:work`が必要です
- 重複実行を防ぐには`withoutOverlapping()`を使います
- 重い処理はジョブに分けます
- 本番ではログと終了コードを確認します

関連ドキュメント
-------------------------

- [makeコマンド索引](index.md)
- [make:job](job.md)
- [make:test](test.md)
