ADR(Action-Domain-Responder)参考構成
====================================

概要
-------------------------

Action、Domain、Responderの3つに分ける構成です。
Slim 4 SkeletonのAction/Domain構成を参考にしています。
ここでのADRはAction-Domain-Responderを指します。

構成
-------------------------

```text
app/
├ Actions/
│   └ Note/
│       └ CreateNoteAction.php
├ Domain/
│   └ Note/
│       ├ Repository/
│       │   └ NoteRepositoryInterface.php
│       └ Service/
│           └ CreateNoteService.php
├ Infrastructure/
│   └ Persistence/
│       └ EloquentNoteRepository.php
├ Http/
│   ├ Requests/
│   │   └ Note/
│   │       └ CreateNoteRequest.php
│   └ Resources/
│       └ Note/
│           └ NoteResource.php
├ Models/
│   └ Note.php
└ Providers/
    └ NoteServiceProvider.php
```

役割
-------------------------

| 要素                       | 役割                                             |
| -------------------------- | ------------------------------------------------ |
| Action                     | 入力の収集、Domainの呼び出し、レスポンス返却     |
| Domain Service             | 業務ロジック、トランザクション、Use case         |
| Repositoryインターフェース | 永続化の境界                                     |
| Repository実装             | Eloquentなどによる永続化                         |
| Responder                  | レスポンス整形。LaravelではResourceやBladeが近い |
| FormRequest                | HTTP入力の検証                                   |
| Provider                   | インターフェースと実装の紐付け                   |

ActionはHTTPに依存しますが、Domain ServiceはHTTPに依存させません。
RepositoryやDomain Serviceの詳しい設計は[DDD(ドメイン駆動設計)](ddd.md)を参照してください。

例
-------------------------

```php
final class CreateNoteAction
{
    public function __construct(private CreateNoteService $service)
    {
    }

    public function __invoke(CreateNoteRequest $request): NoteResource
    {
        $note = $this->service->execute(
            $request->user(),
            $request->validated(),
        );

        return new NoteResource($note);
    }
}
```

```php
final class CreateNoteService
{
    public function __construct(private NoteRepositoryInterface $notes)
    {
    }

    public function execute(User $user, array $data): Note
    {
        return $this->notes->create($user, $data);
    }
}
```

```php
interface NoteRepositoryInterface
{
    public function create(User $user, array $data): Note;
}
```

```php
final class EloquentNoteRepository implements NoteRepositoryInterface
{
    public function create(User $user, array $data): Note
    {
        return $user->notes()->create($data);
    }
}
```

```php
final class NoteServiceProvider extends ServiceProvider
{
    public function register(): void
    {
        $this->app->bind(
            NoteRepositoryInterface::class,
            EloquentNoteRepository::class,
        );
    }
}
```

生成コマンド
-------------------------

```text
php artisan make:controller Note/CreateNoteController --invokable
php artisan make:class Actions/Note/CreateNoteAction --invokable
php artisan make:class Domain/Note/Service/CreateNoteService
php artisan make:class Domain/Note/Repository/NoteRepositoryInterface
php artisan make:class Infrastructure/Persistence/EloquentNoteRepository
php artisan make:request Note/CreateNoteRequest
php artisan make:resource Note/NoteResource
php artisan make:provider NoteServiceProvider
```

`make:controller`は、Laravel標準のコントローラ配置に合わせる場合の例です。
`make:interface`は`app/Contracts`や`app/Interfaces`を起点にするため、`app/Domain`へ直接は生成しません。
Domainのリポジトリインターフェースは`make:class`で生成し、`class`を`interface`へ変更します。

ActionをHTTP入口にする場合は、ルートから`CreateNoteAction`を直接指定できます。
Laravel標準のコントローラ配置に合わせる場合は、`app/Http/Controllers`に置くか、薄いコントローラからActionを呼びます。

使いどころ
-------------------------

- 1つのユーザー操作が複数のモデルや外部APIにまたがる
- HTTP、CLI、ジョブから同じ処理を呼ぶ
- Domain ServiceをHTTPから独立してテストしたい
- Repositoryを差し替えてテストしたい

注意点
-------------------------

- ファイル数が増える
- EloquentモデルとDomainのEntityを分けると変換コストが増える
- RepositoryがEloquentの薄いラッパーになりやすい
- 単純なCRUDには過剰
- 全体へ一括適用せず、1機能で試す

関連ドキュメント
-------------------------

- [アーキテクチャ参考資料](index.md)
- [Laravel標準MVCとService層](mvc_service_layer.md)
- [DDD(ドメイン駆動設計)](ddd.md)
- [レイヤード・ヘキサゴナル・オニオン・Clean Architecture](layered_hexagonal_clean.md)
- [Laravelのmakeコマンド一覧](../laravel_make_commands.md)
