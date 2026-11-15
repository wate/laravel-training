その他のartisanコマンド
=========================

概要
-------------------------

このページは、使用頻度が低いartisanコマンドをまとめたものです。
このページは低頻度コマンドの一部をまとめたもので、すべてを網羅していません。
全コマンドは`php artisan list`で確認してください。
各コマンドの詳細は`php artisan help <command>`で確認できます。
開発サーバー、環境確認、イベント確認、スキーマダンプ、stub公開などを扱います。

主なコマンド
-------------------------

| コマンド                   | 用途                                       |
| -------------------------- | ------------------------------------------ |
| `php artisan serve`        | 開発サーバーを起動します                   |
| `php artisan dev`          | 開発用のプロセスをまとめて起動します       |
| `php artisan dev:list`     | `dev`が起動するプロセスの一覧を表示します  |
| `php artisan env`          | 現在の環境名を表示します                   |
| `php artisan event:list`   | イベントとリスナーの対応を一覧表示します   |
| `php artisan channel:list` | ブロードキャストチャンネルを一覧表示します |
| `php artisan schema:dump`  | 現在のDBスキーマをダンプします             |
| `php artisan stub:publish` | `make:*`用のstubを公開します               |

主なオプション
-------------------------

共通オプション以外に、このページで扱う専用オプションはありません。
各コマンドのオプションは`php artisan help <command>`で確認してください。

使用例
-------------------------

### 開発サーバーを起動する

```bash
php artisan serve
```

### 開発用プロセスをまとめて起動する

```bash
php artisan dev
```

### 現在の環境名を確認する

```bash
php artisan env
```

### イベントとチャンネルを確認する

```bash
php artisan event:list
php artisan channel:list
```

### DBスキーマをダンプする

```bash
php artisan schema:dump
```

### stubを公開する

```bash
php artisan stub:publish
```

注意点
-------------------------

- `serve`と`dev`は開発用です。本番環境ではWebサーバーとプロセスマネージャーを使います
- `dev`はサーバー、キュー、Viteをまとめて起動します。`composer dev`から呼び出されます
- `event:list`と`channel:list`は情報を表示するだけで、設定を変更しません
- `schema:dump`はスキーマファイルを作成します。マイグレーションの代替ではありません
- `stub:publish`は`make:*`用のstubを`stubs/`へ公開します
- 生成コードをカスタマイズしたい場合だけ`stub:publish`を実行します
- `stub:publish --force`は既存のstubを上書きします。実行前に差分を確認します
- 公開したstubはアプリ側の管理になり、Laravel更新時に差分を確認します
- 各コマンドのオプションはLaravelのバージョンで変わる場合があります

関連ドキュメント
-------------------------

- [Laravelのartisanコマンド一覧](index.md): コマンド一覧とカテゴリー
- [Laravelの初期化コマンド](initialize.md): 初期構築での実行順序
- [Laravelのキャッシュと最適化コマンド](optimize.md): キャッシュの生成と削除
- [Laravelのmakeコマンド一覧](make.md): makeコマンドの全体像とstubの使い分け
- [Laravelプロジェクトのセットアップ](../laravel_project_setup.md): プロジェクト作成から初期設定まで
