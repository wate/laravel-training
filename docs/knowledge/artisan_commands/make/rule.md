Laravelのmake:rule
=========================

概要
-------------------------

`make:rule`はカスタムバリデーションルールクラスを生成します。
複雑な検証や再利用したい検証を、1つのクラスにまとめる仕組みです。

FormRequestとの違い
-------------------------

| 仕組み         | 役割                                         |
| -------------- | -------------------------------------------- |
| FormRequest    | リクエスト全体の認可とルールセットをまとめる |
| カスタムルール | 1つの検証ロジックを再利用可能なクラスにする  |

FormRequestは「このリクエストでどの項目にどのルールを適用するか」を決めます。
カスタムルールは「1つの項目をどう検証するか」を実装します。
両者は競合せず、FormRequestの`rules()`からカスタムルールを呼び出します。

```php
public function rules(): array
{
    return [
        'postal_code' => ['required', new PostalCodeRule],
    ];
}
```

生成物と生成先
-------------------------

| 生成物         | 生成先                 |
| -------------- | ---------------------- |
| カスタムルール | `app/Rules/<Name>.php` |

オプション
-------------------------

| オプション   | 短縮 | 用途                                     |
| ------------ | ---- | ---------------------------------------- |
| `--force`    | `-f` | 同名ファイルを上書きします               |
| `--implicit` | `-i` | 値が空でも実行する暗黙ルールを生成します |

生成内容
-------------------------

`php artisan make:rule PostalCodeRule`は`ValidationRule`を実装したクラスを生成します。

```php
class PostalCodeRule implements ValidationRule
{
    public function validate(string $attribute, mixed $value, Closure $fail): void
    {
        //
    }
}
```

検証に失敗した場合は`$fail()`を呼びます。

```php
public function validate(string $attribute, mixed $value, Closure $fail): void
{
    if (! is_string($value) || ! preg_match('/^\d{3}-\d{4}$/', $value)) {
        $fail(':attributeは郵便番号の形式で入力してください。');
    }
}
```

暗黙ルール
-------------------------

通常のルールは、値が空の場合に実行されません。
`--implicit`を付けると、値が空でも実行されるルールを生成します。

```php
public $implicit = true;
```

「必須」「未入力ならエラー」など、空の値を検証したい場合に使います。

使いどころ
-------------------------

- 複数のFormRequestで同じ検証を使うとき
- 正規表現や外部APIを使う複雑な検証を分離するとき
- テストしやすい単位で検証をまとめたいとき

注意点
-------------------------

- 単純な検証はLaravelの標準ルールで足ります
- カスタムルールは1つの検証に集中させます
- `$fail()`のメッセージには`:attribute`を使えます
- 暗黙ルールは空の値にも適用されるため、意図を確認します

関連ドキュメント
-------------------------

- [makeコマンド索引](index.md)
- [make:request](request.md)
