Laravelのテストとデータベース
=========================

テストの実行
-------------------------

`php artisan test`でテストを実行します。
テストコードは`tests/Feature`と`tests/Unit`に置きます。

```bash
php artisan test
```

### 主なオプション

| オプション          | 用途                                 |
| ------------------- | ------------------------------------ |
| `--filter=<name>`   | 名前に一致するテストだけを実行します |
| `--stop-on-failure` | 最初の失敗で実行を止めます           |
| `--profile`         | 実行時間の長いテストを表示します     |
| `--coverage`        | カバレッジを計測します               |
| `--env=<name>`      | 実行する環境を指定します             |

`--coverage`はXdebugまたはPCOVが必要です。
`--parallel`を利用する場合は`brianium/paratest`が必要です。
`--env`はすべてのArtisanコマンドで使える共通オプションです。

データベースを使うテスト
-------------------------

DBを使うテストでは、テストクラスに`Illuminate\Foundation\Testing\RefreshDatabase`トレイトを追加します。
テスト開始時にマイグレーションが実行され、各テストの変更はロールバックされます。

テスト環境の切り替え
-------------------------

`php artisan test`を実行すると、自動でテスト用の環境に切り替わります。
`--env=testing`を指定する必要はありません。
自動で切り替わるのは、[phpunit.xml](../../phpunit.xml)に`APP_ENV=testing`が定義されているためです。
PHPUnitはこの値をテストプロセスに設定し、Laravelは`APP_ENV`に対応する`.env.testing`を読み込みます。
`phpunit.xml`から`APP_ENV=testing`を外すと、自動ではテスト用の環境になりません。
`.env`が読み込まれ、環境は`.env`の`APP_ENV`の値になります。

### 環境変数の読み込み

Laravelは`APP_ENV`の値に対応する`.env.{APP_ENV}`を探して読み込みます。

- `APP_ENV=testing`の場合は`.env.testing`を使います
- `APP_ENV=staging`の場合は`.env.staging`を使います

テスト実行時は`.env`ではなく`.env.testing`が読み込まれるため、`.env.testing`には`APP_KEY`など必要な値を一式記載します。
読み込み処理は`Illuminate\Foundation\Bootstrap\LoadEnvironmentVariables`にあります。
テスト以外のArtisanコマンドをテスト環境で実行する場合は`--env=testing`を指定します。

### テスト用DBの接続設定

`phpunit.xml`に`DB_*`を書くとそちらの値が優先されます。
このプロジェクトではテスト用DBを[.env.testing](../../.env.testing)で管理しています。
具体的な設定例は[.env.testing](../../.env.testing)を参照してください。
`.env.testing`が無い場合も`APP_ENV`は`testing`のままです。
ただし環境変数は`.env`から読み込まれるため、テストが開発用DBへ接続する可能性があります。
`.env`も無い場合は環境ファイルを読み込まず、`phpunit.xml`の`<env>`と設定の既定値が使われます。

関連ドキュメント
-------------------------

- [Testing: Getting Started](https://laravel.com/docs/13.x/testing): Laravel公式のテストと`.env.testing`の説明
- [ローカル開発環境](../local_environment.md): Dev Containerの構築手順とDB構成
