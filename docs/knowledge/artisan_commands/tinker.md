LaravelのTinker
=========================

概要
-------------------------

`tinker`は、アプリケーションと対話するREPLを起動します。
モデルの確認、データの作成、デバッグ、一時的な処理の実行に使います。
`--execute`を付けると、REPLを起動せずにコードを1回だけ実行できます。

主なコマンド
-------------------------

| コマンド                              | 用途                                 |
| ------------------------------------- | ------------------------------------ |
| `php artisan tinker`                  | REPLを起動します                     |
| `php artisan tinker --execute="..."`  | 指定したコードを1回実行します        |
| `php artisan tinker path/to/file.php` | ファイルを読み込んでREPLを起動します |

主なオプション
-------------------------

- `include`: REPLを起動する前に読み込むファイルを引数で指定します
- `--execute[=EXECUTE]`: 指定したコードを実行します

使用例
-------------------------

### REPLを起動する

```bash
php artisan tinker
```

終了する場合は`exit`を実行するか、Ctrl-Dを押します。

### コードを1回だけ実行する

```bash
php artisan tinker --execute="echo User::count();"
```

データを作成する場合は次のように実行します。

```bash
php artisan tinker --execute="User::factory()->count(3)->create();"
```

### ファイルを読み込んで起動する

```bash
php artisan tinker path/to/bootstrap.php
```

注意点
-------------------------

- `tinker`は開発とデバッグ向けです。本番環境では慎重に使います
- `--execute`はデータを変更するコードも実行できます。実行内容を確認してから使います
- 外部から渡された文字列をそのまま`--execute`へ渡さないようにします
- `tinker`は`.env`の設定を読み込みます。対象の環境を確認してから実行します
- 本番環境で使う場合は、バックアップと影響範囲を確認します

関連ドキュメント
-------------------------

- [Laravelのartisanコマンド一覧](index.md): コマンド一覧とカテゴリー
- [Laravel Tinker](../packages/tinker.md): Tinkerの詳細
- [Laravelの初期化コマンド](initialize.md): 初期構築での実行順序
- [LaravelのDB操作コマンド](db.md): シーダーとテーブル確認
