Laravelのmakeコマンド
=========================

概要
-------------------------

`php artisan make:*`はクラスの雛形を生成するスキャフォールド用のコマンド群です。
引数にクラス名を渡すと、Laravelの規約に沿った名前空間とファイル名でコードを生成します。
本ディレクトリはLaravel 13.39.0のヘルプ出力を基に、主要コマンドの詳細と周辺コマンドの概要を整理します。
このファイルはコマンド一覧、生成先、生成先の解決ルールを扱います。

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

#### 詳細

- [make:model](model.md)
- [make:migration](migration.md)
- [make:factory](factory.md)
- [make:seeder](seeder.md)
- [make:cast](cast.md)
- [make:scope](scope.md)
- [make:observer](observer.md)
- [make:policy](policy.md)
- [make:rule](rule.md)

### HTTP

| コマンド          | 生成物       | 既定の生成先           |
| ----------------- | ------------ | ---------------------- |
| `make:controller` | コントローラ | `app/Http/Controllers` |
| `make:middleware` | ミドルウェア | `app/Http/Middleware`  |
| `make:request`    | FormRequest  | `app/Http/Requests`    |
| `make:resource`   | APIリソース  | `app/Http/Resources`   |

#### 詳細

- [make:controller](controller.md)
- [make:middleware](middleware.md)
- [make:request](request.md)
- [make:resource](resource.md)

### ビュー

| コマンド         | 生成物               | 既定の生成先                                        |
| ---------------- | -------------------- | --------------------------------------------------- |
| `make:view`      | Bladeビュー          | `resources/views`                                   |
| `make:component` | ビューコンポーネント | `app/View/Components`と`resources/views/components` |

#### 詳細

- [make:view](view.md)
- [make:component](component.md)

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

#### 詳細

- [make:event](event.md)
- [make:listener](listener.md)
- [make:job](job.md)
- [make:job-middleware](job-middleware.md)
- [make:notification](notification.md)
- [make:mail](mail.md)
- [make:channel](channel.md)

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

#### 詳細

- [make:command](command.md)
- [make:provider](provider.md)
- [make:class](class.md)
- [make:exception](exception.md)
- [make:test](test.md)
- [その他のmakeコマンド](others.md)

### インフラ用テーブルのマイグレーション

| コマンド                   | 生成物                  | 既定の生成先          |
| -------------------------- | ----------------------- | --------------------- |
| `make:session-table`       | `sessions`テーブル      | `database/migrations` |
| `make:cache-table`         | `cache`と`cache_locks`  | `database/migrations` |
| `make:queue-table`         | `jobs`テーブル          | `database/migrations` |
| `make:queue-batches-table` | `job_batches`テーブル   | `database/migrations` |
| `make:queue-failed-table`  | `failed_jobs`テーブル   | `database/migrations` |
| `make:notifications-table` | `notifications`テーブル | `database/migrations` |

#### 詳細

- [インフラ用テーブルのマイグレーション](infra_tables.md)

既定のスケルトンで作成済みのテーブルは[Laravelスケルトンの既定テーブル](../laravel_default_tables.md)を参照してください。

生成先の解決ルール
-------------------------

一部のコマンドは既存ディレクトリの有無で生成先を切り替えます。

- `make:model`: `app/Models`があれば`app/Models`、なければ`app`へ生成します
- `make:enum`: `app/Enums`、`app/Enumerations`の順に確認し、どちらもなければ`app`へ生成します
- `make:interface`: `app/Contracts`、`app/Interfaces`の順に確認し、どちらもなければ`app`へ生成します
- `make:trait`: `app/Concerns`、`app/Traits`の順に確認し、どちらもなければ`app`へ生成します
- `make:scope`: `app/Models`があれば`app/Models/Scopes`、なければ`app/Scopes`へ生成します
- `make:test`: 既定は`tests/Feature`、`-u`を付けると`tests/Unit`へ生成します

よく使う組み合わせ、主なオプション、設計での使いどころは[Laravelのmakeコマンド一覧](../laravel_make_commands.md)を参照してください。

関連ドキュメント
-------------------------

- [Laravelのmakeコマンド一覧](../laravel_make_commands.md): よく使う組み合わせと主なオプション
- [Laravelスケルトンの既定テーブル](../laravel_default_tables.md): 既定テーブルと役割
- [Laravelのテストとデータベース](../laravel_testing.md): テスト用DB(app_test)と接続設定の切り替え
- [Laravel公式パッケージ一覧](../packages/index.md): 公式パッケージの分類と公式ページ
- [ナレッジ目次](../index.md): 学習トピックの一覧
