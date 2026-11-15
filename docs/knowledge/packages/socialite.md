Laravel Socialite
=========================

概要
-------------------------

Laravel SocialiteはOAuthプロバイダーを使ったソーシャルログインを提供します。
Facebook、X、LinkedIn、Google、GitHub、GitLab、Bitbucket、Slackに対応しています。

向いている場面
-------------------------

- 外部サービスのアカウントでログインさせたい
- 既存のユーザー登録に加えてソーシャルログインを用意したい
- 外部サービスのアクセストークンを取得したい

主な機能
-------------------------

- `redirect`と`user`による認可コードフロー
- スコープの追加と上書き
- `stateless`によるセッションを使わない認証
- トークンからのユーザー情報取得
- テスト用の`fake`メソッド

導入
-------------------------

```
composer require laravel/socialite
```

`config/services.php`にプロバイダーのクライアントID、シークレット、コールバックURLを設定します。

使い方
-------------------------

リダイレクト用とコールバック用の2つのルートを用意します。

```php
Route::get('/auth/redirect', function () {
    return Socialite::driver('github')->redirect();
});

Route::get('/auth/callback', function () {
    $githubUser = Socialite::driver('github')->user();
});
```

取得したユーザー情報で`User`を作成し、`Auth::login`でログインさせます。

対応プロバイダー
-------------------------

公式対応はFacebook、X、LinkedIn、Google、GitHub、GitLab、Bitbucket、Slackです。
それ以外のプロバイダーはコミュニティのSocialite Providersを利用します。

このプロジェクトでの利用
-------------------------

未使用です。
個人利用のアプリでは必須ではありませんが、外部アカウントでのログインを追加する場合に利用します。

公式ドキュメント
-------------------------

- [Laravel Socialite](https://laravel.com/docs/13.x/socialite)
- [Socialite Providers](https://socialiteproviders.com/)
