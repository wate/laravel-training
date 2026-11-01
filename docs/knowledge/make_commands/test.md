Laravelのmake:test
=========================

概要
-------------------------

`make:test`はテストクラスの雛形を生成します。
既定ではFeatureテストを`tests/Feature`に生成します。
`-u`を付けるとUnitテストを`tests/Unit`に生成します。

生成物と生成先
-------------------------

| 生成物        | 生成先                       |
| ------------- | ---------------------------- |
| Featureテスト | `tests/Feature/PostTest.php` |
| Unitテスト    | `tests/Unit/PostTest.php`    |

名前空間を付けるとサブディレクトリに生成されます。
`make:test Http/Controllers/PostControllerTest`は`tests/Feature/Http/Controllers/PostControllerTest.php`を生成します。

オプション
-------------------------

| オプション  | 短縮 | 用途                       |
| ----------- | ---- | -------------------------- |
| `--force`   | `-f` | 同名ファイルを上書きします |
| `--unit`    | `-u` | Unitテストを生成します     |
| `--pest`    | なし | Pestテストを生成します     |
| `--phpunit` | なし | PHPUnitテストを生成します  |

生成内容
-------------------------

### Featureテスト

`php artisan make:test PostTest --phpunit`は次の形を生成します。

```php
<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;

class PostTest extends TestCase
{
    public function test_example(): void
    {
        $response = $this->get('/');

        $response->assertStatus(200);
    }
}
```

`RefreshDatabase`と`WithFaker`はuse文だけが生成され、トレイトは自動適用されません。
必要に応じてクラス内で`use RefreshDatabase;`を追加します。

### Unitテスト

`php artisan make:test PostTest --phpunit -u`は`PHPUnit\Framework\TestCase`を継承したテストを生成します。
Laravelのヘルパーは使えないため、純粋なロジックのテストに使います。

PestとPHPUnit
-------------------------

`--phpunit`はPHPUnit、`--pest`はPestを明示します。
どちらも指定しない場合、Pestがインストールされ`tests/Pest.php`があるときはPest、それ以外はPHPUnitを使います。
このプロジェクトはPHPUnitを使います。

使いどころ
-------------------------

- FeatureテストはHTTPリクエスト、認証、DBを含む振る舞いに使います
- Unitテストはサービスクラスや値オブジェクトなど純粋なロジックに使います
- `make:model --phpunit`や`make:controller --phpunit`からも呼ばれます

注意点
-------------------------

- `--pest`と`--phpunit`を同時に指定した場合、`--phpunit`が優先されます
- Pestを使う場合は`pestphp/pest`と`tests/Pest.php`が必要です
- Unitテストでは`RefreshDatabase`などのLaravelトレイトを使えません

関連ドキュメント
-------------------------

- [makeコマンド索引](index.md)
- [Laravelのテストとデータベース](../laravel_testing.md)
