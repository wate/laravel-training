Laravel Dusk
=========================

概要
-------------------------

Laravel DuskはLaravel向けのブラウザ自動化とテストのAPIを提供します。
既定ではChromeDriverを使うため、JDKやSeleniumの導入は不要です。
公式ドキュメントでは、新規プロジェクトにはPest 4のブラウザテストを推奨しています。

向いている場面
-------------------------

- PHPだけでブラウザテストを書きたい
- Laravelの認証やデータベースをテストから直接操作したい
- Chromeでの動作確認を最小構成で行いたい

主な機能
-------------------------

- `$this->browse()`によるブラウザ操作
- `loginAs`によるログイン処理の省略
- `DatabaseTruncation`などのデータベースリセット
- `dusk`属性を使ったセレクタ
- 失敗時のスクリーンショットとコンソールログ
- ページオブジェクトとコンポーネント

導入
-------------------------

```
composer require laravel/dusk --dev
php artisan dusk:install
php artisan dusk
```

テストは`tests/Browser`に作成し、`php artisan dusk:make`で生成できます。
`php artisan dusk`はPHPUnitの引数を受け取れるため、グループ単位の実行も可能です。

Playwrightとの違い
-------------------------

| 観点        | Dusk                                   | Playwright                   |
| ----------- | -------------------------------------- | ---------------------------- |
| 言語        | PHP                                    | JavaScriptまたはTypeScript   |
| テスト実行  | `php artisan dusk`                     | `npx playwright test`        |
| ブラウザ    | Chrome(ChromeDriver)、Seleniumで他も可 | Chromium、Firefox、WebKit    |
| Laravel連携 | `loginAs`など専用のAPIがある           | なし                         |
| 主な強み    | Laravelの内部との統合                  | クロスブラウザと豊富なツール |

DuskはLaravelのテスト基盤と密接に統合されています。
Playwrightはフレームワークに依存せず、ブラウザ経由でアプリケーションを操作します。
そのためPlaywrightはLaravel以外の画面も同じ書き方でテストできます。

このプロジェクトでの利用
-------------------------

Duskは未使用です。
Playwrightの`@playwright/test`を導入し、`tests/e2e`でE2Eテストを実行しています。
E2EテストはPlaywrightで運用し、DuskはPHP側で完結させたい場合の選択肢になります。

公式ドキュメント
-------------------------

- [Laravel Dusk](https://laravel.com/docs/13.x/dusk)
- [Playwright](https://playwright.dev/docs/intro)
