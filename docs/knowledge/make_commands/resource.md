Laravelのmake:resource
=========================

概要
-------------------------

`make:resource`はAPIリソースクラスを生成します。
APIリソースは、EloquentモデルをJSONへ変換するときの形を定義するクラスです。
REST APIを追加するときに、返す項目やリレーションを制御するために使います。

REST API追加時の位置づけ
-------------------------

REST APIを追加するときは、次の役割に分けます。

| 役割           | 担当                 |
| -------------- | -------------------- |
| ルーティング   | `routes/api.php`など |
| リクエスト処理 | コントローラ         |
| 入力検証       | FormRequest          |
| JSON整形       | APIリソース          |
| 認証           | Sanctumなど          |
| 認可           | ポリシーやGate       |

`make:resource`はJSON整形だけを担当します。
ルート、コントローラ、FormRequest、認証、認可は別途用意します。

単純なAPIとの違い
-------------------------

モデルをそのまま返すだけなら、APIリソースは必須ではありません。

```php
return Post::findOrFail($id);
```

次のような制限や整形が必要になったときにAPIリソースを使います。

- 外部へ出す項目を限定する
- 機密情報や内部フラグを隠す
- リレーションを条件付きで含める
- ページネーションの`meta`と`links`を整える
- JSONの形を複数のエンドポイントで統一する

制限の種類と担当
-------------------------

| 制限                         | 担当                       |
| ---------------------------- | -------------------------- |
| 出力する項目を限定する       | APIリソース                |
| リレーションを条件付きで出す | APIリソース                |
| 入力値を検証する             | FormRequest                |
| 操作権限を判定する           | ポリシーやGate             |
| 認証を必須にする             | Sanctumなどの認証          |
| リクエスト回数を制限する     | `throttle`ミドルウェア     |
| 一覧を自分のデータに限定する | クエリのスコープやポリシー |

APIリソースは出力の整形を担当します。
認可や入力検証をAPIリソースだけで済ませないでください。

`make:controller --resource`との違い
------------------------------------

| コマンド                     | 生成物       | 役割               |
| ---------------------------- | ------------ | ------------------ |
| `make:controller --resource` | コントローラ | CRUDの処理を書く   |
| `make:resource`              | APIリソース  | JSONの形を定義する |

名前は似ていますが別物です。
コントローラの中で`PostResource::make($post)`のように使います。

生成物と生成先
-------------------------

| 生成物      | 生成先                          |
| ----------- | ------------------------------- |
| APIリソース | `app/Http/Resources/<Name>.php` |

オプション
-------------------------

| オプション     | 短縮 | 用途                                 |
| -------------- | ---- | ------------------------------------ |
| `--force`      | `-f` | 同名ファイルを上書きします           |
| `--collection` | `-c` | コレクション用のリソースを生成します |
| `--json-api`   | `-j` | JSON:API形式のリソースを生成します   |

`--collection`は名前が`Collection`で終わる場合にも有効になります。
`--collection`と`--json-api`を同時に指定すると`--collection`が優先されます。

生成内容
-------------------------

### 単一リソース

`php artisan make:resource PostResource`は`JsonResource`を継承したクラスを生成します。

```php
class PostResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return parent::toArray($request);
    }
}
```

`toArray()`にJSONへ出す項目を書きます。

### コレクション

`php artisan make:resource PostCollection --collection`は`ResourceCollection`を継承したクラスを生成します。

```php
class PostCollection extends ResourceCollection
{
    public function toArray(Request $request): array
    {
        return parent::toArray($request);
    }
}
```

### JSON:API

`php artisan make:resource PostResource --json-api`は`JsonApiResource`を継承したクラスを生成します。

```php
class PostResource extends JsonApiResource
{
    public $attributes = [
        // ...
    ];

    public $relationships = [
        // ...
    ];
}
```

JSON:APIは`data`、`type`、`id`、`attributes`、`relationships`を持つ形式です。
通常のREST APIと形式が異なるため、どちらかに統一します。

使い方
-------------------------

### 単一リソースを返す

```php
public function show(Post $post): PostResource
{
    return new PostResource($post);
}
```

### コレクションを返す

```php
public function index()
{
    return PostResource::collection(Post::paginate());
}
```

ページネーションを渡すと、`meta`と`links`が自動で付きます。

### 専用のコレクションを返す

```php
public function index(): PostCollection
{
    return new PostCollection(Post::paginate());
}
```

コレクション全体のメタ情報を追加する場合は、`with()`を実装します。

```php
public function with(Request $request): array
{
    return [
        'meta' => ['version' => '1.0'],
    ];
}
```

### toArrayの例

```php
public function toArray(Request $request): array
{
    return [
        'id' => $this->id,
        'title' => $this->title,
        'body' => $this->body,
        'author' => new UserResource($this->whenLoaded('author')),
        'created_at' => $this->created_at?->toIso8601String(),
    ];
}
```

`whenLoaded()`はリレーションが読み込まれている場合だけ出力します。
N+1問題を避けるために、必要なリレーションを`with()`で読み込みます。

条件付き属性
-------------------------

- `whenLoaded('author')`: リレーションが読み込まれている場合だけ出力
- `when($condition, $value)`: 条件が真の場合だけ出力
- `mergeWhen($condition, $array)`: 条件が真の場合だけ複数項目を出力
- `whenHas('email')`: 属性が存在する場合だけ出力

モデルの`$hidden`との違い
-------------------------

モデルの`$hidden`や`$visible`でも項目を隠せます。
ただし、モデル全体のJSONに常に適用されます。

| 方法                  | 範囲               | 向いている用途             |
| --------------------- | ------------------ | -------------------------- |
| `$hidden`、`$visible` | モデル全体         | すべてのJSONから常に隠す   |
| APIリソース           | エンドポイントごと | 返す項目を場面ごとに変える |

「一覧では本文を返さないが、詳細では返す」のように場面ごとに変える場合は、APIリソースを使います。

メモAPIの例
-------------------------

メモの本文だけを返すAPIを考えます。
`NoteResource`の`toArray()`に返したい項目だけを書きます。

```php
class NoteResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'body' => $this->body,
        ];
    }
}
```

コントローラでは次のように返します。

```php
public function show(Note $note): NoteResource
{
    return new NoteResource($note);
}
```

レスポンスは次の形になります。

```json
{
    "data": {
        "body": "買い物リスト"
    }
}
```

`id`や`created_at`も返す場合は、`toArray()`に追加します。
一覧を自分のメモだけに限定する場合は、リソースではなくクエリで`where('user_id', ...)`します。
更新権限はポリシーで判定します。

注意点
-------------------------

- `toArray()`に機密情報を入れない
- リレーションは`whenLoaded()`と`with()`を組み合わせる
- `--json-api`と通常の`JsonResource`はレスポンス形式が異なる
- `data`のラッピングを外す場合は`JsonResource::withoutWrapping()`を使う
- APIリソースはJSON整形だけを担当し、認可や検証は別に実装する

関連ドキュメント
-------------------------

- [makeコマンド索引](index.md)
- [make:controller](controller.md)
- [make:request](request.md)
- [make:policy](policy.md)
- [make:middleware](middleware.md)
