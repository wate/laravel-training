Laravelのmake:model
=========================

概要
-------------------------

`make:model`はEloquentモデルの雛形を生成します。
既定の生成先は`app/Models`です。
`app/Models`が存在しない場合は`app`に生成します。
マイグレーション、シーダー、ファクトリ、ポリシー、コントローラ、FormRequestを同時に生成できます。

生成物と生成先
-------------------------

`Post`モデルを例にします。

| 生成物           | 生成先                                                            | 生成条件                        |
| ---------------- | ----------------------------------------------------------------- | ------------------------------- |
| モデル           | `app/Models/Post.php`                                             | 常に生成                        |
| マイグレーション | `database/migrations/<timestamp>_create_posts_table.php`          | `-m`、`-a`                      |
| シーダー         | `database/seeders/PostSeeder.php`                                 | `-s`、`-a`                      |
| ファクトリ       | `database/factories/PostFactory.php`                              | `-f`、`-a`                      |
| ポリシー         | `app/Policies/PostPolicy.php`                                     | `--policy`、`-a`                |
| コントローラ     | `app/Http/Controllers/PostController.php`                         | `-c`、`-r`、`--api`、`-a`       |
| FormRequest      | `app/Http/Requests/StorePostRequest.php`と`UpdatePostRequest.php` | `-R`、`-a`                      |
| テスト           | `tests/Feature/Models/PostTest.php`                               | `--test`、`--pest`、`--phpunit` |

`-f`はファクトリの生成です。
上書きの`--force`とは異なります。

オプション
-------------------------

| オプション      | 短縮 | 用途                                                                                            |
| --------------- | ---- | ----------------------------------------------------------------------------------------------- |
| `--all`         | `-a` | マイグレーション、シーダー、ファクトリ、ポリシー、リソースコントローラ、FormRequestを生成します |
| `--controller`  | `-c` | コントローラを生成します                                                                        |
| `--factory`     | `-f` | ファクトリを生成します                                                                          |
| `--force`       | なし | 同名のモデルがあっても生成します                                                                |
| `--migration`   | `-m` | マイグレーションを生成します                                                                    |
| `--morph-pivot` | なし | `MorphPivot`を継承したモデルを生成します                                                        |
| `--policy`      | なし | ポリシーを生成します                                                                            |
| `--seed`        | `-s` | シーダーを生成します                                                                            |
| `--pivot`       | `-p` | `Pivot`を継承したモデルを生成します                                                             |
| `--resource`    | `-r` | モデルをバインドしたリソースコントローラを生成します                                            |
| `--api`         | なし | モデルをバインドしたAPIリソースコントローラを生成します                                         |
| `--requests`    | `-R` | `store`と`update`用のFormRequestを生成します                                                    |
| `--test`        | なし | 既定の形式のテストを生成します                                                                  |
| `--pest`        | なし | Pestテストを生成します                                                                          |
| `--phpunit`     | なし | PHPUnitテストを生成します                                                                       |

生成内容
-------------------------

### 標準モデル

生成されるファイルは次の形です。

```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Post extends Model
{
    /** @use HasFactory<\Database\Factories\PostFactory> */
    use HasFactory;
}
```

`-f`または`-a`を付けた場合だけ`HasFactory`が入ります。
それ以外の場合は`//`だけのクラスになります。

### 中間テーブルモデル

`--pivot`は`Pivot`、`--morph-pivot`は`MorphPivot`を継承します。
`--pivot`のクラス部分は次の形です。

```php
use Illuminate\Database\Eloquent\Relations\Pivot;

class PostUser extends Pivot
{
    //
}
```

`--pivot`と`-m`を組み合わせると、マイグレーションのテーブル名は単数形になります。
`--morph-pivot`は`pivot`オプションとして扱われないため、テーブル名は複数形のままです。

組み合わせ
-------------------------

### `-a`で生成されるファイル

`php artisan make:model Post -a`は次を生成します。

- `app/Models/Post.php`
- `database/migrations/<timestamp>_create_posts_table.php`
- `database/seeders/PostSeeder.php`
- `database/factories/PostFactory.php`
- `app/Policies/PostPolicy.php`
- `app/Http/Controllers/PostController.php`
- `app/Http/Requests/StorePostRequest.php`
- `app/Http/Requests/UpdatePostRequest.php`

`-a`はテストを生成しません。
テストも生成する場合は`--phpunit`、`--pest`、`--test`のいずれかを追加します。

### コントローラの種類

- `-c`: 空のコントローラを生成します
- `-r`: モデルをバインドしたリソースコントローラを生成します
- `-r --api`: モデルをバインドしたAPIリソースコントローラを生成します
- `-R`: FormRequestだけを生成します
- `-r -R`: リソースコントローラとFormRequestを生成します

### テスト

`--phpunit`はモデルのFeatureテストを生成します。
`--pest`はPest、`--test`は既定の形式を使います。
`make:model Post -a --phpunit`のように`-a`と併用できます。

`-a`と`--test`または`--pest`を併用すると、モデルとコントローラのテストが生成されます。
`--phpunit`はモデルのテストだけを生成します。

設計での使いどころ
-------------------------

- テーブル設計が固まったら`make:model Post -m`でモデルとマイグレーションを同時に作ります
- テストデータが必要なら`-f`と`-s`を追加します
- 認可が必要なら`--policy`を追加します
- 画面のCRUDを作るなら`-r -R`でコントローラとFormRequestをまとめて作ります
- 最初から一式を作るなら`-a`を使い、不要なファイルを削除します

注意点
-------------------------

- `-f`はファクトリ、`--force`は上書きです
- `-a`はテストを生成しません
- `-R`は単独でもFormRequestを生成します。`-r`や`--api`と組み合わせるとコントローラ内で使用されます
- `--pivot`と`--morph-pivot`は同時に指定できません。`--pivot`が優先されます
- モデルがすでに存在する場合、追加コンポーネントを生成するか確認されます
- `--force`を付けるとモデル自体も上書きします

関連ドキュメント
-------------------------

- [makeコマンド索引](index.md)
- [make:migration](migration.md)
- [make:controller](controller.md)
- [make:policy](policy.md)
- [Laravelスケルトンの既定テーブル](../laravel_default_tables.md)
