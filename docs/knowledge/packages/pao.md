Laravel PAO
=========================

概要
-------------------------

Laravel PAOはAIエージェント向けにPHPツールの出力を整形するパッケージです。
PHPUnit、Pest、Paratest、PHPStan、Rector、Artisanの出力を検出して変換します。
AIエージェント環境ではJSONなどの簡潔な形式で出力します。

向いている場面
-------------------------

- AIエージェントにテスト結果を渡すときのトークンを減らしたい
- PHPStanやRectorの出力を構造化したい
- Artisanコマンドの装飾を減らしたい

主な機能
-------------------------

- PHPUnitとPestの結果をJSONに変換
- PHPStanとRectorの結果をJSONに変換
- Artisan出力からANSI色や罫線を除去
- AIエージェント環境の自動検出
- `PAO_FORCE=true`による強制有効化

導入
-------------------------

```
composer require laravel/pao --dev
```

サービスプロバイダは自動登録されます。
PHP 8.3以上とLaravel 12以上が必要です。

設定
-------------------------

- `PAO_FORCE=true`: エージェント検出なしで有効化します
- `PAO_DISABLE=true`: 無効化します
- Dockerでは`AI_AGENT`、`CLAUDECODE`、`CURSOR_AGENT`を転送します

このプロジェクトでの利用
-------------------------

導入済みです。
`composer.json`の`require-dev`に`laravel/pao`が含まれています。

公式ドキュメント
-------------------------

- [Laravel PAO](https://github.com/laravel/pao)
