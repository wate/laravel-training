Laravelのmake:observer
=========================

概要
-------------------------

`make:observer`はEloquentモデルのオブザーバークラスを生成します。
オブザーバーは、モデルの作成、更新、削除などのイベントを1つのクラスにまとめる仕組みです。

オブザーバーとは
-------------------------

Eloquentモデルは`created`、`updated`、`deleted`などのイベントを発行します。
オブザーバーを使うと、これらのイベントに対する処理をモデルから分離できます。

代表的な用途は次のとおりです。

- 監査ログを記録する
- スラッグを自動生成する
- 関連するキャッシュを削除する
- 更新時に通知を送る

生成物と生成先
-------------------------

| 生成物       | 生成先                     |
| ------------ | -------------------------- |
| オブザーバー | `app/Observers/<Name>.php` |

オプション
-------------------------

| オプション        | 短縮 | 用途                       |
| ----------------- | ---- | -------------------------- |
| `--force`         | `-f` | 同名ファイルを上書きします |
| `--model[=MODEL]` | `-m` | 対象モデルを指定します     |

生成内容
-------------------------

### モデルを指定した場合

`php artisan make:observer PostObserver -m Post`は次のメソッドを生成します。

- `created`
- `updated`
- `deleted`
- `restored`
- `forceDeleted`

```php
class PostObserver
{
    public function created(Post $post): void
    {
        //
    }

    public function updated(Post $post): void
    {
        //
    }
}
```

`restored`と`forceDeleted`は`SoftDeletes`を使う場合に関係します。

### モデルを指定しない場合

`-m`を省略すると、中身が空のオブザーバーを生成します。
後からメソッドを追加します。

モデルでの使い方
-------------------------

Laravel 13では`#[ObservedBy]`属性で指定できます。

```php
#[ObservedBy(PostObserver::class)]
class Post extends Model
{
    //
}
```

属性を使う場合は`use Illuminate\Database\Eloquent\Attributes\ObservedBy;`を追加します。
サービスプロバイダで登録する方法もあります。

```php
public function boot(): void
{
    Post::observe(PostObserver::class);
}
```

オブザーバーとイベントリスナーの違い
------------------------------------

| 仕組み           | 向いている用途                        |
| ---------------- | ------------------------------------- |
| オブザーバー     | 特定モデルのイベントを1か所にまとめる |
| イベントリスナー | アプリケーション全体のイベントを扱う  |

モデルイベントだけを扱う場合は、オブザーバーの方が対象が明確です。
複数のモデルや外部システムをまたぐ処理は、イベントとリスナーに分けます。

RailsのActive Recordコールバックとの対応
----------------------------------------

RailsのコールバックとLaravelのオブザーバーは、モデルのライフサイクルに反応する点が似ています。
代表的な対応は次のとおりです。

| Rails               | Laravelのオブザーバー           | 補足                               |
| ------------------- | ------------------------------- | ---------------------------------- |
| `before_validation` | モデルイベントとしては対応なし  | FormRequestやValidatorを使います   |
| `after_validation`  | モデルイベントとしては対応なし  | FormRequestやValidatorを使います   |
| `before_save`       | `saving`                        | `false`を返すと保存を中止します    |
| `after_save`        | `saved`                         |                                    |
| `before_create`     | `creating`                      | `false`を返すと作成を中止します    |
| `after_create`      | `created`                       |                                    |
| `before_update`     | `updating`                      | `false`を返すと更新を中止します    |
| `after_update`      | `updated`                       |                                    |
| `before_destroy`    | `deleting`                      | `false`を返すと削除を中止します    |
| `after_destroy`     | `deleted`                       |                                    |
| `after_find`        | `retrieved`                     | DBから取得したときに呼ばれます     |
| `after_initialize`  | `retrieved`                     | 新規生成時は呼ばれません           |
| `after_commit`      | `ShouldHandleEventsAfterCommit` | トランザクション完了後に実行します |
| `after_rollback`    | 対応なし                        | トランザクション管理側で処理します |
| `around_save`など   | 対応なし                        | 前後のイベントを組み合わせます     |

Laravel固有のイベントは次のとおりです。

| イベント                        | 意味                       |
| ------------------------------- | -------------------------- |
| `restoring`、`restored`         | ソフト削除からの復元       |
| `forceDeleting`、`forceDeleted` | ソフト削除モデルの完全削除 |
| `replicating`                   | モデルの複製               |
| `trashed`                       | ソフト削除済みになったとき |

注意点
-------------------------

- オブザーバーはすべての保存処理で実行されます
- 重い処理はジョブやキューに逃がします
- `updated`で同じモデルを更新すると、再帰呼び出しになる場合があります
- テストではオブザーバーの登録を意識します

関連ドキュメント
-------------------------

- [makeコマンド索引](index.md)
- [make:model](model.md)
- [make:event](event.md)
- [make:listener](listener.md)
