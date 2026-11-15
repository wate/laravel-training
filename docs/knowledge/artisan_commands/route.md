Laravelのルート確認コマンド
=========================

概要
-------------------------

`route:list`は、アプリケーションに登録されたルートを一覧表示します。
メソッド、名前、パス、ミドルウェアなどで絞り込めます。
ルートキャッシュの生成と削除は`optimize.md`で扱います。

主なコマンド
-------------------------

| コマンド                                | 用途                         |
| --------------------------------------- | ---------------------------- |
| `php artisan route:list`                | ルートを一覧表示します       |
| `php artisan route:list --path=api`     | パスで絞り込みます           |
| `php artisan route:list --name=users`   | 名前で絞り込みます           |
| `php artisan route:list --method=GET`   | HTTPメソッドで絞り込みます   |

主なオプション
-------------------------

- `--json`: ルート一覧をJSONで出力します
- `--method[=METHOD]`: HTTPメソッドで絞り込みます
- `--action[=ACTION]`: アクションで絞り込みます
- `--name[=NAME]`: ルート名で絞り込みます
- `--domain[=DOMAIN]`: ドメインで絞り込みます
- `--middleware[=MIDDLEWARE]`: ミドルウェアで絞り込みます
- `--path[=PATH]`: パスのパターンで絞り込みます
- `--except-path[=EXCEPT-PATH]`: 指定したパスを除外します
- `--sort[=SORT]`: 並び替える列を指定します
- `--reverse`: 並び順を逆にします
- `--except-vendor`: ベンダーパッケージのルートを除外します
- `--only-vendor`: ベンダーパッケージのルートだけを表示します

使用例
-------------------------

### ルート一覧を表示する

```bash
php artisan route:list
```

ベンダーパッケージのルートを除外する場合は`--except-vendor`を付けます。

```bash
php artisan route:list --except-vendor
```

### パスや名前で絞り込む

```bash
php artisan route:list --path=api
php artisan route:list --name=users
```

### HTTPメソッドで絞り込む

```bash
php artisan route:list --method=POST
```

### JSONで出力する

```bash
php artisan route:list --json
```

注意点
-------------------------

- ルートを変更した後は`route:list`で登録内容を確認します
- ルートキャッシュを使っている場合は、変更後に`route:clear`で削除します
- `--except-vendor`はフレームワークやパッケージのルートを除外する場合に使います
- `route:list`はルートを実行せず、登録内容を表示するだけです

関連ドキュメント
-------------------------

- [Laravelのartisanコマンド一覧](index.md): コマンド一覧とカテゴリー
- [Laravelのキャッシュと最適化コマンド](optimize.md): ルートキャッシュの生成と削除
- [Laravelの設定確認コマンド](config.md): 設定値の確認
