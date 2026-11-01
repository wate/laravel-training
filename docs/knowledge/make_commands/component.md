Laravelのmake:component
=========================

概要
-------------------------

`make:component`はBladeコンポーネントのクラスとビューを生成します。
既定ではクラスを`app/View/Components`、ビューを`resources/views/components`に生成します。

生成物と生成先
-------------------------

`Alert`コンポーネントを例にします。

| 生成物               | 生成先                                       |
| -------------------- | -------------------------------------------- |
| コンポーネントクラス | `app/View/Components/Alert.php`              |
| ビュー               | `resources/views/components/alert.blade.php` |

`Admin/Alert`のように階層を付けると、クラスは`app/View/Components/Admin/Alert.php`、ビューは`resources/views/components/admin/alert.blade.php`になります。

オプション
-------------------------

| オプション    | 短縮 | 用途                                                       |
| ------------- | ---- | ---------------------------------------------------------- |
| `--inline`    | なし | ビューファイルを作らず、クラス内にBladeを書きます          |
| `--view`      | なし | クラスを作らず、匿名コンポーネントのビューだけを生成します |
| `--path=PATH` | なし | ビューの生成先を変更します                                 |
| `--force`     | `-f` | 同名ファイルを上書きします                                 |
| `--test`      | なし | 既定の形式のテストを生成します                             |
| `--pest`      | なし | Pestテストを生成します                                     |
| `--phpunit`   | なし | PHPUnitテストを生成します                                  |

生成内容
-------------------------

### 通常のコンポーネント

```php
<?php

namespace App\View\Components;

use Closure;
use Illuminate\Contracts\View\View;
use Illuminate\View\Component;

class Alert extends Component
{
    public function __construct()
    {
        //
    }

    public function render(): View|Closure|string
    {
        return view('components.alert');
    }
}
```

### インラインコンポーネント

`--inline`を付けると、ビューファイルを作らず`render()`がBlade文字列を返します。

```php
public function render(): View|Closure|string
{
    return <<<'blade'
<div>
    <!-- ランダムな引用文 -->
</div>
blade;
}
```

### 匿名コンポーネント

`--view`を付けると、クラスを作らずビューだけを生成します。
`resources/views/components/alert.blade.php`を直接編集します。

### ビューの生成先

`--path=admin`を付けると、ビューは`resources/views/admin/alert.blade.php`に生成されます。
クラスの生成先は変わりません。

テスト
-------------------------

`--phpunit`を付けるとコンポーネントのテストも生成されます。
`--view`を付けた場合はクラスを生成しないため、テストも生成されません。

使いどころ
-------------------------

- 画面の部品をクラスとしてまとめるとき
- プロパティやメソッドを持つコンポーネントを作るとき
- ビューだけの小さな部品は`--view`で匿名コンポーネントにします
- 1ファイルで完結する小さな部品は`--inline`を使います

注意点
-------------------------

- `--view`を指定すると`--inline`は無視されます
- `--path`はビューの生成先だけを変えます
- 同名ファイルがある場合は`--force`を付けないとエラーになります

関連ドキュメント
-------------------------

- [makeコマンド索引](index.md)
- [make:view](view.md)
