Laravel Pail
=========================

概要
-------------------------

Laravel Pailはアプリケーションのログをリアルタイムで表示するパッケージです。
標準の`tail`コマンドと違い、SentryやFlareなどのログドライバにも対応します。
PCNTL拡張が必要です。

向いている場面
-------------------------

- 開発中にログを流し見したい
- 特定の例外やエラーレベルだけを確認したい
- 特定ユーザーのログを追いたい

使い方
-------------------------

```
php artisan pail
php artisan pail -v
php artisan pail -vv
```

`-v`で省略を減らし、`-vv`で例外のスタックトレースを表示します。
停止するときは`Ctrl+C`を押します。

フィルタ
-------------------------

- `--filter="QueryException"`: 種類、ファイル、メッセージ、スタックトレースで絞り込みます
- `--message="User created"`: メッセージで絞り込みます
- `--level=error`: ログレベルで絞り込みます
- `--user=1`: 認証済みユーザーIDで絞り込みます

このプロジェクトでの利用
-------------------------

導入済みです。
`composer.json`の`require-dev`に`laravel/pail`が含まれています。
`composer dev`では`php artisan pail --timeout=0`が起動します。

公式ドキュメント
-------------------------

- [Pail](https://laravel.com/docs/13.x/logging#tailing-log-messages-using-pail)
