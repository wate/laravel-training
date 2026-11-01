Laravelのテストとデータベース
=============================

テストの実行
-------------------------

[phpunit.xml](../../phpunit.xml)はプロジェクト直下にあるPHPUnitの設定ファイルです。
`php artisan test`を実行すると、`phpunit.xml`の`APP_ENV=testing`により[.env.testing](../../.env.testing)が使われます。
テスト環境を指定してArtisanコマンドを実行する場合は`--env=testing`を指定します。

```bash
php artisan test
```

仕組み
-------------------------

Laravelは`APP_ENV`の値に対応する`.env.{APP_ENV}`を探して読み込みます。

- `phpunit.xml`は`APP_ENV=testing`を設定します
- テスト実行時は`.env.testing`が使われます
- `APP_ENV=staging`の場合は`.env.staging`が使われます

`.env`は読み込まれないため、`.env.testing`には`APP_KEY`など必要な値を一式記載します。
読み込み処理は`Illuminate\Foundation\Bootstrap\LoadEnvironmentVariables`にあります。
`phpunit.xml`に`DB_*`の設定があるとそちらが優先されるため、
テスト用DBは[.env.testing](../../.env.testing)で管理します。
具体的な設定例は[phpunit.xml](../../phpunit.xml)を参照してください。

テスト用DBの準備
-------------------------

DBを使うテストでは、テストクラスに`Illuminate\Foundation\Testing\RefreshDatabase`トレイトを追加します。
テスト開始時にマイグレーションが実行され、各テストの変更はロールバックされます。

関連ドキュメント
-------------------------

- [Testing: Getting Started](https://laravel.com/docs/13.x/testing): Laravel公式のテストと`.env.testing`の説明
- [ローカル開発環境](../local_environment.md): Dev Containerの構築手順とDB構成
