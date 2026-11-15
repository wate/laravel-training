Laravel Sanctum
=========================

概要
-------------------------

Laravel SanctumはSPA、モバイルアプリ、シンプルなトークンAPI向けの軽量な認証パッケージです。
APIトークンによる認証と、Cookieを使ったSPA認証の2つを提供します。

向いている場面
-------------------------

- 自前のSPAからLaravelのAPIを呼び出す
- モバイルアプリにAPIトークンを発行する
- ユーザーごとに複数のパーソナルアクセストークンを発行する

OAuth2は提供しません。
OAuth2が必要な場合はPassportを使います。

主な機能
-------------------------

- ユーザーごとの複数トークンの発行と失効
- トークンごとのアビリティ(権限)
- トークンの有効期限設定
- SPA向けのセッションCookie認証
- モバイルアプリ向けのトークン発行

導入
-------------------------

```
php artisan install:api
```

このコマンドは`laravel/sanctum`の導入、設定ファイルの公開、マイグレーションの実行を行います。
導入後、`User`モデルに`HasApiTokens`トレイトを追加します。

使い方
-------------------------

トークンは`createToken`で発行します。
平文のトークンは`plainTextToken`で一度だけ取得できます。

```php
$token = $request->user()->createToken('device-name', ['orders:read']);
return ['token' => $token->plainTextToken];
```

保護したルートには`auth:sanctum`ミドルウェアを指定します。
アビリティの確認には`tokenCan`や`abilities`ミドルウェアを使います。

SPA認証
-------------------------

SPA認証ではトークンを使わず、LaravelのセッションCookieを利用します。
`sanctum`設定の`stateful`にフロントエンドのドメインを登録します。
`bootstrap/app.php`で`$middleware->statefulApi()`を有効にします。
ログイン前に`/sanctum/csrf-cookie`へリクエストしてCSRF保護を初期化します。

Passportとの使い分け
-------------------------

OAuth2の認可サーバーが必要な場合だけPassportを選びます。
SPA、モバイルアプリ、APIトークンの用途はSanctumで足ります。
SanctumはPassportより設定と運用が簡単です。

このプロジェクトでの利用
-------------------------

未使用です。
AdminLTEはBladeとセッション認証を前提とするため、トークンAPIを追加する場合に利用します。

公式ドキュメント
-------------------------

- [Laravel Sanctum](https://laravel.com/docs/13.x/sanctum)
