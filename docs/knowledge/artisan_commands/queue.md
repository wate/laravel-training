Laravelのキュージョブコマンド
=========================

概要
-------------------------

`queue`系のコマンドは、キューのワーカー起動、失敗ジョブの確認、再実行、ワーカーの再起動に使います。
キューを使う場合だけ必要なコマンドです。
本番環境ではSupervisorやsystemdでワーカーを常駐させます。
このページはLaravel 13.xの`queue:*`を対象にしています。
バージョンによってコマンドが増減するため、全コマンドは`php artisan list queue`で確認してください。

主なコマンド
-------------------------

| コマンド                      | 用途                               |
| ----------------------------- | ---------------------------------- |
| `php artisan queue:work`      | キューのワーカーを起動します       |
| `php artisan queue:failed`    | 失敗したジョブを一覧表示します     |
| `php artisan queue:retry all` | 失敗したジョブをすべて再実行します |
| `php artisan queue:restart`   | 実行中のワーカーを再起動します     |

その他のqueueコマンド
-------------------------

| コマンド                             | 用途                                 |
| ------------------------------------ | ------------------------------------ |
| `php artisan queue:clear`            | 指定キューのジョブを削除します       |
| `php artisan queue:flush`            | 失敗ジョブをまとめて削除します       |
| `php artisan queue:forget <id>`      | 指定IDの失敗ジョブを削除します       |
| `php artisan queue:listen`           | キューを監視して順次処理します       |
| `php artisan queue:monitor <queues>` | キューの滞留数を監視します           |
| `php artisan queue:pause <queue>`    | 指定キューの処理を一時停止します     |
| `php artisan queue:resume <queue>`   | 指定キューの処理を再開します         |
| `php artisan queue:prune-batches`    | 古いバッチ記録を削除します           |
| `php artisan queue:prune-failed`     | 古い失敗ジョブを削除します           |
| `php artisan queue:retry-batch <id>` | バッチ単位で失敗ジョブを再実行します |

主なオプション
-------------------------

`queue:work`の主なオプションです。

- `--queue[=QUEUE]`: 処理するキューの名前を指定します
- `--name[=NAME]`: ワーカー名を指定します
- `--once`: 次のジョブを1つだけ処理します
- `--stop-when-empty`: キューが空になったら停止します
- `--stop-when-empty-for[=STOP-WHEN-EMPTY-FOR]`: 指定秒間ジョブがなければ停止します
- `--tries[=TRIES]`: ジョブの最大試行回数を指定します
- `--timeout[=TIMEOUT]`: 子プロセスの最大実行時間を秒で指定します
- `--backoff[=BACKOFF]`: 再試行までの待ち時間を秒で指定します
- `--max-jobs[=MAX-JOBS]`: 処理するジョブ数の上限を指定します
- `--max-time[=MAX-TIME]`: ワーカーの最大実行時間を秒で指定します
- `--memory[=MEMORY]`: メモリ上限をMBで指定します
- `--sleep[=SLEEP]`: ジョブがないときの待機秒数を指定します
- `--rest[=REST]`: ジョブ間の休止秒数を指定します
- `--force`: メンテナンスモード中でもワーカーを実行します

使用例
-------------------------

### ワーカーを起動する

```bash
php artisan queue:work
```

キューを指定する場合は`--queue`を使います。

```bash
php artisan queue:work --queue=high,default
```

### 次のジョブだけを処理する

```bash
php artisan queue:work --once
```

### 失敗したジョブを確認する

```bash
php artisan queue:failed
```

### 失敗したジョブを再実行する

```bash
php artisan queue:retry all
```

### ワーカーを再起動する

```bash
php artisan queue:restart
```

### キューを監視・一時停止する

```bash
php artisan queue:monitor default --max=1000
php artisan queue:pause default
php artisan queue:resume default
```

### ジョブを削除する

```bash
php artisan queue:clear --queue=default
php artisan queue:flush --hours=24
```

注意点
-------------------------

- `queue:work`は常駐プロセスです。本番環境ではSupervisorやsystemdで管理します
- コードを変更した後は`queue:restart`でワーカーを再起動します
- `queue:retry all`はすべての失敗ジョブを再実行します。対象を絞る場合はジョブIDや`--range`を使います
- `--force`はメンテナンスモード中でもワーカーを動かすため、必要な場合だけ使います
- `queue:clear`、`queue:flush`、`queue:forget`はジョブを削除します。実行前に対象を確認します
- `queue:monitor`は`--max`で滞留数の閾値を指定します
- `queue:pause`と`queue:resume`はキュー処理を一時停止・再開します
- `queue:prune-batches`と`queue:prune-failed`は`--hours`で保持期間を指定します
- `queue:listen`は開発向けです。本番環境では`queue:work`を使います
- キューの接続先とドライバーは`config/queue.php`と`.env`で設定します

関連ドキュメント
-------------------------

- [Laravelのartisanコマンド一覧](index.md): コマンド一覧とカテゴリー
- [Laravelのスケジュールコマンド](schedule.md): 定期実行の確認と実行
- [LaravelのPail](pail.md): ログのリアルタイム表示
- [Laravelの設定確認コマンド](config.md): キュー設定の確認
