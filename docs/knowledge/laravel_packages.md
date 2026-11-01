Laravel系パッケージの整理
=========================

概要
-------------------------

`composer.json`に含まれるLaravel系パッケージと、よく見かけるLaravel公式パッケージを整理します。
名前から用途を思い出せないときの索引として使います。

このプロジェクトで直接使用しているパッケージ
--------------------------------------------

| パッケージ                    | 区分        | 用途                             |
| ----------------------------- | ----------- | -------------------------------- |
| `laravel/framework`           | require     | Laravel本体                      |
| `laravel/tinker`              | require     | 対話型REPL                       |
| `colorlibhq/adminlte-laravel` | require     | AdminLTEのLaravel連携            |
| `laravel/pail`                | require-dev | ログのリアルタイム表示           |
| `laravel/pao`                 | require-dev | テスト出力のエージェント向け整形 |
| `laravel/pint`                | require-dev | PHPコードフォーマッター          |

依存として入るLaravel系パッケージ
---------------------------------

| パッケージ                     | 用途                     |
| ------------------------------ | ------------------------ |
| `laravel/agent-detector`       | AIエージェント環境の判定 |
| `laravel/prompts`              | CLIの対話プロンプト      |
| `laravel/serializable-closure` | クロージャのシリアライズ |

よく見かけるLaravel公式パッケージ
---------------------------------

| パッケージ          | 用途                         | このプロジェクト |
| ------------------- | ---------------------------- | ---------------- |
| `laravel/sail`      | Dockerを使った開発環境       | 未使用           |
| `laravel/sanctum`   | APIトークン認証              | 未使用           |
| `laravel/fortify`   | 認証バックエンド             | 未使用           |
| `laravel/breeze`    | 認証UIの最小スキャフォールド | 未使用           |
| `laravel/jetstream` | 認証UIとチーム機能           | 未使用           |
| `laravel/socialite` | SNSログイン                  | 未使用           |
| `laravel/horizon`   | Redisキューの監視            | 未使用           |
| `laravel/reverb`    | WebSocketサーバー            | 未使用           |
| `laravel/octane`    | 高速アプリケーションサーバー | 未使用           |
| `laravel/scout`     | 全文検索                     | 未使用           |
| `laravel/cashier`   | 決済                         | 未使用           |
| `laravel/pennant`   | フィーチャーフラグ           | 未使用           |
| `laravel/pulse`     | パフォーマンス監視           | 未使用           |
| `laravel/telescope` | デバッグ支援                 | 未使用           |
| `laravel/dusk`      | ブラウザテスト               | 未使用           |
| `laravel/envoy`     | デプロイタスク               | 未使用           |
| `laravel/folio`     | ページベースのルーティング   | 未使用           |
| `laravel/nova`      | 管理画面(有償)               | 未使用           |

コマンド例
-------------------------

- `php artisan tinker`: REPLを起動します
- `php artisan pail`: ログを監視します
- `./vendor/bin/pint`: PHPコードを整形します
- `laravel/pao`は専用コマンドを持たず、テスト実行時に自動で有効になります
    - `PAO_FORCE=true`で強制、`PAO_DISABLE=true`で無効化します

説明の確認方法
-------------------------

- `composer show <パッケージ名>`: 説明・バージョン・依存関係を確認します
- `composer show`: 導入済みパッケージの一覧を確認します
- `composer require <パッケージ名>`: 本番依存として追加します
- `composer require --dev <パッケージ名>`: 開発依存として追加します
