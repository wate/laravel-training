AdminLTEのartisanコマンド
=========================

概要
-------------------------

`colorlibhq/adminlte-laravel`を導入すると、AdminLTE 4用のartisanコマンドが追加されます。
構成ファイル、Viteアセット、管理画面のひな形を生成できます。
Laravel本体のコマンドではなく、サードパーティーパッケージのコマンドです。

主なコマンド
-------------------------

- `php artisan adminlte:install`: 構成ファイルとアセットを導入します
- `php artisan adminlte:status`: インストール済みのリソースを表示します
- `php artisan adminlte:scaffold`: 管理画面のセクションを生成します
- `php artisan adminlte:make-auth`: 認証用の画面を生成します

主なオプション
-------------------------

`adminlte:install`の主なオプションです。

- `--only[=ONLY]`: `config`、`views`、`assets`、`lang`のいずれかを指定します
- `--force`: 既存ファイルを上書きします
- `--no-interaction-deps`: `npm install`の確認をスキップします

`adminlte:scaffold`の主なオプションです。

- `section`: `mailbox`、`chat`、`kanban`などのセクションを引数で指定します
- `--all`: すべてのセクションを生成します
- `--force`: 既存ファイルを上書きします
- `--seed`: 生成後にシーダーを実行します

`adminlte:make-auth`の主なオプションです。

- `--type[=TYPE]`: `plain`、`breeze`、`fortify`のいずれかを指定します
- `--force`: 既存ファイルを上書きします

使用例
-------------------------

### 構成ファイルとアセットを導入する

```bash
php artisan adminlte:install
```

ビューだけを導入する場合は`--only=views`を指定します。

```bash
php artisan adminlte:install --only=views
```

### インストール状態を確認する

```bash
php artisan adminlte:status
```

### 管理画面のセクションを生成する

```bash
php artisan adminlte:scaffold mailbox
```

すべてのセクションを生成する場合は`--all`を使います。

```bash
php artisan adminlte:scaffold --all --seed
```

### 認証用のコントローラとルートを生成する

```bash
php artisan adminlte:make-auth --type=breeze
```

注意点
-------------------------

- AdminLTEのコマンドは、パッケージを導入したプロジェクトだけで使えます
- `--force`は既存ファイルを上書きします。実行前に差分を確認します
- `adminlte:scaffold`はDBを伴うセクションを生成します。マイグレーションとシーダーを確認します
- `adminlte:make-auth`の`--type`は、既存の認証構成に合わせて選びます
- コマンドの一覧は`php artisan list adminlte`で確認できます

関連ドキュメント
-------------------------

- [Laravelのartisanコマンド一覧](index.md): コマンド一覧とカテゴリー
- [Laravelのパッケージ](../laravel_packages.md): パッケージの分類と公式ページ
- [Laravelプロジェクトのセットアップ](../laravel_project_setup.md): プロジェクト作成から初期設定まで
