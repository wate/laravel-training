LaravelのPail
=========================

概要
-------------------------

`pail`は、アプリケーションのログをリアルタイムで表示します。
ログレベル、メッセージ、認証ユーザーなどで絞り込めます。
開発中の動作確認や、エラーの原因調査に使います。

主なコマンド
-------------------------

| コマンド                            | 用途                         |
| ----------------------------------- | ---------------------------- |
| `php artisan pail`                  | ログを表示します             |
| `php artisan pail --level=error`    | エラーログだけを表示します   |
| `php artisan pail --filter=payment` | 値を含むログだけを表示します |

主なオプション
-------------------------

- `--filter[=FILTER]`: 指定した値を含むログに絞り込みます
- `--message[=MESSAGE]`: メッセージで絞り込みます
- `--level[=LEVEL]`: ログレベルで絞り込みます
- `--auth[=AUTH]`: 認証ユーザーのIDで絞り込みます
- `--user[=USER]`: `--auth`の別名です
- `--timeout[=TIMEOUT]`: 最大実行時間を秒で指定します

使用例
-------------------------

### ログを表示する

```bash
php artisan pail
```

エラーログだけを表示する場合は`--level=error`を付けます。

```bash
php artisan pail --level=error
```

### 値を含むログに絞り込む

```bash
php artisan pail --filter=payment
```

### 実行時間を指定する

```bash
php artisan pail --timeout=600
```

注意点
-------------------------

- `pail`は開発とデバッグ向けです。本番環境の監視には専用のログ基盤を使います
- `--timeout`を過ぎると表示が停止します。続ける場合は再実行します
- ログの出力先は`config/logging.php`の設定に依存します
- 認証ユーザーで絞り込む場合は`--auth`または`--user`を使います

関連ドキュメント
-------------------------

- [Laravelのartisanコマンド一覧](index.md): コマンド一覧とカテゴリー
- [Laravel Pail](../packages/pail.md): Pailの詳細
- [Laravelの設定確認コマンド](config.md): ログ設定の確認
- [Laravelのメンテナンスモード](maintenance.md): デプロイ中のアクセス制御
