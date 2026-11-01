Laravel Telescope
=========================

概要
-------------------------

Laravel Telescopeはローカル開発向けのデバッグ支援ツールです。
リクエスト、例外、ログ、SQL、キュージョブ、メール、通知、キャッシュ、スケジュールを記録します。
ダッシュボードは`/telescope`で表示します。

向いている場面
-------------------------

- 発生した例外や遅いSQLを確認したい
- キュージョブやメール送信の結果を追いたい
- ローカル環境での動作をまとめて観察したい

主な機能
-------------------------

- リクエスト、例外、ログ、SQLの記録
- キュージョブ、バッチ、スケジュールの記録
- メール、通知、キャッシュ、Redisの記録
- 変数ダンプとビューの記録
- `Telescope::filter`による記録対象の絞り込み
- `Telescope::tag`による検索用タグの追加

導入
-------------------------

```
composer require laravel/telescope --dev
php artisan telescope:install
php artisan migrate
```

ローカル専用で使う場合は、`bootstrap/providers.php`から`TelescopeServiceProvider`を外します。
`AppServiceProvider`で`local`のときだけTelescopeのサービスプロバイダを登録します。
`composer.json`の`dont-discover`に`laravel/telescope`を追加します。

運用
-------------------------

`telescope:prune`を日次でスケジュールします。
既定では24時間より古い記録を削除します。
`config/telescope.php`の`enabled`で収集を停止できます。

注意
-------------------------

Telescopeは本番環境での利用を前提としていません。
本番で使う場合は`APP_ENV`を`production`にし、`viewTelescope`ゲートでアクセスを制限します。

このプロジェクトでの利用
-------------------------

未使用です。
ローカルでのデバッグが必要になった場合に、開発依存として導入します。

公式ドキュメント
-------------------------

- [Laravel Telescope](https://laravel.com/docs/13.x/telescope)
