Laravel Sail
=========================

概要
-------------------------

Laravel SailはLaravelのDocker開発環境を操作する軽量なCLIです。
`compose.yaml`と`sail`スクリプトで構成され、Dockerの知識がなくても開発環境を起動できます。
macOS、Linux、Windows(WSL2)に対応しています。

向いている場面
-------------------------

- Dockerを使った開発環境を手軽に用意したい
- PHP、MySQL、Redisをまとめて起動したい
- ローカル環境と本番環境の差異を減らしたい

主な機能
-------------------------

- `sail up`と`sail stop`によるコンテナの起動と停止
- `sail artisan`や`sail composer`など、コンテナ内コマンドの実行
- MySQL、PostgreSQL、Redis、Mailpitなどのサービス
- `sail test`によるテスト実行
- `sail share`による一時的な公開
- Devcontainer設定の出力

導入
-------------------------

```
composer require laravel/sail --dev
php artisan sail:install
./vendor/bin/sail up
```

`sail`コマンドを短く入力する場合は、シェルのエイリアスを設定します。

使い方
-------------------------

```
sail up -d
sail artisan migrate
sail npm run dev
sail test
sail stop
```

追加のサービスは`php artisan sail:add`で追加できます。
Dockerfileをカスタマイズする場合は`php artisan sail:publish`を使います。

このプロジェクトでの利用
-------------------------

未使用です。
現在はDev Containerで開発しているため、通常はSailを別途導入する必要はありません。

公式ドキュメント
-------------------------

- [Laravel Sail](https://laravel.com/docs/13.x/sail)
