Laravelの設定確認コマンド
=========================

概要
-------------------------

`config:show`は、指定した設定ファイルまたはキーの値を表示します。
設定キャッシュの生成と削除は`optimize.md`で扱います。
`config:show`は設定値の確認にだけ使います。

主なコマンド
-------------------------

| コマンド                           | 用途                               |
| ---------------------------------- | ---------------------------------- |
| `php artisan config:show <config>` | 設定ファイルまたはキーを表示します |
| `php artisan config:show app`      | `config/app.php`の値を表示します   |
| `php artisan config:show app.name` | 特定のキーを表示します             |

`app.name`のようにドット区切りでキーを指定できます。

主なオプション
-------------------------

専用のオプションはありません。
`--env`で対象の環境を指定できます。

使用例
-------------------------

### 設定ファイル全体を表示する

```bash
php artisan config:show app
```

### 特定のキーを表示する

```bash
php artisan config:show app.name
```

### ネストした設定を表示する

```bash
php artisan config:show database.connections.mysql
```

### 環境を指定する

```bash
php artisan config:show app --env=production
```

注意点
-------------------------

- `config:show`は`.env`の値や認証情報を表示する場合があります
- 表示結果を共有するときは、秘密情報が含まれていないか確認します
- `config:cache`の後に`.env`を変更しても、`config:clear`するまで反映されません
- 設定キャッシュの生成と削除は[キャッシュと最適化](optimize.md)を参照してください

関連ドキュメント
-------------------------

- [Laravelのartisanコマンド一覧](index.md): コマンド一覧とカテゴリー
- [Laravelのキャッシュと最適化コマンド](optimize.md): 設定キャッシュの生成と削除
- [Laravelの初期化コマンド](initialize.md): 初期構築での実行順序
