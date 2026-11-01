Laravel Envoy
=========================

概要
-------------------------

Laravel Envoyはリモートサーバー上の定型的なタスクを実行するツールです。
Blade形式の構文で、デプロイやArtisanコマンドなどの手順を定義できます。
MacとLinuxに対応し、WindowsではWSL2を利用します。

向いている場面
-------------------------

- 複数のサーバーで同じコマンドを実行する
- デプロイ手順をコマンド1つにまとめる
- デプロイ後のキュー再起動などを自動化する

主な機能
-------------------------

- `@servers`と`@task`によるタスク定義
- 複数サーバーへの実行と`parallel`による並列実行
- `@story`による複数タスクのまとめ
- `run`コマンドでの変数の受け渡し
- `@before`や`@finished`などのフック
- Slack、Discord、Telegram、Microsoft Teamsへの通知

導入
-------------------------

```
composer require laravel/envoy --dev
```

実行ファイルは`vendor/bin/envoy`に配置されます。
プロジェクト直下に`Envoy.blade.php`を作成し、タスクを定義します。

使い方
-------------------------

```blade
@servers(['web' => ['user@192.168.1.1']])

@task('deploy', ['on' => 'web'])
    cd /home/user/example.com
    git pull origin main
    php artisan migrate --force
@endtask
```

タスクは`php vendor/bin/envoy run deploy`で実行します。
変数を渡す場合は`--branch=main`のように指定し、`{{ $branch }}`で参照します。

注意
-------------------------

EnvoyはLaravelアプリケーションに組み込むライブラリではなく、独立したCLIツールです。
破壊的な操作には`confirm => true`を付けて確認を求められます。

このプロジェクトでの利用
-------------------------

未使用です。
デプロイ先が増えた場合や、手作業のコマンドを減らしたい場合に利用します。

参考
-------------------------

- [Deployer](https://deployer.org/): PHP製のデプロイツールで、リリース管理とロールバックを提供します
- `deployer/deployer`: DeployerのComposerパッケージ名です
- [Laravel Envoyer](https://envoyer.io/): Laravel公式の有料デプロイサービスで、Envoyパッケージとは別の製品です

公式ドキュメント
-------------------------

- [Laravel Envoy](https://laravel.com/docs/13.x/envoy)
