Laravel Precognition
=========================

概要
-------------------------

Laravel Precognitionは、送信前のHTTPリクエストの検証結果を事前に取得する仕組みです。
バックエンドのバリデーションルールをフロントエンドで重複させずに、リアルタイム検証を実現します。
プリコグニティブリクエストでは、ルートのミドルウェアとFormRequestの検証は実行されますが、コントローラのメソッドは実行されません。
Laravel 13ではサーバー側の機能が本体に含まれており、独立したComposerパッケージの導入は不要です。

向いている場面
-------------------------

- 入力中にバリデーション結果を表示したい
- フロントエンドとバックエンドで検証ルールを二重管理したくない
- ウィザード形式のフォームで各ステップを検証したい

主な機能
-------------------------

- `HandlePrecognitiveRequests`ミドルウェアによる有効化
- Vue、React、Alpine向けの公式ヘルパー
- 入力変更時のデバウンス付き検証リクエスト
- `only`による検証対象フィールドの限定
- 配列とネストした項目のワイルドカード検証
- `isPrecognitive()`による検証ルールの切り替え

使い方
-------------------------

ルートにミドルウェアを追加し、検証ルールはFormRequestに置きます。

```php
use Illuminate\Foundation\Http\Middleware\HandlePrecognitiveRequests;

Route::post('/users', function (StoreUserRequest $request) {
    // ...
})->middleware([HandlePrecognitiveRequests::class]);
```

フロントエンドでは公式ヘルパーの`useForm`または`$form`を使います。
Alpineの場合は次のパッケージを導入します。

```
npm install laravel-precognition-alpine
```

入力の変更時に`validate`を呼ぶと、検証リクエストが送信されます。
`valid`、`invalid`、`errors`、`validating`などの状態を画面に反映できます。

注意
-------------------------

ファイルは既定ではプリコグニティブリクエストで送信されません。
送信が必要な場合は`validateFiles`を呼びます。
副作用のあるミドルウェアでは`isPrecognitive()`を確認します。

このプロジェクトでの利用
-------------------------

未使用です。
現在はBlade、HTMX、Vanilla JSの構成で、公式ヘルパーはAlpine、Vue、React向けです。
導入する場合は、FormRequestとミドルウェアを整え、HTMXから手動でリクエストする形になります。

公式ドキュメント
-------------------------

- [Precognition](https://laravel.com/docs/13.x/precognition)
