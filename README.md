Laravel学習用サンプルアプリケーション
=====================================

概要
-------------------------

Laravelの習得を目的として、日常生活で継続的に使える個人向けWebアプリケーションを開発する学習用リポジトリです。
完全プライベートな用途とし、業務用途や仕事に関する機能は対象外とします。

プロジェクトの背景と目的は[プロジェクトブリーフ](docs/index.md)を参照してください。

主要機能
-------------------------

アプリケーションの機能は未確定です。
候補の比較と段階的な実装計画は[アプリ企画](docs/app_planning.md)を参照してください。

技術スタック
-------------------------

### フロントエンド

- Blade
- HTMX
- Vanilla JS
- AdminLTE 4 / Bootstrap 5.3
- Vite(Sass)

### バックエンド

- PHP 8.5(Dev Containerの実行環境。`composer.json`の制約は`^8.3`)
- Laravel 13
- MariaDB 11

### 開発・運用ツール

- Composer: 依存関係管理
- npm: フロントエンドの依存関係管理
- PHPUnit: テスト
- Pint: PHPコードの整形
- PHPStan(Larastan): PHPコードの静的解析
- Prettier: JavaScriptとCSSの整形
- markdownlint: Markdownの検査
- pre-commit: コミット時の自動チェック
- Playwright: E2Eテスト
- Docker Compose: 開発環境の構成

セットアップ手順
-------------------------

### 前提条件

次のソフトウェアが必要です。

- VS CodeとDev Containers拡張機能
- Docker

### インストール

1. リポジトリをクローンします。

    ```bash
    git clone <リポジトリのURL>
    cd <リポジトリ名>
    ```

2. VS Codeで「Reopen in Container」を実行します。

3. コンテナ起動時の自動セットアップ完了を待ちます。
    `.devcontainer/provision/post_start.sh`が次の処理を実行します。
    - 依存パッケージの導入
    - `.env`の作成(`.env.dev`からコピー)
    - アプリケーションキーの生成
    - マイグレーション
    - フロントエンドのビルド

4. `http://localhost:8080`へアクセスします。

手動でセットアップする場合は、コンテナ内で次のコマンドを実行します。

```bash
bash .devcontainer/provision/post_start.sh
```

AIエージェント環境を利用する場合は、`skills-lock.json`からスキルを復元します。

```bash
npx skills experimental_install
```

最新版へ更新する場合は`npx skills update -y`を実行します。
フックの設定はGitHub Copilot Chatで`/feedback`を入力して依頼し、VS Codeを再起動すると有効になります。

使用方法
-------------------------

### コマンドライン操作

- `composer dev`: 開発サーバー、キュー、ログ、Viteをまとめて起動します
- `composer test`: PHPUnitテストを実行します
- `npm run build`: フロントエンドを本番ビルドします
- `npm run test:e2e`: PlaywrightのE2Eテストを実行します
- `./vendor/bin/pint`: PHPコードを整形します

Viteの開発サーバーを使う場合は`npm run dev`を実行します。

プロジェクト構造
-------------------------

```
├ app/            # アプリケーションコード
├ bootstrap/      # フレームワークの起動処理
├ config/         # 設定ファイル
├ database/       # マイグレーション、シーダー、ファクトリ
├ docs/           # 学習・設計ドキュメント
├ public/         # 公開ディレクトリ(エントリポイント)
├ resources/      # Bladeビュー、CSS、JavaScript
├ routes/         # ルーティング定義
├ storage/        # ログ、キャッシュ等の生成物
├ tests/          # テストコード
├ .devcontainer/  # Dev Containerの構成
├ .ticket/        # チケット管理
├ AGENTS.md       # AIエージェント向けガイドライン
└ composer.json   # Composer依存関係とスクリプト
```

詳細は[ディレクトリ構造](docs/directory_structure.md)を参照してください。

関連ドキュメント
-------------------------

### プロジェクト概要・要件

- [プロジェクトブリーフ](docs/index.md): 目的、利用者、制約
- [アプリ企画](docs/app_planning.md): 候補の比較と実装計画

### 開発・技術

- [技術スタック](docs/technology.md): 使用技術とバージョン
- [ディレクトリ構造](docs/directory_structure.md): 主要ディレクトリの役割
- [コーディング規約](docs/code_style.md): MarkdownとPHPの規約
- [ローカル開発環境](docs/local_environment.md): Dev Containerの構成と手順
- [ナレッジ](docs/knowledge/index.md): 学習した知識の蓄積

### その他

- [AGENTS.md](AGENTS.md): AIエージェント向けガイドライン
