Laravelのmake:request
=========================

概要
-------------------------

`make:request`はFormRequestクラスの雛形を生成します。
既定の生成先は`app/Http/Requests`です。
入力値の認可とバリデーションをコントローラから分離するときに使います。

生成物と生成先
-------------------------

| 生成物      | 生成先                                   |
| ----------- | ---------------------------------------- |
| FormRequest | `app/Http/Requests/StorePostRequest.php` |

オプション
-------------------------

| オプション | 短縮 | 用途                       |
| ---------- | ---- | -------------------------- |
| `--force`  | `-f` | 同名ファイルを上書きします |

生成内容
-------------------------

`php artisan make:request StorePostRequest`は次の形を生成します。

```php
<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Foundation\Http\FormRequest;

class StorePostRequest extends FormRequest
{
    public function authorize(): bool
    {
        return false;
    }

    public function rules(): array
    {
        return [
            //
        ];
    }
}
```

`authorize()`は既定で`false`です。
そのまま使うとリクエストが拒否されるため、認可条件を書くか`true`を返します。
`rules()`にバリデーションルールを追加します。

使いどころ
-------------------------

- `make:controller --requests`や`make:model -a`でコントローラと同時に生成します
- コントローラの`store`と`update`で型ヒントとして受け取ります
- 認可はポリシー、入力検証はFormRequestに分けます

注意点
-------------------------

- `authorize()`の戻り値を忘れると403になります
- バリデーション失敗時は自動で前の画面へリダイレクトされます
- JSONリクエストでは422とエラー内容が返ります

関連ドキュメント
-------------------------

- [makeコマンド索引](index.md)
- [make:controller](controller.md)
- [make:resource](resource.md)
- [make:model](model.md)
- [make:exception](exception.md)
