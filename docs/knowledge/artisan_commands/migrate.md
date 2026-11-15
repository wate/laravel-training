Laravelのマイグレーションコマンド
=========================

概要
-------------------------

`migrate`系のコマンドは、データベースのスキーマ変更を管理します。
`migrate`は未適用のマイグレーションを実行し、`migrate:rollback`は直近のバッチを取り消します。
`migrate:fresh`と`migrate:refresh`はデータを失うため、開発環境での利用に限定します。

主なコマンド
-------------------------

| コマンド                       | 用途                                       |
| ------------------------------ | ------------------------------------------ |
| `php artisan migrate`          | 未適用のマイグレーションを実行します       |
| `php artisan migrate:status`   | 各マイグレーションの適用状況を表示します   |
| `php artisan migrate:rollback` | 直近のバッチを取り消します                 |
| `php artisan migrate:refresh`  | 全マイグレーションを取り消して再実行します |
| `php artisan migrate:fresh`    | 全テーブルを削除してから再実行します       |
| `php artisan migrate:reset`    | 全マイグレーションを取り消します           |
| `php artisan migrate:install`  | `migrations`テーブルを作成します           |

`migrate`と`migrate:rollback`のデータへの影響は移行内容により異なります。
`migrate:refresh`、`migrate:fresh`、`migrate:reset`はデータを失います。

主なオプション
-------------------------

| オプション              | 用途                               |
| ----------------------- | ---------------------------------- |
| `--database[=DATABASE]` | 使用するDB接続を指定します         |
| `--force`               | 本番環境でも確認なしで実行します   |
| `--path[=PATH]`         | 実行するパスを指定します           |
| `--realpath`            | `--path`を絶対パスとして扱います   |
| `--pretend`             | 実行するSQLを表示し、実行しません  |
| `--seed`                | 実行後にシーダーを実行します       |
| `--seeder[=SEEDER]`     | 使用するルートシーダーを指定します |
| `--step`                | 1ファイルずつ実行します            |
| `--graceful`            | エラー時も終了コード0で終了します  |
| `--isolated[=ISOLATED]` | 二重実行を防ぎます                 |

`--step`は`migrate`と`migrate:rollback`で意味が異なります。
`migrate --step`は1ファイルずつ実行し、`migrate:rollback --step=1`は1ファイルだけ巻き戻します。

使用例
-------------------------

### 未適用のマイグレーションを実行する

```bash
php artisan migrate
```

初期データも投入する場合は`--seed`を付けます。

```bash
php artisan migrate --seed
```

### 適用状況を確認する

```bash
php artisan migrate:status
```

保留中のマイグレーションだけを表示する場合は`--pending`を付けます。

```bash
php artisan migrate:status --pending
```

### 直近のバッチを巻き戻す

```bash
php artisan migrate:rollback
```

1ファイルだけ巻き戻す場合は`--step=1`を指定します。

```bash
php artisan migrate:rollback --step=1
```

### データベースを作り直す

開発環境で全テーブルを作り直す場合は`migrate:fresh`を使います。
シーダーも実行する場合は`--seed`を付けます。

```bash
php artisan migrate:fresh --seed
```

### 本番環境で実行する

本番環境で`migrate`を実行する場合は`--force`が必要です。
実行前に`--pretend`でSQLを確認できます。

```bash
php artisan migrate --force
```

`--pretend`はSQLを表示するだけで、マイグレーションは実行しません。

注意点
-------------------------

- `migrate:fresh`、`migrate:refresh`、`migrate:reset`はデータを失います
- `migrate`と`migrate:rollback`も、マイグレーションの内容によってはデータを失う場合があります
- `migrate:fresh`と`migrate:refresh`は`--seed`を付けない限りシーダーを実行しません
- 本番環境で`migrate`と`migrate:rollback`を実行する場合は`--force`が必要です
- `migrate:rollback`は直近のバッチを取り消します。`--step`で対象数を限定できます
- `migrate:status --pending`は保留中のマイグレーションだけを表示します
- マイグレーションはファイル名順に実行されます

関連ドキュメント
-------------------------

- [Laravelのartisanコマンド一覧](index.md): コマンド一覧とカテゴリー
- [Laravelの初期化コマンド](initialize.md): 初期構築での実行順序
- [LaravelのDB操作コマンド](db.md): シーダーとテーブル確認
- [Laravelのテストとデータベース](test.md): テスト用DBと`RefreshDatabase`
- [Laravelスケルトンの既定テーブル](../laravel_default_tables.md): 既定テーブルと役割
