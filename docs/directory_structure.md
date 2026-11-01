ディレクトリ構造
=========================

Laravel学習用サンプルアプリケーションの主要なディレクトリとファイルの配置と役割です。

```
├ README.md                    # プロジェクトの入口
├ .devcontainer/               # 開発環境構築用の設定ファイル格納ディレクトリ
│   ├ log/                        # Ansibleのログ格納ディレクトリ
│   ├ mariadb/                    # MariaDBの設定格納ディレクトリ
│   ├ php/                        # PHPの設定格納ディレクトリ
│   └ provision/                  # プロビジョニング用のスクリプト格納ディレクトリ
├ bin/                         # 各種コマンド格納ディレクトリ
├ docs/                        # システムドキュメント格納ディレクトリ
│   └ knowledge/                  # 学習した知識の蓄積ディレクトリ
├ .agents/                     # AIエージェント用スキル定義格納ディレクトリ
│   └ skills/                     # スキル定義格納ディレクトリ
├ .github/                     # GitHub・Copilot向け設定格納ディレクトリ
│   ├ feedback/                   # 指摘・決定事項の記録ディレクトリ
│   ├ hooks/                      # エージェント用フック格納ディレクトリ
│   ├ instructions/               # インストラクション定義格納ディレクトリ
│   ├ processes/                  # 作業プロセス定義格納ディレクトリ
│   └ skills/                     # リポジトリ固有のスキル格納ディレクトリ
├ .ticket/                     # チケット管理ディレクトリ
│   ├ _archive/                   # 完了チケットの保管ディレクトリ
│   ├ _files/                     # チケット添付ファイル格納ディレクトリ
│   ├ _guide/                     # チケット運用ガイド格納ディレクトリ
│   ├ _shared/                    # 共通テンプレート格納ディレクトリ
│   ├ _template/                  # チケットテンプレート格納ディレクトリ
│   ├ bug/                        # 不具合チケット格納ディレクトリ
│   ├ idea/                       # アイデアチケット格納ディレクトリ
│   ├ request/                    # 要望チケット格納ディレクトリ
│   └ task/                       # タスクチケット格納ディレクトリ
├ .vscode/                     # エディタ設定格納ディレクトリ
├ config/                      # 設定ファイル格納ディレクトリ
├ app/                         # アプリケーションコード格納ディレクトリ
│   ├ Http/                       # HTTP処理格納ディレクトリ
│   ├ Models/                     # Eloquentモデル格納ディレクトリ
│   └ Providers/                  # サービスプロバイダ格納ディレクトリ
├ bootstrap/                   # フレームワークの起動処理格納ディレクトリ
│   └ cache/                      # 起動キャッシュ格納ディレクトリ
├ routes/                      # ルーティング定義格納ディレクトリ
├ resources/                   # Bladeビュー・CSS・JavaScript格納ディレクトリ
│   ├ css/                        # CSS格納ディレクトリ
│   ├ js/                         # JavaScript格納ディレクトリ
│   └ views/                      # Bladeテンプレート格納ディレクトリ
├ database/                    # マイグレーション・シーダー・ファクトリ格納ディレクトリ
│   ├ factories/                  # テストデータ生成格納ディレクトリ
│   ├ migrations/                 # テーブル定義格納ディレクトリ
│   └ seeders/                    # 初期データ投入格納ディレクトリ
├ tests/                       # テストコード格納ディレクトリ
│   ├ Feature/                    # 機能テスト格納ディレクトリ
│   ├ Unit/                       # 単体テスト格納ディレクトリ
│   └ e2e/                        # E2Eテスト格納ディレクトリ
├ storage/                     # ログ・キャッシュなどの生成物格納ディレクトリ
│   ├ app/                        # アプリケーションのファイル格納ディレクトリ
│   ├ framework/                  # フレームワークの生成物格納ディレクトリ
│   └ logs/                       # ログ格納ディレクトリ
├ vendor/                      # Composer依存パッケージ格納ディレクトリ
├ node_modules/                # npm依存パッケージ格納ディレクトリ
├ public/                      # 公開ディレクトリ
│   ├ build/                      # Viteのビルド成果物格納ディレクトリ
│   └ vendor/                     # AdminLTEなどの生成アセット格納ディレクトリ
├ .editorconfig                # EditorConfigの設定ファイル
├ .env.dev                     # Dev Container用の環境変数ファイル
├ .env.example                 # 環境変数のサンプル
├ .env.testing                 # テスト用の環境変数ファイル
├ .gitattributes               # Git属性設定
├ .gitignore                   # Git除外設定
├ .markdownlint.yml            # markdownlint設定
├ .npmrc                       # npm設定
├ .prettierignore              # Prettier除外設定
├ .prettierrc.yml              # Prettier設定
├ AGENTS.md                    # AIエージェント向けガイドライン
├ artisan                      # Artisanコマンド
├ composer.json                # Composer依存関係とスクリプト
├ composer.lock                # 依存バージョンの固定(Git管理外)
├ package-lock.json            # 依存バージョンの固定(Git管理外)
├ package.json                 # npm依存関係とスクリプト
├ phpunit.xml                  # PHPUnit設定
├ pint.json                    # Pint設定
├ playwright.config.js         # Playwright設定
├ skills-lock.json             # スキル定義のロックファイル
├ Taskfile.yml                 # タスクランナー設定
└ vite.config.js               # Vite設定
```
