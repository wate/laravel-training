技術スタック
=========================

概要
-------------------------

このドキュメントではLaravel学習用サンプルアプリケーションで使用している主要な技術スタックについて説明します。
開発や運用に関わるメンバーは、このドキュメントを参照して技術環境の理解を深めてください。
ここに記載した要件を満たす環境であれば動作します。
開発環境の例としてDev Containerを用意しています。

設定ファイル別技術構成
-------------------------

### `composer.json`(PHPバックエンド)

- PHP: `^8.3`(動作確認は8.5)
- フレームワーク: `laravel/framework ^13.17`
- 主要ライブラリ
    - `laravel/tinker ^3.0`: 対話型REPL
    - `colorlibhq/adminlte-laravel ^1.7`: AdminLTEのLaravel連携
- 開発依存関係
    - `phpunit/phpunit ^12.5.12`: テストフレームワーク
    - `mockery/mockery ^1.6`: テスト用モック
    - `fakerphp/faker ^1.23`: テストデータ生成
    - `nunomaduro/collision ^8.6`: CLI向けエラー表示
    - `laravel/pint ^1.27`: PHPコードフォーマッター
    - `laravel/pail ^1.2.5`: ログのリアルタイム表示
    - `laravel/pao ^1.0.6`: テストツール向けのエージェント最適化出力

### `package.json`(フロントエンド・JavaScript)

- Node.js: 24(`engines`の指定はない)
- パッケージマネージャー: npm(`.npmrc`あり)
- 主要ライブラリ
    - `@laravel/multiplex ^0.4.1`: 任意依存(`optionalDependencies`)
- ビルドツール
    - `vite ^8.0.0`: アセットのビルド
    - `laravel-vite-plugin ^3.1`: LaravelとViteの連携
- 開発依存関係
    - `admin-lte ^4.8`: UIフレームワーク
    - `bootstrap ^5.3`: CSSフレームワーク
    - `@popperjs/core ^2.11`: Bootstrapの依存
    - `overlayscrollbars ^2.16`: サイドバーのスクロール
    - `bootstrap-icons ^1.13`: アイコン
    - `chart.js ^4.5`: グラフ
    - `jsvectormap ^1.7`: 地図
    - `fullcalendar ^6.1`: カレンダー
    - `sortablejs ^1.15`: 並べ替え
    - `sass ^1.102`: SCSSビルド
    - `htmx.org ^2.0`: 部分更新
    - `concurrently ^10.0.3`: 複数コマンドの同時実行
    - `@playwright/test ^1.64`: E2Eテスト
    - `prettier ^3.9.10`: コードフォーマッター
    - `markdownlint-cli ^0.50.0`: MarkdownのLint
    - `npm-check-updates ^23.1.1`: 依存パッケージの更新確認

技術スタック分類
-------------------------

### バックエンド

- 言語: `PHP ^8.3`(動作確認は8.5)
- フレームワーク: `Laravel ^13.17`
- データベース: `MariaDB 11`またはMySQL互換のデータベース
    - 開発用は`app_dev`、テスト用は`app_test`を使う
    - 接続情報は`.env.dev`と`.env.testing`で管理する
- Webサーバー: `Apache`互換のWebサーバー
    - ドキュメントルートは`public/`にする
- 必要なPHP拡張: `mysqli`・`pdo_mysql`・`intl`・`zip`・`gd`・`imagick`
- 主要ライブラリ
    - `laravel/tinker`: 対話型REPL
    - `colorlibhq/adminlte-laravel`: AdminLTEのアセット導入
- 静的解析・品質ツール
    - `laravel/pint`: コードフォーマッター
    - 静的解析ツールの設定ファイルは確認できない(要確認)
- テストフレームワーク: `PHPUnit ^12.5.12`(`mockery/mockery`を併用)

### フロントエンド

- 言語: `JavaScript`(`resources/js/app.js`)
- テンプレートエンジン: `Blade`
- フレームワーク: `HTMX` + `Vanilla JS`
- 主要ライブラリ
    - `admin-lte ^4.8`: UIフレームワーク
    - `bootstrap ^5.3`: CSSフレームワーク
    - `htmx.org ^2.0`: 部分更新
    - `laravel-vite-plugin ^3.1`: LaravelとViteの連携
- ビルドツール: `Vite ^8.0.0`
- フォント: Bunny Fontsの`Instrument Sans`(`vite.config.js`で読み込み)
- テストフレームワーク: `@playwright/test ^1.64`
- 設計方針
    - LaravelのMVC構成を基本とし、HTMLはBladeで生成する
    - ビジネスロジックとDB処理はLaravel側に集約する
    - 画面の部分更新と非同期通信にはHTMXを使う
    - JSON APIを必須とせず、HTML断片を返すサーバーサイド中心の設計にする
    - UIはAdminLTE 4とBootstrap 5.3を使い、Tailwind CSSは採用しない
    - 補完が必要な箇所だけVanilla JSで実装する

### 開発ツール

- タスクランナー: Composer scripts(`dev`・`test`)、npm scripts(`dev`・`build`・`test:e2e`)
- ドキュメント生成: なし
- コードフォーマッター: `laravel/pint`(PHP)、`Prettier`(JavaScript・CSS)

バージョン管理ポリシー
-------------------------

### メジャーバージョンアップ

- 判断基準: 要確認(方針の記載なし)
- 検証手順: 要確認
- 影響範囲評価: 要確認

### セキュリティアップデート

- 適用タイミング: 要確認
- 検証手順: 要確認
- 緊急時対応: 要確認

### 依存関係管理

- 互換性確保: `composer.json`で`minimum-stability: stable`、`prefer-stable: true`、`sort-packages: true`
- 定期的な更新: 要確認(`composer.lock`と`package-lock.json`はGit管理外)
- 脆弱性監視: `.npmrc`で`audit=true`、その他の方針は要確認
