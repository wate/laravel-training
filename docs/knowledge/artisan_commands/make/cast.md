Laravelのmake:cast
=========================

概要
-------------------------

`make:cast`はEloquentのカスタムキャストクラスを生成します。
カスタムキャストは、データベースの値をPHPの値へ変換する処理をクラスにまとめた仕組みです。
モデルの属性ごとに再利用できます。

カスタムキャストとは
-------------------------

Eloquentは`integer`、`boolean`、`datetime`、`array`などの標準キャストを持っています。
標準キャストで足りない変換をクラスとして実装するのがカスタムキャストです。

たとえば次の変換に向いています。

- 金額を`int`から`Money`オブジェクトへ変換する
- 文字列を`Status`列挙型へ変換する
- 複数のカラムを1つの値オブジェクトへまとめる
- 保存時だけハッシュ化する

生成物と生成先
-------------------------

| 生成物           | 生成先                 |
| ---------------- | ---------------------- |
| カスタムキャスト | `app/Casts/<Name>.php` |

オプション
-------------------------

| オプション  | 短縮 | 用途                                   |
| ----------- | ---- | -------------------------------------- |
| `--force`   | `-f` | 同名ファイルを上書きします             |
| `--inbound` | なし | 保存時だけ変換するキャストを生成します |

生成内容
-------------------------

### 通常のキャスト

`php artisan make:cast MoneyCast`は`CastsAttributes`を実装したクラスを生成します。

```php
class MoneyCast implements CastsAttributes
{
    public function get(Model $model, string $key, mixed $value, array $attributes): mixed
    {
        return $value;
    }

    public function set(Model $model, string $key, mixed $value, array $attributes): mixed
    {
        return $value;
    }
}
```

`get()`はデータベースから値を取り出すとき、`set()`は保存するときに呼ばれます。

### 受信専用キャスト

`--inbound`を付けると`CastsInboundAttributes`を実装し、`set()`だけを持つクラスを生成します。

```php
class HashCast implements CastsInboundAttributes
{
    public function set(Model $model, string $key, mixed $value, array $attributes): mixed
    {
        return $value;
    }
}
```

`get()`が必要ない変換、たとえば保存時だけハッシュ化する場合に使います。

モデルでの使い方
-------------------------

Laravel 13では`casts()`メソッドで指定します。

```php
protected function casts(): array
{
    return [
        'price' => MoneyCast::class,
        'status' => StatusCast::class,
        'secret' => HashCast::class,
    ];
}
```

`HashCast`のように`CastsInboundAttributes`を実装したキャストは、取得時には変換されません。

実装例
-------------------------

以下の例では`Money`と`Status`というクラスが存在するものとします。

### 金額を整数で保存する

```php
public function get(Model $model, string $key, mixed $value, array $attributes): Money
{
    return new Money((int) $value);
}

public function set(Model $model, string $key, mixed $value, array $attributes): int
{
    return $value->amount();
}
```

### 文字列を列挙型へ変換する

```php
public function get(Model $model, string $key, mixed $value, array $attributes): Status
{
    return Status::from($value);
}

public function set(Model $model, string $key, mixed $value, array $attributes): string
{
    return $value->value;
}
```

アクセサとの違い
-------------------------

アクセサとミューテタはモデル内のメソッドで属性ごとに書きます。
カスタムキャストはクラスとして分離できるため、複数のモデルや属性で再利用できます。
複雑な変換や値オブジェクトへの変換は、カスタムキャストに向いています。

注意点
-------------------------

- `get()`と`set()`の戻り値の型を実際の値に合わせます
- `set()`は保存する型、`get()`は利用する型を返します
- キャストクラスは`app/Casts`に置きます
- 標準キャストで足りる場合は無理にカスタムキャストを作りません

関連ドキュメント
-------------------------

- [makeコマンド索引](index.md)
- [make:model](model.md)
