Laravelのmake:scope
=========================

概要
-------------------------

`make:scope`はEloquentのグローバルスコープクラスを生成します。
グローバルスコープは、モデルのすべてのクエリに自動で適用される条件です。

グローバルスコープとは
-------------------------

グローバルスコープを使うと、モデルを取得するすべてのクエリに同じ条件を追加できます。
代表的な用途は次のとおりです。

- 論理削除されたレコードを除外する
- 公開済みの記事だけを取得する
- テナントIDでデータを絞り込む
- 有効なレコードだけを対象にする

ローカルスコープとの違い
-------------------------

| 種類               | 適用方法                                       | 向いている用途                                 |
| ------------------ | ---------------------------------------------- | ---------------------------------------------- |
| グローバルスコープ | すべてのクエリに自動適用                       | 論理削除、テナント、公開状態など、常に守る条件 |
| ローカルスコープ   | `Post::published()->get()`のように明示的に呼ぶ | 画面や処理ごとに使う検索条件                   |

`make:scope`が生成するのはグローバルスコープです。
ローカルスコープはモデルに`scopePublished`のようなメソッドを追加します。

生成物と生成先
-------------------------

| 生成物             | 生成先                         |
| ------------------ | ------------------------------ |
| グローバルスコープ | `app/Models/Scopes/<Name>.php` |

`app/Models`が存在しない場合は`app/Scopes`に生成されます。

オプション
-------------------------

| オプション | 短縮 | 用途                       |
| ---------- | ---- | -------------------------- |
| `--force`  | `-f` | 同名ファイルを上書きします |

生成内容
-------------------------

`php artisan make:scope PublishedScope`は`Scope`を実装したクラスを生成します。

```php
class PublishedScope implements Scope
{
    public function apply(Builder $builder, Model $model): void
    {
        //
    }
}
```

`apply()`にクエリ条件を追加します。

```php
public function apply(Builder $builder, Model $model): void
{
    $builder->where('published', true);
}
```

モデルでの使い方
-------------------------

Laravel 13では`#[ScopedBy]`属性で指定できます。

```php
#[ScopedBy(PublishedScope::class)]
class Post extends Model
{
    //
}
```

属性を使う場合は`use Illuminate\Database\Eloquent\Attributes\ScopedBy;`を追加します。
サービスプロバイダで登録する方法もあります。

```php
protected static function booted(): void
{
    static::addGlobalScope(new PublishedScope);
}
```

スコープを外す
-------------------------

グローバルスコープはすべてのクエリに適用されます。
管理画面などで一時的に外す場合は`withoutGlobalScope()`を使います。

```php
Post::withoutGlobalScope(PublishedScope::class)->get();
```

すべてのグローバルスコープを外す場合は`withoutGlobalScopes()`を使います。

注意点
-------------------------

- グローバルスコープは意図しない画面にも適用されます
- 管理画面やバッチ処理では、スコープを外す必要があるか確認します
- スコープ内で別のクエリを発行すると、再帰や性能問題の原因になります
- 条件が画面ごとに変わる場合は、ローカルスコープの方が適しています

関連ドキュメント
-------------------------

- [makeコマンド索引](index.md)
- [make:model](model.md)
