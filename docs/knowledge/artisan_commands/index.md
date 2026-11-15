Laravelのartisanコマンド一覧
=========================

概要
-------------------------

`make`以外でよく使うartisanコマンドをカテゴリー別にまとめます。
`make:*`はコマンド数が多いため、このページでは扱いません。
掲載内容はLaravel 13.xの`php artisan list --raw`と各コマンドの`--help`をもとにしています。

makeコマンド
-------------------------

`php artisan make:*`もartisanコマンドに含まれ、モデルやコントローラなどの雛形を生成します。
生成できるクラスの種類が多く、このページに含めると一覧が大きくなるため別ページで扱います。

- [Laravelのmakeコマンド一覧](make.md): よく使う組み合わせと主なオプション
- [makeコマンド索引](make/index.md): カテゴリ別のコマンド一覧と生成先

開発と動作確認
-------------------------

| コマンド               | 用途                                           |
| ---------------------- | ---------------------------------------------- |
| `php artisan serve`    | 開発サーバーを起動します                       |
| `php artisan dev`      | 開発用のプロセスをまとめて起動します           |
| `php artisan dev:list` | `dev`が起動するプロセスの一覧を表示します      |
| `php artisan about`    | 環境、キャッシュ、ドライバーの概要を表示します |
| `php artisan tinker`   | 対話型REPLを起動します                         |
| `php artisan env`      | 現在の環境名を表示します                       |

`dev`はサーバー、キュー、Viteをまとめて起動します。
Laravelのスケルトンでは`composer dev`がこのコマンドを呼び出します。

データベース
-------------------------

| コマンド                       | 用途                                               |
| ------------------------------ | -------------------------------------------------- |
| `php artisan migrate`          | 未適用のマイグレーションを実行します               |
| `php artisan migrate:status`   | 各マイグレーションの適用状況を表示します           |
| `php artisan migrate:rollback` | 直近のバッチを取り消します                         |
| `php artisan migrate:fresh`    | 全テーブルを削除してマイグレーションをやり直します |
| `php artisan db:seed`          | シーダーを実行します                               |
| `php artisan db:show`          | 接続先のDB情報とテーブル一覧を表示します           |
| `php artisan db:table users`   | 指定したテーブルの定義とインデックスを表示します   |
| `php artisan db`               | 接続先DBのCLIセッションを開始します                |

`migrate:fresh`は全データを失います。
開発環境以外では実行しないでください。
本番環境で`migrate`を実行する場合、`--force`が必要です。

### マイグレーション系の使い分け

| コマンド           | 動作                                       | データ |
| ------------------ | ------------------------------------------ | ------ |
| `migrate`          | 未適用分だけ実行します                     | 保持   |
| `migrate:rollback` | 直近のバッチだけ取り消します               | 保持   |
| `migrate:refresh`  | 全マイグレーションを取り消して再実行します | 損失   |
| `migrate:fresh`    | 全テーブルを削除してから再実行します       | 損失   |
| `migrate:reset`    | 全マイグレーションを取り消します           | 損失   |

`migrate:refresh`と`migrate:fresh`はシーダーを自動実行しません。
初期データが必要な場合は`--seed`を付けます。

キャッシュと最適化
-------------------------

| コマンド                     | 用途                                                   |
| ---------------------------- | ------------------------------------------------------ |
| `php artisan optimize`       | 設定、イベント、ルート、ビューのキャッシュを生成します |
| `php artisan optimize:clear` | 生成したキャッシュをまとめて削除します                 |
| `php artisan config:clear`   | 設定キャッシュを削除します                             |
| `php artisan cache:clear`    | アプリケーションキャッシュを削除します                 |
| `php artisan view:clear`     | コンパイル済みのBladeテンプレートを削除します          |
| `php artisan route:clear`    | ルートキャッシュを削除します                           |

`.env`を変更したのに反映されない場合は`config:clear`を実行します。
Bladeを編集したのに表示が変わらない場合は`view:clear`を実行します。

定義の確認
-------------------------

| コマンド                      | 用途                                             |
| ----------------------------- | ------------------------------------------------ |
| `php artisan route:list`      | 登録済みのルートを一覧表示します                 |
| `php artisan config:show app` | 指定した設定ファイルの値を表示します             |
| `php artisan model:show User` | モデルの属性、リレーション、イベントを表示します |
| `php artisan event:list`      | イベントとリスナーの対応を一覧表示します         |
| `php artisan schedule:list`   | 登録済みの定期実行タスクを一覧表示します         |
| `php artisan channel:list`    | ブロードキャストチャンネルを一覧表示します       |

`route:list`は`--except-vendor`でパッケージ側のルートを除外できます。
`--path`や`--name`でも表示対象を絞り込めます。
ルート定義を変更した後は、`route:list`で登録内容を確認します。

