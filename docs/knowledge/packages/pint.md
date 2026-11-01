Laravel Pint
=========================

概要
-------------------------

Laravel PintはLaravel公式のPHPコードフォーマッターです。
PHP CS Fixerを基にしており、Laravelのコーディングスタイルを適用します。
設定なしでも動作します。

向いている場面
-------------------------

- コードスタイルを自動で揃えたい
- CIでスタイル違反を検出したい
- 変更したファイルだけを整形したい

使い方
-------------------------

```
./vendor/bin/pint
./vendor/bin/pint --test
./vendor/bin/pint --dirty
./vendor/bin/pint --parallel
```

`--test`は変更せずに検査し、違反があれば非ゼロで終了します。
`--dirty`は未コミットのファイルだけを対象にします。
`--parallel`は実験的な並列実行です。
`--blade`でBladeテンプレートも整形できます。

設定
-------------------------

`pint.json`でプリセットとルールを指定します。
プリセットは`laravel`、`per`、`psr12`、`symfony`、`empty`から選べます。
`exclude`、`notName`、`notPath`で対象外を指定できます。

このプロジェクトでの利用
-------------------------

導入済みです。
`composer.json`の`require-dev`に`laravel/pint`が含まれています。
`./vendor/bin/pint --test`で整形のチェックができます。

公式ドキュメント
-------------------------

- [Laravel Pint](https://laravel.com/docs/13.x/pint)
