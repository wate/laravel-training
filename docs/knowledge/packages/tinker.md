Laravel Tinker
=========================

概要
-------------------------

Laravel TinkerはLaravelアプリケーションを対話的に操作するREPLです。
内部ではPsySHを利用しています。
Eloquentモデル、ジョブ、イベントなどをコマンドラインから実行できます。

向いている場面
-------------------------

- モデルのデータをその場で確認したい
- ジョブやイベントを手動で実行したい
- ちょっとしたコードをすぐに試したい

使い方
-------------------------

```
php artisan tinker
```

Tinker内では`User::first()`などのPHPコードを実行できます。
設定ファイルは`vendor:publish`で公開できます。

設定
-------------------------

- `tinker.php`の`commands`で許可するArtisanコマンドを追加します
- 既定では`clear-compiled`、`down`、`env`、`inspire`、`migrate`、`migrate:install`、`up`、`optimize`が許可されています
- `dont_alias`で自動エイリアスを禁止するクラスを指定します

注意
-------------------------

`dispatch`ヘルパーはガベージコレクションに依存するため、Tinkerでは`Bus::dispatch`または`Queue::push`を使います。

このプロジェクトでの利用
-------------------------

導入済みです。
`composer.json`の`require`に`laravel/tinker`が含まれています。

公式ドキュメント
-------------------------

- [Tinker](https://laravel.com/docs/13.x/artisan#tinker)