テスト
-------------------------

| コマンド           | 用途               |
| ------------------ | ------------------ |
| `php artisan test` | テストを実行します |

Laravelのスケルトンでは`composer test`が`config:clear`の後にこのコマンドを実行します。
主なオプションは[Laravelのテストとデータベース](test.md)を参照してください。

ログとキュー
-------------------------

| コマンド                         | 用途                               |
| -------------------------------- | ---------------------------------- |
| `php artisan pail`               | ログをリアルタイムで表示します     |
| `php artisan pail --level=error` | エラーログだけに絞って表示します   |
| `php artisan queue:work`         | キューのワーカーを起動します       |
| `php artisan queue:failed`       | 失敗したジョブを一覧表示します     |
| `php artisan queue:retry all`    | 失敗したジョブをすべて再実行します |
| `php artisan queue:restart`      | 実行中のワーカーを再起動します     |

`pail`の詳細は[Laravel Pail](../packages/pail.md)を参照してください。
`tinker`の詳細は[Laravel Tinker](../packages/tinker.md)を参照してください。

スケジュール
-------------------------

| コマンド                                  | 用途                                  |
| ----------------------------------------- | ------------------------------------- |
| `php artisan schedule:list`               | 登録済みタスクを一覧表示します        |
| `php artisan schedule:test --name=<name>` | 指定したタスクを即時実行します        |
| `php artisan schedule:run`                | 実行時刻を迎えたタスクを1回実行します |
| `php artisan schedule:work`               | ローカルで常駐実行します              |

本番環境ではcronから毎分`schedule:run`を呼び出します。

メンテナンスと本番向け
-------------------------

| コマンド                     | 用途                                               |
| ---------------------------- | -------------------------------------------------- |
| `php artisan down`           | メンテナンスモードに切り替えます                   |
| `php artisan up`             | メンテナンスモードを解除します                     |
| `php artisan storage:link`   | `public/storage`へのシンボリックリンクを作成します |
| `php artisan storage:unlink` | 作成済みのシンボリックリンクを削除します           |
| `php artisan key:generate`   | `APP_KEY`を生成します                              |
| `php artisan vendor:publish` | パッケージの設定やアセットを公開します             |
| `php artisan schema:dump`    | 現在のDBスキーマをダンプします                     |

サードパーティーパッケージ
-------------------------

サードパーティーパッケージは、独自のartisanコマンドを追加することがあります。
追加されたコマンドは`php artisan list`で確認できます。

### AdminLTE

AdminLTEは管理画面用のテンプレートです。
`colorlibhq/adminlte-laravel`を導入すると、次のartisanコマンドが追加されます。

| コマンド                         | 用途                                                       |
| -------------------------------- | ---------------------------------------------------------- |
| `php artisan adminlte:install`   | 構成ファイル、Viteアセット、フロントエンド依存を導入します |
| `php artisan adminlte:status`    | インストール済みのリソースを表示します                     |
| `php artisan adminlte:scaffold`  | メールボックスやチャットなどの画面を生成します             |
| `php artisan adminlte:make-auth` | 認証用のコントローラとルートを生成します                   |

`adminlte:install`は`--only`でconfig、views、assets、langのいずれかを指定できます。
`adminlte:scaffold`は`--all`で全セクションをまとめて生成できます。
`adminlte:make-auth`は`--type`でplain、breeze、fortifyを選べます。

補足
-------------------------

### 共通オプション

| オプション               | 用途                               |
| ------------------------ | ---------------------------------- |
| `-h`、`--help`           | コマンドのヘルプを表示します       |
| `-q`、`--quiet`          | エラー以外の出力を抑制します       |
| `--silent`               | 出力をすべて抑制します             |
| `-n`、`--no-interaction` | 対話プロンプトを無効にします       |
| `--ansi`、`--no-ansi`    | 色付き出力を強制または無効にします |
| `-v`、`-vv`、`-vvv`      | 出力の詳細度を上げます             |

### コマンドの探し方

`php artisan list`で全コマンドを一覧表示します。
`php artisan list db`のように名前空間を指定すると、対象のコマンドだけに絞れます。
`php artisan help migrate`で特定コマンドのオプションを確認できます。

関連ドキュメント
-------------------------

- [Laravelのmakeコマンド一覧](make.md): コード生成コマンドの全体像
- [makeコマンド索引](make/index.md): カテゴリ別の生成コマンド
- [Laravel Pail](../packages/pail.md): ログ監視の詳細
- [Laravel Tinker](../packages/tinker.md): REPLの詳細
- [Laravelのテストとデータベース](test.md): テストの実行と環境変数の切り替え
- [ナレッジ目次](../index.md): 学習トピックの一覧
