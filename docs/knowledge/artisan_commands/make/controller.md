Laravelのmake:controller
=========================

概要
-------------------------

`make:controller`はコントローラクラスの雛形を生成します。
既定の生成先は`app/Http/Controllers`です。
空のコントローラ、リソースコントローラ、APIリソース、invokable、シングルトン、ネストしたリソースを生成できます。

生成物と生成先
-------------------------

| 生成物       | 生成先                                                                  |
| ------------ | ----------------------------------------------------------------------- |
| コントローラ | `app/Http/Controllers/<Name>Controller.php`                             |
| FormRequest  | `app/Http/Requests/Store<Model>Request.php`と`Update<Model>Request.php` |
| テスト       | `tests/Feature/Http/Controllers/<Name>ControllerTest.php`               |

オプション
-------------------------

| オプション          | 短縮 | 用途                                                 |
| ------------------- | ---- | ---------------------------------------------------- |
| `--api`             | なし | `create`と`edit`を除いたAPIリソースにします          |
| `--type=TYPE`       | なし | 使用するstubを直接指定します                         |
| `--force`           | なし | 同名ファイルを上書きします                           |
| `--invokable`       | `-i` | `__invoke`だけを持つコントローラを生成します         |
| `--model[=MODEL]`   | `-m` | モデルをバインドしたリソースコントローラを生成します |
| `--parent[=PARENT]` | `-p` | ネストしたリソースコントローラを生成します           |
| `--resource`        | `-r` | CRUDの7メソッドを持つコントローラを生成します        |
| `--requests`        | `-R` | `store`と`update`用のFormRequestを生成します         |
| `--singleton`       | `-s` | シングルトンリソースコントローラを生成します         |
| `--creatable`       | なし | シングルトンリソースで作成を許可します               |
| `--test`            | なし | テストを生成します                                   |
| `--pest`            | なし | Pestテストを生成します                               |
| `--phpunit`         | なし | PHPUnitテストを生成します                            |

stubの選択
-------------------------

| 指定                                      | 使用するstub                       | 生成されるメソッド                                              |
| ----------------------------------------- | ---------------------------------- | --------------------------------------------------------------- |
| なし                                      | `controller.plain.stub`            | なし                                                            |
| `--resource`                              | `controller.stub`                  | `index`、`create`、`store`、`show`、`edit`、`update`、`destroy` |
| `--resource --model=Post`                 | `controller.model.stub`            | 上記にモデルバインディングを追加                                |
| `--api`                                   | `controller.api.stub`              | `index`、`store`、`show`、`update`、`destroy`                   |
| `--api --model=Post`                      | `controller.model.api.stub`        | 上記にモデルバインディングを追加                                |
| `--invokable`                             | `controller.invokable.stub`        | `__invoke`                                                      |
| `--singleton`                             | `controller.singleton.stub`        | `create`、`store`、`show`、`edit`、`update`、`destroy`          |
| `--parent=Post --model=Photo`             | `controller.nested.stub`           | 親モデルと子モデルを持つネストしたリソース                      |
| `--parent=Post --singleton --model=Photo` | `controller.nested.singleton.stub` | ネストしたシングルトン                                          |

`--api`は既存のstub名に`.api.stub`を付けます。
`--type`は`controller.<TYPE>.stub`を直接探します。

生成内容
-------------------------

### 空のコントローラ

`php artisan make:controller PostController`は次の形を生成します。

```php
<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class PostController extends Controller
{
    //
}
```

`app/Http/Controllers/Controller.php`が存在するため、基底クラスの`use`文は生成されません。
基底クラスがない場合は`use App\Http\Controllers\Controller;`が追加されます。

### リソースコントローラ

`--resource`は`index`、`create`、`store`、`show`、`edit`、`update`、`destroy`の7メソッドを生成します。
`--model=Post`を付けると、`show`、`edit`、`update`、`destroy`の引数が`Post $post`になります。
`--requests`を付けると、`store`と`update`の引数がFormRequestになります。

### APIリソース

`--api`は`create`と`edit`を除いた5メソッドを生成します。
`--model=Post`を付けると、モデルバインディングが追加されます。

### invokableコントローラ

`--invokable`は`__invoke`だけを持つコントローラを生成します。
クラス部分の抜粋は次の形です。

```php
class PostController extends Controller
{
    public function __invoke(Request $request)
    {
        //
    }
}
```

### シングルトンリソース

`--singleton`は`create`、`store`、`show`、`edit`、`update`、`destroy`を生成します。
`create`、`store`、`destroy`は既定で`abort(404)`です。
`--creatable`を付けると`abort(404)`が`//`に置き換わります。
生成後に`destroy`の戻り値と処理を確認します。

### ネストしたリソース

`--parent=Post`は`Post`を親に持つネストしたリソースコントローラを生成します。
子モデルは`--model=Photo`のように指定します。
親モデルまたは子モデルが存在しない場合、生成するか確認されます。

```text
php artisan make:controller PhotoController --resource --parent=Post --model=Photo
```

ネストしたstubは`Request`を直接使うため、`--requests`で生成したFormRequestは自動で組み込まれません。
FormRequestを使う場合は生成後に手動で差し替えます。

組み合わせ
-------------------------

- `--resource --model=Post`: モデルをバインドしたリソースコントローラ
- `--api --model=Post`: モデルをバインドしたAPIリソースコントローラ
- `--resource --model=Post --requests`: FormRequest付きのリソースコントローラ
- `--parent=Post --model=Photo --resource`: ネストしたリソースコントローラ
- `--parent=Post --model=Photo --singleton`: ネストしたシングルトンリソース
- `--invokable`: 1操作1コントローラ

`--requests`は`--model`、`--resource`、`--api`のいずれかと組み合わせます。
`--requests`だけではFormRequestを生成しません。

注意点
-------------------------

- `--model=Post`や`--parent=Post`で指定したモデルが存在しない場合、生成するか確認されます
- `--type`はstub名を直接指定するため、通常は`--resource`や`--api`を使います
- `--creatable`は`--singleton`と組み合わせます
- `--api`と`--invokable`を同時に指定した場合、invokableのstubが優先されます
- `--force`を付けない場合、同名ファイルがあるとエラーになります

設計での使いどころ
-------------------------

- 画面のCRUDは`--resource --model=Post`を使います
- APIは`--api --model=Post`を使います
- 1画面1操作は`--invokable`を使います
- 入力検証は`--requests`でFormRequestに分離します
- 認可は`make:policy`と組み合わせます

関連ドキュメント
-------------------------

- [makeコマンド索引](index.md)
- [make:model](model.md)
- [make:middleware](middleware.md)
- [make:request](request.md)
- [make:resource](resource.md)
- [make:policy](policy.md)
