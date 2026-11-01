Laravelスケルトンの既定テーブル
===============================

概要
-------------------------

Laravelの標準スケルトンが作成するテーブルと役割をまとめます。
削除するかどうかはプロジェクトの要件に応じて判断します。

テーブル一覧
-------------------------

| テーブル                | 役割               |
| ----------------------- | ------------------ |
| `users`                 | 認証ユーザー       |
| `password_reset_tokens` | パスワードリセット |
| `sessions`              | DBセッション       |
| `cache`                 | DBキャッシュ       |
| `cache_locks`           | キャッシュロック   |
| `jobs`                  | DBキューのジョブ   |
| `job_batches`           | バッチジョブ管理   |
| `failed_jobs`           | 失敗ジョブ         |

マイグレーションファイル
-------------------------

- `0001_01_01_000000_create_users_table.php`: `users`、`password_reset_tokens`、`sessions`
- `0001_01_01_000001_create_cache_table.php`: `cache`、`cache_locks`
- `0001_01_01_000002_create_jobs_table.php`: `jobs`、`job_batches`、`failed_jobs`

既定のドライバ
-------------------------

`.env.example`では次のドライバが`database`に設定されています。
そのため、既定のままでは上記のテーブルが使用されます。

- `SESSION_DRIVER=database`
- `CACHE_STORE=database`
- `QUEUE_CONNECTION=database`

テーブルごとの用途
-------------------------

### `users`

- 認証ユーザーを保存します
- 主なカラム: `name`、`email`、`password`、`remember_token`

### `password_reset_tokens`

- パスワードリセット用のトークンを保存します
- 主なカラム: `email`、`token`、`created_at`

### `sessions`

- DBセッションを保存します
- 主なカラム: `id`、`user_id`、`ip_address`、`payload`、`last_activity`

### `cache`

- DBキャッシュを保存します
- 主なカラム: `key`、`value`、`expiration`

### `cache_locks`

- キャッシュのロックを管理します
- 主なカラム: `key`、`owner`、`expiration`

### `jobs`

- DBキューのジョブを保存します
- 主なカラム: `queue`、`payload`、`attempts`、`reserved_at`

### `job_batches`

- バッチジョブの進捗を管理します
- 主なカラム: `total_jobs`、`pending_jobs`、`failed_jobs`

### `failed_jobs`

- 失敗したジョブを保存します
- 主なカラム: `uuid`、`connection`、`queue`、`exception`

削除時の注意
-------------------------

- `cache`と`jobs`を削除する場合は、`.env`の`CACHE_STORE`と`QUEUE_CONNECTION`を`database`以外へ変更します
- `users`だけ残して`sessions`を外す場合は、マイグレーションを編集します
