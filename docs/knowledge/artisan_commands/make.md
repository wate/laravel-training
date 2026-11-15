Laravelのmakeコマンド一覧
=========================

概要
-------------------------

`php artisan make:*`はクラスの雛形を生成するスキャフォールド用のコマンド群です。
引数にクラス名を渡すと、Laravelの規約に沿った名前空間とファイル名でコードを生成します。
このページでは、よく使う組み合わせ、コマンド一覧、生成先の解決ルール、主なオプション、設計での使いどころをまとめます。
このページは主要なmakeコマンドをまとめており、すべてのmakeコマンドを網羅していません。
全コマンドは`php artisan list make`で確認してください。
コマンドごとの詳細は`make/`配下のファイルを参照してください。

よく使う組み合わせ
-------------------------

| 目的               | コマンド例                                                                      | 生成物                                                                                      |
| ------------------ | ------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- |
| モデル一式         | `php artisan make:model Post -a`                                                | モデル、マイグレーション、シーダー、ファクトリ、ポリシー、リソースコントローラ、FormRequest |
| モデル一式とテスト | `php artisan make:model Post -a --phpunit`                                      | 上記に加えてモデルのPHPUnitテスト                                                           |
| リソース           | `php artisan make:controller PostController --resource --model=Post`            | モデルをバインドしたCRUDの7メソッドを持つコントローラ                                       |
| APIコントローラ    | `php artisan make:controller PostController --api --model=Post`                 | `create`と`edit`を除いたコントローラ                                                        |
| JSONリソース       | `php artisan make:resource PostResource`                                        | モデルをJSONへ変換するAPIリソース                                                           |
| FormRequest付き    | `php artisan make:controller PostController --resource --model=Post --requests` | コントローラと`StorePostRequest`、`UpdatePostRequest`                                       |
| テーブル作成       | `php artisan make:migration create_posts_table`                                 | `Schema::create`の雛形                                                                      |
| テーブル変更       | `php artisan make:migration add_status_to_posts_table --table=posts`            | `Schema::table`の雛形                                                                       |
| Featureテスト      | `php artisan make:test PostTest --phpunit`                                      | `tests/Feature`のPHPUnitテスト                                                              |
| Unitテスト         | `php artisan make:test PostTest --phpunit -u`                                   | `tests/Unit`のPHPUnitテスト                                                                 |

`make:model -a`はテストを生成しません。
テストも同時に生成する場合は`--phpunit`、`--pest`、`--test`のいずれかを指定します。

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

- [make:model](make/model.md)
- [make:migration](make/migration.md)
- [make:factory](make/factory.md)
- [make:seeder](make/seeder.md)
- [make:cast](make/cast.md)
- [make:scope](make/scope.md)
- [make:observer](make/observer.md)
- [make:policy](make/policy.md)
- [make:rule](make/rule.md)

### HTTP

| コマンド          | 生成物       | 既定の生成先           |
| ----------------- | ------------ | ---------------------- |
| `make:controller` | コントローラ | `app/Http/Controllers` |
| `make:middleware` | ミドルウェア | `app/Http/Middleware`  |
| `make:request`    | FormRequest  | `app/Http/Requests`    |
| `make:resource`   | APIリソース  | `app/Http/Resources`   |

#### 詳細

- [make:controller](make/controller.md)
- [make:middleware](make/middleware.md)
- [make:request](make/request.md)
- [make:resource](make/resource.md)

### ビュー

| コマンド         | 生成物               | 既定の生成先                                        |
| ---------------- | -------------------- | --------------------------------------------------- |
| `make:view`      | Bladeビュー          | `resources/views`                                   |
| `make:component` | ビューコンポーネント | `app/View/Components`と`resources/views/components` |

#### 詳細

- [make:view](make/view.md)
- [make:component](make/component.md)

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

- [make:event](make/event.md)
- [make:listener](make/listener.md)
- [make:job](make/job.md)
- [make:job-middleware](make/job-middleware.md)
- [make:notification](make/notification.md)
- [make:mail](make/mail.md)
- [make:channel](make/channel.md)

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

- [make:command](make/command.md)
- [make:provider](make/provider.md)
- [make:class](make/class.md)
- [make:exception](make/exception.md)
- [make:test](make/test.md)
- [その他のmakeコマンド](make/others.md)

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

