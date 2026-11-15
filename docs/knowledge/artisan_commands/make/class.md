Laravelのmake:class
=========================

概要
-------------------------

`make:class`は汎用のPHPクラスを生成します。
基底クラスやインターフェースを実装しない、素のクラスです。
専用の生成コマンドがないクラスを作るときに使います。

生成物と生成先
-------------------------

| 生成物     | 生成先           |
| ---------- | ---------------- |
| 汎用クラス | `app/<Name>.php` |

名前空間は`App`です。
`Services/PostService`のようにサブディレクトリを指定すると、`app/Services/PostService.php`に`App\Services`名前空間で生成されます。

オプション
-------------------------

| オプション    | 短縮 | 用途                                         |
| ------------- | ---- | -------------------------------------------- |
| `--invokable` | `-i` | `__invoke()`を持つ単一実行クラスを生成します |
| `--force`     | `-f` | 同名ファイルを上書きします                   |

生成内容
-------------------------

`php artisan make:class PostService`は次の形を生成します。

```php
namespace App;

class PostService
{
    public function __construct()
    {
        //
    }
}
```

`--invokable`を付けると`__invoke()`も生成されます。

```php
namespace App;

class PublishPost
{
    public function __construct()
    {
        //
    }

    public function __invoke(): void
    {
        //
    }
}
```

使いどころ
-------------------------

- サービスやアクション
- 値オブジェクト
- 戦略や計算クラス
- 変換処理やヘルパー

`--invokable`は1つの処理だけを持つアクションに向いています。
コントローラから呼ぶ場合も、コンストラクタインジェクションで依存関係を渡せます。

専用コマンドとの使い分け
-------------------------

モデル、コントローラ、FormRequest、ジョブ、イベントなど、専用の生成コマンドがあるものはそれぞれのコマンドを使います。
`make:class`は、それ以外のクラスの受け皿です。

- モデル: `make:model`
- コントローラ: `make:controller`
- FormRequest: `make:request`
- ジョブ: `make:job`
- イベント: `make:event`
- コマンド: `make:command`
- 例外: `make:exception`
- サービスプロバイダ: `make:provider`

注意点
-------------------------

- 1つのクラスに複数の責務を持たせません
- 値オブジェクトは`readonly`や不変性を検討します
- 専用コマンドがあるクラスに`make:class`を使いません
- インターフェースに依存する場合はサービスプロバイダでバインドします
- クラスの登録は不要です。必要に応じてコンテナが解決します

関連ドキュメント
-------------------------

- [makeコマンド索引](index.md)
- [make:command](command.md)
- [make:exception](exception.md)
- [make:provider](provider.md)
- [その他のmakeコマンド](others.md)
