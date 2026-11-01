Laravelのmake:seeder
=========================

概要
-------------------------

`make:seeder`はシーダークラスの雛形を生成します。
初期データやテストデータを投入するときに使います。

生成物と生成先
-------------------------

| 生成物   | 生成先                            |
| -------- | --------------------------------- |
| シーダー | `database/seeders/PostSeeder.php` |

`database/seeds`ディレクトリが存在する場合は、そちらに生成されます。

オプション
-------------------------

`make:seeder`に固有のオプションはありません。
共通の`--help`などだけが使えます。

生成内容
-------------------------

`php artisan make:seeder PostSeeder`は次の形を生成します。

```php
<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class PostSeeder extends Seeder
{
    public function run(): void
    {
        //
    }
}
```

`run()`にデータ投入処理を書きます。

使いどころ
-------------------------

- 開発環境の初期データを投入するとき
- 本番環境に固定データを投入するとき
- テスト前にデータを準備するとき

注意点
-------------------------

- コマンド名には`PostSeeder`のように`Seeder`まで含めます。`Post`だけだと`Post.php`が生成されます
- 同名ファイルがある場合はエラーになり、`--force`はありません
- `DatabaseSeeder`から`$this->call(PostSeeder::class)`で呼び出します

関連ドキュメント
-------------------------

- [makeコマンド索引](index.md)
- [make:model](model.md)
- [make:factory](factory.md)
