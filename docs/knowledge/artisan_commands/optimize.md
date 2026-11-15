Laravelのキャッシュと最適化コマンド
=========================

概要
-------------------------

`optimize`系のコマンドは、設定、イベント、ルート、ビューのキャッシュを生成・削除します。
キャッシュはデプロイ時に生成し、開発中や障害時にはクリアして再生成します。
テスト前にもキャッシュをクリアして、古い設定やビューの影響を避けます。

主なコマンド
-------------------------

| コマンド                     | 用途                             |
| ---------------------------- | -------------------------------- |
| `php artisan optimize`       | キャッシュを生成します           |
| `php artisan optimize:clear` | キャッシュをまとめて削除します   |
| `php artisan config:cache`   | 設定キャッシュを生成します       |
| `php artisan config:clear`   | 設定キャッシュを削除します       |
| `php artisan route:cache`    | ルートキャッシュを生成します     |
| `php artisan route:clear`    | ルートキャッシュを削除します     |
| `php artisan view:cache`     | Bladeビューをコンパイルします    |
| `php artisan view:clear`     | コンパイル済みビューを削除します |
| `php artisan event:cache`    | イベントのキャッシュを生成します |
| `php artisan event:clear`    | イベントのキャッシュを削除します |
| `php artisan cache:clear`    | アプリキャッシュを削除します     |

利用場面
-------------------------

- デプロイ時: `optimize`で本番用のキャッシュを生成します
- デプロイ後の不具合時: `optimize:clear`で古いキャッシュをすべて削除します
- 開発時: `config:clear`、`route:clear`、`view:clear`で変更を反映します
- テスト前: `optimize:clear`でテストへのキャッシュ影響を排除します

主なオプション
-------------------------

- `--except[=EXCEPT]`: 実行しないキャッシュを指定します
- `--tags[=TAGS]`: 削除するタグを指定します
- `--locks`: ロックだけを削除します

`--except`はキーまたはコマンド名で指定します。
`--tags`と`--locks`は`cache:clear`で使います。
`--except`は`optimize`と`optimize:clear`の両方で使えます。
`--tags`はタグ対応のキャッシュストアで使います。

使用例
-------------------------

### 本番用のキャッシュを生成する

```bash
php artisan optimize
```

ビューのキャッシュだけを除外する場合は`--except=views`を指定します。

```bash
php artisan optimize --except=views
```

### キャッシュをまとめて削除する

```bash
php artisan optimize:clear
```

### 個別のキャッシュを削除する

```bash
php artisan config:clear
php artisan route:clear
php artisan view:clear
```

### アプリケーションキャッシュをタグで削除する

```bash
php artisan cache:clear --tags=posts
```

注意点
-------------------------

- `config:cache`の後に`.env`を変更しても、`config:clear`するまで反映されません
- `route:cache`はクロージャを使ったルートをキャッシュできません
- `optimize:clear`は複数のキャッシュをまとめて削除するため、本番では影響を確認します
- `cache:clear`はアプリケーションキャッシュを削除します。セッションやキューのデータは削除しません
- イベントやリスナーを変更した場合は`event:clear`でキャッシュを削除します

関連ドキュメント
-------------------------

- [Laravelのartisanコマンド一覧](index.md): コマンド一覧とカテゴリー
- [Laravelの初期化コマンド](initialize.md): 初期構築での実行順序
- [Laravelのテストとデータベース](test.md): テスト前のキャッシュクリア
