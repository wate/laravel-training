Laravelのmake:factory
=========================

概要
-------------------------

`make:factory`はモデルファクトリの雛形を生成します。
テストデータやシーダーでモデルのインスタンスを簡単に作るために使います。

生成物と生成先
-------------------------

| 生成物           | 生成先                               |
| ---------------- | ------------------------------------ |
| モデルファクトリ | `database/factories/PostFactory.php` |

オプション
-------------------------

| オプション        | 短縮 | 用途                   |
| ----------------- | ---- | ---------------------- |
| `--model[=MODEL]` | `-m` | 対象モデルを指定します |

モデルの推測
-------------------------

`-m`を省略した場合、ファクトリ名からモデル名を推測します。
`PostFactory`または`Post`から`Post`モデルを推測します。
モデルが見つからない場合は`App\Models\Model`が使われるため、`-m Post`で明示するのが安全です。

生成内容
-------------------------

`php artisan make:factory PostFactory -m Post`は次の形を生成します。

```php
<?php

namespace Database\Factories;

use App\Models\Post;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<Post>
 */
class PostFactory extends Factory
{
    public function definition(): array
    {
        return [
            //
        ];
    }
}
```

`definition()`に属性の初期値を追加します。
`fake()`を使ってランダムな値を生成できます。

使いどころ
-------------------------

- モデルのテストデータを作るとき
- シーダーで大量のデータを投入するとき
- `make:model -f`でモデルと同時に生成するとき

注意点
-------------------------

- `-m`を省略すると意図しないモデルが推測される場合があります
- ファクトリを使うモデルには`HasFactory`トレイトが必要です
- `make:model -f`または`make:model -a`で生成すると`HasFactory`も追加されます

関連ドキュメント
-------------------------

- [makeコマンド索引](index.md)
- [make:model](model.md)
- [make:seeder](seeder.md)