- [インフラ用テーブルのマイグレーション](make/infra_tables.md)

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

主なオプション
-------------------------

| コマンド          | オプション                   | 用途                                                                     |
| ----------------- | ---------------------------- | ------------------------------------------------------------------------ |
| `make:model`      | `-a`                         | モデル一式を生成します                                                   |
| `make:model`      | `-m`                         | マイグレーションも生成します                                             |
| `make:model`      | `-r`、`--api`                | モデルをバインドしたリソースコントローラを生成します                     |
| `make:controller` | `--resource`                 | CRUDの7メソッドを持つコントローラを生成します                            |
| `make:controller` | `--api`                      | `create`と`edit`を除いたコントローラを生成します                         |
| `make:controller` | `--requests`                 | `store`と`update`用のFormRequestを生成します                             |
| `make:controller` | `-i`、`-s`                   | invokableコントローラとシングルトンリソースを生成します                  |
| `make:resource`   | `--collection`、`--json-api` | コレクション用とJSON:API用のリソースを生成します                         |
| `make:migration`  | `--create`、`--table`        | 作成用と変更用の雛形を切り替えます                                       |
| `make:test`       | `--phpunit`、`-u`            | PHPUnit形式とUnitテストを指定します                                      |
| 多くのコマンド    | `--force`                    | 同名ファイルが存在しても上書きします。`make:model`の`-f`はファクトリです |

`--force`を付けない場合、同名ファイルが存在するとエラーになり生成は行われません。
ただし`make:model`は追加コンポーネントを生成するか確認されます。
`make:middleware`と`make:seeder`には`--force`がありません。

設計での使いどころ
-------------------------

| 設計対象         | 使うコマンド                                                     | ポイント                                                                   |
| ---------------- | ---------------------------------------------------------------- | -------------------------------------------------------------------------- |
| モデルとテーブル | `make:model`、`make:migration`、`make:factory`、`make:seeder`    | モデルとテーブルを先に決め、テストデータはファクトリとシーダーで用意します |
| 画面とHTTP       | `make:controller`、`make:request`、`make:view`、`make:component` | 入力検証はFormRequest、表示はBladeへ分けます                               |
| リクエスト前処理 | `make:middleware`                                                | ロケール、認証、セキュリティヘッダーなどをコントローラから分離します       |
| サービス登録     | `make:provider`                                                  | インターフェースと実装の紐付けや起動時の設定を分離します                   |
| API              | `make:controller`、`make:request`、`make:resource`               | コントローラは処理、FormRequestは入力検証、ResourceはJSON整形を担当します  |
| 認可             | `make:policy`                                                    | モデル単位の権限判定を分離します                                           |
| 例外             | `make:exception`                                                 | 業務ルール違反を型で表し、レスポンスとログを分離します                     |
| テスト           | `make:test`                                                      | FeatureはHTTP、Unitは純粋なロジックに使います                              |
| 定型処理         | `make:command`                                                   | 定期実行や手動実行の処理をCLIに分離します                                  |
| 非同期処理       | `make:job`、`make:event`、`make:listener`                        | 重い処理や副作用をリクエストから切り離します                               |
| ジョブ制御       | `make:job-middleware`                                            | レート制限や重複防止をジョブから分離します                                 |
| 通知             | `make:notification`、`make:mail`                                 | 複数チャンネルの通知と1通のメールを分けます                                |

コマンドの探し方
-------------------------

- カテゴリ別の一覧と生成先: このページの「コマンド一覧」を参照してください
- 個別コマンドの詳細: 各カテゴリの「詳細」リンクから辿れます
- enum、interface、trait、config: [その他のmakeコマンド](make/others.md)

関連ドキュメント
-------------------------

- [Laravelのartisanコマンド一覧](index.md): 実行、DB操作、キャッシュなどmake以外のコマンド
- [アーキテクチャ参考資料](../architecture/index.md): Action、Domain、UseCase、Repositoryの参考構成
- [Laravelスケルトンの既定テーブル](../laravel_default_tables.md): 既定テーブルと役割
- [Laravelのテストとデータベース](test.md): テストの実行と、テスト用DB・環境変数の切り替え
- [Laravel公式パッケージ一覧](../packages/index.md): 公式パッケージの分類と公式ページ
- [ナレッジ目次](../index.md): 学習トピックの一覧
