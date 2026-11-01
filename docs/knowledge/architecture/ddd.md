DDD(ドメイン駆動設計)
=========================

概要
-------------------------

DDDは、複雑な業務領域をモデル化し、コードと業務の言葉を近づける設計手法です。
ディレクトリ構成や層の分け方ではなく、業務知識の整理とモデリングが中心です。
Laravel標準のMVCと対立するものではなく、必要な範囲で組み合わせます。

DDDが向くケース
-------------------------

- 業務ルールが複雑
- 関係者が多く、用語の統一が必要
- 長期運用で仕様変更が多い
- 複数のサブドメインがある
- 単純なCRUDでは表現しきれない

向かないケースは次のとおりです。

- 画面とテーブルのCRUDが中心
- 業務ルールが少ない
- 短期間で作り切る
- チームがDDDに不慣れで、学習コストを取れない

戦略的設計
-------------------------

### 境界づけられたコンテキスト

同じ言葉でも意味が変わる範囲を区切ります。
例えば「注文」は、販売、配送、請求で意味が異なる場合があります。

### ユビキタス言語

業務担当者と開発者が同じ言葉を使います。
クラス名、メソッド名、テーブル名、画面文言を揃えます。

### コンテキストマップ

コンテキスト同士の関係を整理します。
共有カーネル、顧客・供給者、防腐層などを必要に応じて使います。

### サブドメイン

業務を中核、支援、一般のサブドメインに分けます。
中核だけにDDDを適用する方針もあります。

戦術的設計
-------------------------

| パターン       | 役割                         | Laravelでの例                           |
| -------------- | ---------------------------- | --------------------------------------- |
| Entity         | 識別子を持つ業務オブジェクト | `app/Domain/Note/Entity/Note`           |
| Value Object   | 値で比較する不変オブジェクト | `app/Domain/Note/ValueObject/NoteTitle` |
| Aggregate      | 整合性を保つ境界             | `Note`と`Comment`のまとまり             |
| Repository     | 永続化の境界                 | `NoteRepositoryInterface`               |
| Domain Service | Entityに収まらない業務処理   | `CreateNoteService`                     |
| Domain Event   | 業務上の出来事               | `NotePublished`                         |
| Factory        | 複雑な生成処理               | `NoteFactory`                           |

LaravelではEloquentモデルがActive Recordとして永続化も担当します。
DDDでEntityを別に作る場合は、Eloquentモデルとの変換が必要です。

ディレクトリ例
-------------------------

```text
app/
├ Domain/
│   └ Note/
│       ├ Entity/
│       │   └ Note.php
│       ├ ValueObject/
│       │   └ NoteTitle.php
│       ├ Repository/
│       │   └ NoteRepositoryInterface.php
│       ├ Service/
│       │   └ CreateNoteService.php
│       └ Event/
│           └ NotePublished.php
├ Application/
│   └ Note/
│       └ UseCase/
│           └ CreateNoteUseCase.php
├ Infrastructure/
│   └ Persistence/
│       └ EloquentNoteRepository.php
├ Models/
│   └ Note.php
└ Providers/
    └ NoteServiceProvider.php
```

生成コマンド
-------------------------

```text
php artisan make:class Domain/Note/Entity/Note
php artisan make:class Domain/Note/ValueObject/NoteTitle
php artisan make:class Domain/Note/Repository/NoteRepositoryInterface
php artisan make:class Domain/Note/Service/CreateNoteService
php artisan make:class Domain/Note/Event/NotePublished
php artisan make:class Application/Note/UseCase/CreateNoteUseCase
php artisan make:class Infrastructure/Persistence/EloquentNoteRepository
php artisan make:provider NoteServiceProvider
```

`make:interface`は`app/Contracts`や`app/Interfaces`を起点にするため、`app/Domain`へ直接は生成しません。
Domainのリポジトリインターフェースは`make:class`で生成し、`class`を`interface`へ変更します。

Laravelのイベントとしてキューに流す場合は`make:event`を使い、生成後に`app/Domain`へ移動して名前空間を調整します。

Value Objectの例
-------------------------

```php
final readonly class NoteTitle
{
    public function __construct(public string $value)
    {
        if (trim($value) === '') {
            throw new InvalidArgumentException('タイトルは必須です。');
        }
    }
}
```

Entityの例
-------------------------

```php
final class Note
{
    public function __construct(
        public readonly NoteId $id,
        public NoteTitle $title,
        public NoteStatus $status,
    ) {
    }

    public function publish(): void
    {
        if ($this->status === NoteStatus::Published) {
            throw new InvalidNoteStateException('すでに公開済みです。');
        }

        $this->status = NoteStatus::Published;
    }
}
```

Repositoryの例
-------------------------

```php
interface NoteRepositoryInterface
{
    public function findById(NoteId $id): ?Note;

    public function save(Note $note): void;
}
```

```php
final class EloquentNoteRepository implements NoteRepositoryInterface
{
    public function findById(NoteId $id): ?Note
    {
        $model = NoteModel::find($id->value);

        return $model ? $this->toDomain($model) : null;
    }

    public function save(Note $note): void
    {
        NoteModel::updateOrCreate(
            ['id' => $note->id->value],
            ['title' => $note->title->value, 'status' => $note->status->value],
        );
    }
}
```

Clean Architectureとの関係
--------------------------

DDDは業務知識のモデリング、Clean Architectureは依存方向と層の構成です。
組み合わせて使えますが、DDDを採用するためにClean Architectureが必須ではありません。
Laravel標準のMVCに、Entity、Value Object、Repositoryだけを部分的に取り入れる形もあります。
層構成の詳細は[レイヤード・ヘキサゴナル・オニオン・Clean Architecture](layered_hexagonal_clean.md)を参照してください。

導入の目安
-------------------------

- 最初から全体へ適用しない
- 中核となる1つの境界づけられたコンテキストから始める
- ユビキタス言語を決める
- Value Objectから試す
- Repositoryは永続化を差し替える必要が出てから検討する
- Eloquentモデルを残すか、Domain Entityへ分けるかを機能ごとに決める

注意点
-------------------------

- DDDはファイル構成ではなく、業務のモデリングが中心
- すべての機能に同じ構成を強制しない
- EntityとEloquentモデルの二重管理に注意する
- RepositoryがEloquentの薄いラッパーになりやすい
- トランザクションの境界を決める
- 用語の統一には継続的な運用が必要

関連ドキュメント
-------------------------

- [アーキテクチャ参考資料](index.md)
- [レイヤード・ヘキサゴナル・オニオン・Clean Architecture](layered_hexagonal_clean.md)
- [ADR(Action-Domain-Responder)](adr_action_domain_responder.md)
- [Laravelのmakeコマンド一覧](../laravel_make_commands.md)
