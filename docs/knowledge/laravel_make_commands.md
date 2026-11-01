Laravelのmakeコマンド一覧
=========================

概要
-------------------------

`php artisan make:*`の全体像、よく使う組み合わせ、主なオプション、設計での使いどころをまとめます。
コマンドごとの詳細は[makeコマンド索引](make_commands/index.md)からカテゴリ別に辿れます。

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

- カテゴリ別の一覧と生成先: [makeコマンド索引](make_commands/index.md)
- 個別コマンドの詳細: 索引の「詳細」リンクから辿れます
- enum、interface、trait、config: [その他のmakeコマンド](make_commands/others.md)

関連ドキュメント
-------------------------

- [makeコマンド索引](make_commands/index.md): カテゴリ別の一覧と生成先
- [Laravelスケルトンの既定テーブル](laravel_default_tables.md): 既定テーブルと役割
- [Laravelのテストとデータベース](laravel_testing.md): テスト用DB(app_test)と接続設定の切り替え
- [Laravel公式パッケージ一覧](packages/index.md): 公式パッケージの分類と公式ページ
- [ナレッジ目次](index.md): 学習トピックの一覧
