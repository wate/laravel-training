Laravelのモデル拡張
=========================

概要
-------------------------

DB周りの定番処理を簡単にする仕組みを整理します。
Laravelにはビヘイビアという名前の仕組みはありません。
標準のトレイト、モデルイベント、サードパーティパッケージの組み合わせで実現します。

対応表
-------------------------

| やりたいこと                 | Laravelでの実現方法                 | 区分             |
| ---------------------------- | ----------------------------------- | ---------------- |
| 作成日時と更新日時の自動更新 | `$timestamps`                       | 標準             |
| 論理削除                     | `SoftDeletes`トレイト               | 標準             |
| 関連件数のキャッシュ         | `withCount()`、またはイベントで加算 | 標準の部品で自作 |
| 入れ子集合モデル             | `kalnoy/nestedset`                  | パッケージ       |
| 翻訳                         | `spatie/laravel-translatable`       | パッケージ       |
| スラッグ生成                 | `cviebrock/eloquent-sluggable`      | パッケージ       |
| ポリモーフィック関連         | `morphTo`などの標準リレーション     | 標準             |
| 単一テーブル継承             | `tightenco/parental`                | パッケージ       |

パッケージの対応状況
-------------------------

このプロジェクトのLaravel 13.39.0に対する対応状況です。
Composerのメタデータで確認した結果を示します。

| パッケージ                     | 最新版   | Laravel 13対応 |
| ------------------------------ | -------- | -------------- |
| `kalnoy/nestedset`             | 7.0.0    | 対応           |
| `spatie/laravel-translatable`  | 6.15.0   | 対応           |
| `cviebrock/eloquent-sluggable` | 13.0.2   | 対応           |
| `tightenco/parental`           | 1.6.0    | 対応           |
| `spatie/laravel-medialibrary`  | 11.23.13 | 対応           |

論理削除
-------------------------

標準の`SoftDeletes`トレイトを使います。
テーブルには`deleted_at`列を追加します。

```php
use Illuminate\Database\Eloquent\SoftDeletes;

class Post extends Model
{
    use SoftDeletes;
}
```

マイグレーションでは`softDeletes()`を使います。

```php
$table->softDeletes();
```

`delete()`は論理削除になり、`restore()`で元に戻せます。
物理削除は`forceDelete()`、削除済みの判定は`trashed()`です。

カウンターキャッシュ
-------------------------

標準に専用の仕組みはありません。
取得時に数えるだけなら`withCount()`で足ります。

```php
$posts = Post::withCount('comments')->get();
echo $posts->first()->comments_count;
```

親テーブルに件数を持たせたい場合は、モデルイベントで加算します。

```php
trait CounterCache
{
    public static function bootCounterCache(): void
    {
        static::created(function ($model) {
            $model->post()->increment('comments_count');
        });

        static::deleted(function ($model) {
            $model->post()->decrement('comments_count');
        });
    }
}
```

`increment()`と`decrement()`はクエリビルダの機能です。
設定ではなく、トレイトにイベント処理を書いて有効にします。
起動時のフックについては[Laravelモデルの拡張ポイント](laravel_model_hooks.md)を参照してください。

入れ子集合モデル
-------------------------

`kalnoy/nestedset`を使います。

```bash
composer require kalnoy/nestedset
```

モデルに`NodeTrait`を追加します。
テーブルには`parent_id`、`_lft`、`_rgt`列を持たせます。

```php
use Kalnoy\Nestedset\NodeTrait;

class Category extends Model
{
    use NodeTrait;
}
```

`appendToNode()`や`descendants()`など、ツリー操作のメソッドが使えます。

ポリモーフィック関連
-------------------------

標準のリレーションで実現できます。
1つのテーブルから複数のモデルへ関連づける場合に使います。

`comments`テーブルが`posts`と`videos`の両方に紐づく例を示します。

```php
class Comment extends Model
{
    public function commentable()
    {
        return $this->morphTo();
    }
}

class Post extends Model
{
    public function comments()
    {
        return $this->morphMany(Comment::class, 'commentable');
    }
}
```

テーブルには`commentable_type`と`commentable_id`列を持たせます。
`morphOne`、`morphToMany`、`morphedByMany`も標準で用意されています。

