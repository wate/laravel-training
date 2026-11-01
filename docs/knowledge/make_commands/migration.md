Laravelのmake:migration
=========================

概要
-------------------------

`make:migration`はマイグレーションファイルの雛形を生成します。
ファイル名は`<timestamp>_<name>.php`で、タイムスタンプは`Y_m_d_His`形式です。
クラス名はなく、無名クラス`return new class extends Migration`を生成します。

生成物と生成先
-------------------------

| 生成物           | 生成先                                       |
| ---------------- | -------------------------------------------- |
| マイグレーション | `database/migrations/<timestamp>_<name>.php` |

オプション
-------------------------

| オプション          | 用途                                                 |
| ------------------- | ---------------------------------------------------- |
| `--create[=CREATE]` | テーブル作成用の雛形を生成します                     |
| `--table[=TABLE]`   | 既存テーブル変更用の雛形を生成します                 |
| `--path[=PATH]`     | 生成先を変更します                                   |
| `--realpath`        | `--path`を絶対パスとして扱います                     |
| `--fullpath`        | 生成されたファイルのフルパスを表示します。非推奨です |

名前からの推測
-------------------------

`--create`と`--table`を省略した場合、名前からテーブル名と作成または変更を推測します。

| 名前の例                      | 推測結果                     |
| ----------------------------- | ---------------------------- |
| `create_posts_table`          | `posts`テーブルの作成        |
| `create_posts`                | `posts`テーブルの作成        |
| `add_status_to_posts_table`   | `posts`テーブルの変更        |
| `add_status_to_posts`         | `posts`テーブルの変更        |
| `rename_title_in_posts_table` | `posts`テーブルの変更        |
| `foo`                         | テーブルを推測せず、空の雛形 |

推測は`--create`や`--table`で上書きできます。

生成内容
-------------------------

### テーブル作成

`make:migration create_posts_table`または`--create=posts`は次の形を生成します。

```php
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('posts', function (Blueprint $table) {
            $table->id();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('posts');
    }
};
```

### テーブル変更

`--table=posts`または`..._to_posts_table`は次の形を生成します。
クラス部分は次の形です。

```php
return new class extends Migration
{
    public function up(): void
    {
        Schema::table('posts', function (Blueprint $table) {
            //
        });
    }

    public function down(): void
    {
        Schema::table('posts', function (Blueprint $table) {
            //
        });
    }
};
```

### テーブルを指定しない場合

`up()`と`down()`が`//`だけの雛形を生成します。
テーブル名を後から決める場合や、複数テーブルを変更する場合に使います。

使い分け
-------------------------

- 新規テーブルは`create_posts_table`または`--create=posts`を使います
- 既存テーブルは`add_status_to_posts_table --table=posts`を使います
- 複数テーブルを変更する場合は`--table`を省略し、`up()`と`down()`に複数の`Schema::table`を書きます
- 生成先を変える場合は`--path=database/migrations/tenant`を使います
- 絶対パスを指定する場合だけ`--realpath`を併用します

注意点
-------------------------

- 同じ名前でもタイムスタンプが異なれば別ファイルとして生成されます
- タイムスタンプが同じ場合は秒を進めて衝突を避けます
- `--fullpath`は非推奨です。現在は生成時にフルパスが表示されます
- マイグレーションはファイル名順に実行されます
- `--create`と`--table`を同時に指定した場合は、`--table`のテーブル名が優先されます

関連ドキュメント
-------------------------

- [makeコマンド索引](index.md)
- [make:model](model.md)
- [Laravelスケルトンの既定テーブル](../laravel_default_tables.md)
- [インフラ用テーブルのマイグレーション](infra_tables.md)
