Laravel標準MVCとService層
=========================

概要
-------------------------

Laravel標準のMVCを基本にし、Controllerが太くなった処理だけServiceへ分ける構成です。
このプロジェクトで最初に採用する構成として扱います。

ディレクトリ構成
-------------------------

```text
app/
├ Http/
│   ├ Controllers/
│   └ Requests/
├ Models/
├ Policies/
├ Services/
│   └ Note/
│       └ CreateNoteService.php
└ Providers/
```

`Services`は標準のLaravelにはありません。
`make:service`もないため、`make:class`で生成します。

役割
-------------------------

| 層          | 役割                                                |
| ----------- | --------------------------------------------------- |
| Controller  | HTTP入力の受け取り、Service呼び出し、レスポンス返却 |
| FormRequest | 入力検証と認可                                      |
| Policy      | モデル単位の認可                                    |
| Model       | Eloquentによる永続化とリレーション                  |
| Service     | 複数モデル、トランザクション、外部APIなどの業務処理 |

Controllerに業務ロジックを書かず、Serviceへ出すと見通しが良くなります。
ただし、単純なCRUDはControllerとModelだけでも十分です。

例
-------------------------

```php
final class CreateNoteService
{
    public function execute(User $user, array $data): Note
    {
        return DB::transaction(function () use ($user, $data) {
            return $user->notes()->create($data);
        });
    }
}
```

```php
final class NoteController extends Controller
{
    public function store(StoreNoteRequest $request, CreateNoteService $service)
    {
        $note = $service->execute($request->user(), $request->validated());

        return redirect()->route('notes.show', $note);
    }
}
```

生成コマンド
-------------------------

```text
php artisan make:model Note -m
php artisan make:controller NoteController --resource --model=Note --requests
php artisan make:class Services/Note/CreateNoteService
php artisan make:policy NotePolicy --model=Note
```

`make:class Services/Note/CreateNoteService`は`app/Services/Note/CreateNoteService.php`を生成します。

使いどころ
-------------------------

- 複数のモデルを更新する
- トランザクションをまとめる
- 外部APIを呼ぶ
- Controller、コマンド、ジョブから同じ処理を呼ぶ
- 処理の流れをテストしやすくしたい

使わない方がよい例
-------------------------

- 1モデルの単純なCRUD
- ServiceがModelのラッパーだけになっている
- すべてのModelにServiceを機械的に作る
- Serviceから別のServiceを深く呼び続ける

注意点
-------------------------

- Serviceの責務を1つに保つ
- Eloquentを隠しすぎない
- トランザクションの境界をServiceに置く
- 戻り値の型を明確にする
- 画面都合の整形はResourceやBladeへ分ける

関連ドキュメント
-------------------------

- [アーキテクチャ参考資料](index.md)
- [ADR(Action-Domain-Responder)](adr_action_domain_responder.md)
- [DDD(ドメイン駆動設計)](ddd.md)
- [Laravelのmakeコマンド一覧](../laravel_make_commands.md)
