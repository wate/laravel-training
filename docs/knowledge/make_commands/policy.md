Laravelのmake:policy
=========================

概要
-------------------------

`make:policy`はポリシークラスの雛形を生成します。
モデル単位の認可ルールをコントローラやBladeから分離するときに使います。

生成物と生成先
-------------------------

| 生成物   | 生成先                        |
| -------- | ----------------------------- |
| ポリシー | `app/Policies/PostPolicy.php` |

オプション
-------------------------

| オプション        | 短縮 | 用途                       |
| ----------------- | ---- | -------------------------- |
| `--force`         | `-f` | 同名ファイルを上書きします |
| `--model[=MODEL]` | `-m` | 対象モデルを指定します     |
| `--guard[=GUARD]` | `-g` | 認証ガードを指定します     |

モデルを指定した場合
-------------------------

`--model=Post`を付けると、モデルの型ヒントを持つメソッドを生成します。

生成されるメソッドは次の7つです。

- `viewAny`
- `view`
- `create`
- `update`
- `delete`
- `restore`
- `forceDelete`

すべて既定で`false`を返します。
認可条件に合わせて実装します。

```php
class PostPolicy
{
    public function viewAny(User $user): bool
    {
        return false;
    }

    public function view(User $user, Post $post): bool
    {
        return false;
    }
}
```

モデルを指定しない場合
-------------------------

`--model`を省略すると、コンストラクタだけの空のポリシーを生成します。

```php
class PostPolicy
{
    public function __construct()
    {
        //
    }
}
```

ガード
-------------------------

`--guard=web`のように認証ガードを指定できます。
省略した場合は`auth.defaults.guard`が使われます。
ガードに対応するユーザーモデルがポリシー内のユーザー型に反映されます。
未定義のガードを指定するとエラーになります。

使いどころ
-------------------------

- モデルの閲覧、作成、更新、削除の権限を分けるとき
- コントローラの`authorize`や`Gate`から呼び出すとき
- Bladeの`@can`で表示制御するとき

注意点
-------------------------

- コマンド名には`PostPolicy`のように`Policy`まで含めます
- `--model`を付けるとメソッドが増えます。空のポリシーが必要な場合だけ省略します
- 既定の規約では`App\Models\Post`に対して`App\Policies\PostPolicy`が自動検出されます
- モデルやポリシーの名前空間を変えた場合は`Gate::policy`で登録します

関連ドキュメント
-------------------------

- [makeコマンド索引](index.md)
- [make:model](model.md)
- [make:controller](controller.md)
- [make:exception](exception.md)