単一テーブル継承
-------------------------

標準には仕組みがありません。
`tightenco/parental`を使うと、1つのテーブルを複数のモデルで共有できます。

```bash
composer require tightenco/parental
```

```php
use Parental\HasChildren;

class User extends Model
{
    use HasChildren;
}

use Parental\HasParent;

class Admin extends User
{
    use HasParent;
}
```

テーブルには`type`列を持たせます。
`type`列の値でモデルが切り替わります。
標準機能だけで済ませる場合は、`type`列とグローバルスコープを組み合わせて簡易に実装します。

翻訳
-------------------------

`spatie/laravel-translatable`を使います。

```bash
composer require spatie/laravel-translatable
```

翻訳対象の列をJSON型にし、モデルで`HasTranslations`トレイトを使います。

```php
use Spatie\Translatable\HasTranslations;

class Post extends Model
{
    use HasTranslations;

    public $translatable = ['title'];
}
```

`$post->setTranslation('title', 'ja', 'タイトル')`のように言語ごとの値を保持できます。

スラッグ生成
-------------------------

`cviebrock/eloquent-sluggable`を使います。

```bash
composer require cviebrock/eloquent-sluggable
```

モデルに`Sluggable`トレイトを追加し、生成元の列を指定します。

```php
use Cviebrock\EloquentSluggable\Sluggable;

class Post extends Model
{
    use Sluggable;

    public function sluggable(): array
    {
        return ['slug' => ['source' => 'title']];
    }
}
```

ファイル添付
-------------------------

`spatie/laravel-medialibrary`を使います。
Eloquentモデルにファイルを添付できます。

```bash
composer require spatie/laravel-medialibrary
```

テーブルにはファイルのメタデータを保存し、実体はディスクに置きます。
この方式は『SQLアンチパターン』でいうファントムファイルに当たります。

- `media`テーブル: ディスク名、ファイル名、MIMEタイプ、サイズ、変換情報
- 実体ファイル: `disk`で指定したストレージ

モデルとメディアはポリモーフィック関連で紐づきます。
画像のサムネイルなどはキューで生成できます。

### ファントムファイルの注意点

DBとストレージは同一トランザクションで扱えません。
そのため、次の状況では孤立ファイルや参照切れが起こります。

- 削除処理の途中でプロセスが落ちた場合
- ストレージ側だけ手動で消した場合
- バックアップの取得タイミングがDBとストレージでずれた場合

対策として、削除処理をモデルイベントへ集約します。
あわせて、定期的な孤立ファイルの検出と、バックアップ順序の統一を行います。

そのほかの定番パッケージ
-------------------------

### Spatieのパッケージ

SpatieはLaravel向けのパッケージを多数公開しています。
一覧は[spatieのGitHub](https://github.com/spatie)を参照してください。
以下はすべてLaravel 13対応を確認済みです。

- `spatie/laravel-activitylog`: モデルの操作履歴を記録します
- `spatie/laravel-permission`: ロールと権限を管理します
- `spatie/laravel-tags`: タグ付けを追加します
- `spatie/laravel-model-status`: モデルに状態を持たせます
- `spatie/laravel-sluggable`: スラッグ生成のもう一つの定番です
- `spatie/laravel-query-builder`: リクエストパラメータからクエリを組み立てます
- `spatie/laravel-data`: DTOを定義してデータを変換します
- `spatie/laravel-backup`: データベースとファイルをバックアップします

`spatie/laravel-model-states`は安定版がLaravel 13に対応していません。

### そのほかのパッケージ

- `owen-it/laravel-auditing`: 変更前後の値を監査ログとして残します

パッケージ導入時の確認
-------------------------

- `composer show --all <パッケージ名>`で要求バージョンを確認します
- READMEで対応するLaravelのバージョンを確認します
- 導入は機能実装のタイミングで行い、事前には入れません

関連ドキュメント
-------------------------

- [Laravel用語の言い換え表](laravel_terms.md): 用語と一般的な呼び方・CakePHPとの対応
- [Laravel系パッケージの整理](laravel_packages.md): 公式パッケージの用途一覧
