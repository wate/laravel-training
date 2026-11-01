Laravelのインフラ用テーブルマイグレーション
===========================================

概要
-------------------------

`make:*-table`はLaravelのインフラ用テーブルを作るマイグレーションを生成します。
セッション、キャッシュ、キュー、通知の保存先をデータベースにするときに使います。

生成されるテーブル
-------------------------

| コマンド                   | 生成されるテーブル     | 用途               |
| -------------------------- | ---------------------- | ------------------ |
| `make:session-table`       | `sessions`             | DBセッション       |
| `make:cache-table`         | `cache`、`cache_locks` | DBキャッシュ       |
| `make:queue-table`         | `jobs`                 | DBキューのジョブ   |
| `make:queue-batches-table` | `job_batches`          | バッチジョブの管理 |
| `make:queue-failed-table`  | `failed_jobs`          | 失敗したジョブ     |
| `make:notifications-table` | `notifications`        | データベース通知   |

生成先
-------------------------

すべて`database/migrations`にマイグレーションファイルを生成します。
コマンドはマイグレーションを作るだけで、テーブルは作りません。
テーブルを作るには`php artisan migrate`を実行します。

既定のスキーマとの関係
-------------------------

このプロジェクトの既定マイグレーションには、次のテーブルが含まれています。

- `sessions`: `0001_01_01_000000_create_users_table.php`
- `cache`、`cache_locks`: `0001_01_01_000001_create_cache_table.php`
- `jobs`、`job_batches`、`failed_jobs`: `0001_01_01_000002_create_jobs_table.php`

そのため、これらのテーブルに対して`make:session-table`、`make:cache-table`、`make:queue-table`、`make:queue-batches-table`、`make:queue-failed-table`を実行すると、同じテーブルを作るマイグレーションが重複します。
通常は実行不要です。

`notifications`テーブルは既定に含まれていません。
データベース通知を使う場合は`make:notifications-table`で追加します。

使い方
-------------------------

データベース通知を使う場合は、次のコマンドでマイグレーションを追加します。

```text
php artisan make:notifications-table
php artisan migrate
```

セッション、キャッシュ、キューをdatabaseドライバで使う場合は、既定のマイグレーションをそのまま使います。

注意点
-------------------------

- 実行前に`database/migrations`を確認します
- 同じテーブルのマイグレーションを重複して作らないようにします
- コマンドはマイグレーションを生成するだけで、実行はしません
- テーブルを削除する場合は、`.env`のドライバ設定も変更します

関連ドキュメント
-------------------------

- [makeコマンド索引](index.md)
- [Laravelスケルトンの既定テーブル](../laravel_default_tables.md)
- [make:notification](notification.md)
