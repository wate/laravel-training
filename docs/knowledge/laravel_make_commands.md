Laravelのmakeコマンド
=========================

概要
-------------------------

`php artisan make:*`はクラスの雛形を生成するスキャフォールド用のコマンド群です。
引数にクラス名を渡すと、Laravelの規約に沿った名前空間とファイル名でコードを生成します。
本ドキュメントはLaravel 13.39.0のヘルプ出力を基にしています。

コマンド一覧
-------------------------

### モデルとデータベース

| コマンド         | 生成物               | 既定の生成先          |
| ---------------- | -------------------- | --------------------- |
| `make:model`     | Eloquentモデル       | `app/Models`          |
| `make:migration` | マイグレーション     | `database/migrations` |
| `make:seeder`    | シーダー             | `database/seeders`    |
| `make:factory`   | モデルファクトリ     | `database/factories`  |
| `make:cast`      | カスタムキャスト     | `app/Casts`           |
| `make:scope`     | グローバルスコープ   | `app/Models/Scopes`   |
| `make:observer`  | オブザーバー         | `app/Observers`       |
| `make:policy`    | ポリシー             | `app/Policies`        |
| `make:rule`      | バリデーションルール | `app/Rules`           |

### HTTP

| コマンド          | 生成物       | 既定の生成先           |
| ----------------- | ------------ | ---------------------- |
| `make:controller` | コントローラ | `app/Http/Controllers` |
| `make:middleware` | ミドルウェア | `app/Http/Middleware`  |
| `make:request`    | FormRequest  | `app/Http/Requests`    |
| `make:resource`   | APIリソース  | `app/Http/Resources`   |

### ビュー

| コマンド         | 生成物               | 既定の生成先                                        |
| ---------------- | -------------------- | --------------------------------------------------- |
| `make:view`      | Bladeビュー          | `resources/views`                                   |
| `make:component` | ビューコンポーネント | `app/View/Components`と`resources/views/components` |

### イベントとキュー

| コマンド              | 生成物                     | 既定の生成先          |
| --------------------- | -------------------------- | --------------------- |
| `make:event`          | イベント                   | `app/Events`          |
| `make:listener`       | イベントリスナー           | `app/Listeners`       |
| `make:job`            | ジョブ                     | `app/Jobs`            |
| `make:job-middleware` | ジョブミドルウェア         | `app/Jobs/Middleware` |
| `make:notification`   | 通知                       | `app/Notifications`   |
| `make:mail`           | メール                     | `app/Mail`            |
| `make:channel`        | ブロードキャストチャンネル | `app/Broadcasting`    |

### その他のクラス

| コマンド         | 生成物             | 既定の生成先           |
| ---------------- | ------------------ | ---------------------- |
| `make:command`   | Artisanコマンド    | `app/Console/Commands` |
| `make:provider`  | サービスプロバイダ | `app/Providers`        |
| `make:exception` | 例外クラス         | `app/Exceptions`       |
| `make:class`     | 汎用クラス         | `app`                  |
| `make:enum`      | 列挙型             | `app`                  |
| `make:interface` | インターフェース   | `app`                  |
| `make:trait`     | トレイト           | `app`                  |
| `make:config`    | 設定ファイル       | `config`               |
| `make:test`      | テストクラス       | `tests/Feature`        |

### インフラ用テーブルのマイグレーション

| コマンド                   | 生成物                  | 既定の生成先          |
| -------------------------- | ----------------------- | --------------------- |
| `make:session-table`       | `sessions`テーブル      | `database/migrations` |
| `make:cache-table`         | `cache`と`cache_locks`  | `database/migrations` |
| `make:queue-table`         | `jobs`テーブル          | `database/migrations` |
| `make:queue-batches-table` | `job_batches`テーブル   | `database/migrations` |
| `make:queue-failed-table`  | `failed_jobs`テーブル   | `database/migrations` |
| `make:notifications-table` | `notifications`テーブル | `database/migrations` |

既定のスケルトンで作成済みのテーブルは[Laravelスケルトンの既定テーブル](laravel_default_tables.md)を参照してください。

生成先の解決ルール
-------------------------

一部のコマンドは既存ディレクトリの有無で生成先を切り替えます。

- `make:model`: `app/Models`があれば`app/Models`、なければ`app`へ生成します
- `make:enum`: `app/Enums`、`app/Enumerations`の順に確認し、どちらもなければ`app`へ生成します
- `make:interface`: `app/Contracts`、`app/Interfaces`の順に確認し、どちらもなければ`app`へ生成します
- `make:trait`: `app/Concerns`、`app/Traits`の順に確認し、どちらもなければ`app`へ生成します
- `make:scope`: `app/Models`があれば`app/Models/Scopes`、なければ`app/Scopes`へ生成します
- `make:test`: 既定は`tests/Feature`、`-u`を付けると`tests/Unit`へ生成します

主なオプション
-------------------------

| コマンド          | オプション       | 用途                                                                                                    |
| ----------------- | ---------------- | ------------------------------------------------------------------------------------------------------- |
| `make:model`      | `-a`             | マイグレーション、シーダー、ファクトリ、ポリシー、リソースコントローラ、FormRequestをまとめて生成します |
| `make:model`      | `-r`と`--api`    | モデルをバインドしたリソースコントローラを生成します                                                    |
| `make:model`      | `-R`             | `store`と`update`用のFormRequestを生成します                                                            |
| `make:model`      | `--phpunit`      | PHPUnit形式のテストも生成します                                                                         |
| `make:controller` | `--resource`     | CRUDの7メソッドを持つコントローラを生成します                                                           |
| `make:controller` | `--api`          | `create`と`edit`を除いたコントローラを生成します                                                        |
| `make:controller` | `--requests`     | `store`と`update`用のFormRequestを生成します                                                            |
| `make:controller` | `-m Post`        | 指定モデルを型ヒントに持つリソースコントローラを生成します                                              |
| `make:controller` | `-i`と`-s`       | invokableコントローラとシングルトンリソースコントローラを生成します                                     |
| `make:migration`  | `--create=posts` | テーブル作成用の雛形を生成します                                                                        |
| `make:migration`  | `--table=posts`  | 既存テーブル変更用の雛形を生成します                                                                    |
| `make:test`       | `--phpunit`      | PHPUnit形式のテストを生成します                                                                         |
| 共通              | `-f`と`--force`  | 同名ファイルが存在しても上書きします                                                                    |

`-f`を付けない場合、同名ファイルが存在するとエラーになり生成は行われません。
`make:component`に`--view`を付けると、ビューのみの無名コンポーネントを生成します。

関連ドキュメント
-------------------------

- [Laravelスケルトンの既定テーブル](laravel_default_tables.md): 既定テーブルと役割
- [Laravelのテストとデータベース](laravel_testing.md): テスト用DB(app_test)と接続設定の切り替え
