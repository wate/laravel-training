レイヤード・ヘキサゴナル・オニオン・Clean Architecture
======================================================

概要
-------------------------

層の分け方と依存方向を整理するための参考資料です。
レイヤードは層を上下に分ける考え方、ヘキサゴナル・オニオン・Clean Architectureは依存方向を内側へ向ける考え方です。
DDDは業務知識のモデリング手法で、層構成とは別の話題です。
詳細は[DDD(ドメイン駆動設計)](ddd.md)を参照してください。

共通する考え方
-------------------------

- ドメインや業務ルールを外側の技術から独立させる
- HTTP、DB、メールなどの技術詳細を外側へ置く
- 依存方向を内側へ向ける
- インターフェースで境界を定義する
- テストしやすい単位に分ける

比較
-------------------------

| パターン           | 層の例                                                   | 特徴                     | 注意                       |
| ------------------ | -------------------------------------------------------- | ------------------------ | -------------------------- |
| レイヤード         | プレゼンテーション、アプリケーション、ドメイン、インフラ | 理解しやすい             | 層の境界が曖昧になりやすい |
| ヘキサゴナル       | ドメイン、Ports、Adapters                                | 外部技術を差し替えやすい | インターフェースが増える   |
| オニオン           | ドメイン、アプリケーション、インフラ                     | ドメインを中心に置く     | Clean Architectureに近い   |
| Clean Architecture | Entity、UseCase、Interface Adapter、Framework            | 依存方向を明確にできる   | 儀式が多い                 |

ディレクトリ例
-------------------------

### レイヤード

```text
app/
├ Http/
├ Services/
├ Models/
└ Repositories/
```

### ヘキサゴナル

```text
app/
├ Domain/
│   ├ Port/
│   └ Service/
├ Application/
├ Infrastructure/
│   └ Adapter/
└ Http/
```

### Clean Architecture

```text
app/
├ Domain/
│   ├ Entity/
│   └ ValueObject/
├ Application/
│   └ UseCase/
├ Infrastructure/
│   └ Persistence/
└ Presentation/
    └ Http/
```

Laravelとの対応
-------------------------

| 構成要素                   | Laravelの候補                                              |
| -------------------------- | ---------------------------------------------------------- |
| Action                     | invokableコントローラ、`app/Actions`                       |
| UseCase                    | `app/Application/UseCase`、`app/Services`                  |
| Entity                     | Eloquentモデル、または`app/Domain/Entity`                  |
| Value Object               | `app/Domain/ValueObject`                                   |
| Repositoryインターフェース | `app/Domain/.../Repository`                                |
| Repository実装             | `app/Infrastructure/Persistence`                           |
| Ports                      | Repositoryインターフェース、外部サービスのインターフェース |
| Adapters                   | Eloquent実装、HTTPクライアント、メール送信                 |
| Provider                   | インターフェースと実装の紐付け                             |

LaravelではEloquentモデルがActive Recordとして永続化も担当します。
DomainのEntityを別に作る場合は、Eloquentモデルとの変換処理が必要です。
Entity、Value Object、Repositoryの詳しい設計は[DDD(ドメイン駆動設計)](ddd.md)を参照してください。

生成コマンド
-------------------------

```text
php artisan make:controller Note/CreateNoteController --invokable
php artisan make:class Application/Note/UseCase/CreateNoteUseCase
php artisan make:class Domain/Note/Entity/Note
php artisan make:class Domain/Note/ValueObject/NoteTitle
php artisan make:class Domain/Note/Repository/NoteRepositoryInterface
php artisan make:class Infrastructure/Persistence/EloquentNoteRepository
php artisan make:provider NoteServiceProvider
```

`make:interface`は`app/Contracts`や`app/Interfaces`を起点にするため、`app/Domain`へ直接は生成しません。
インターフェースは`make:class`で生成し、`class`を`interface`へ変更します。

コストと注意点
-------------------------

- ファイル数と間接参照が増える
- EloquentモデルとDomainのEntityの変換が増える
- RepositoryがEloquentの薄いラッパーになりやすい
- トランザクションの境界が分かりにくくなる
- テストの種類と配置を決める必要がある
- 全体へ一括適用すると過剰設計になりやすい

判断の目安
-------------------------

- 単純なCRUD: MVC
- 複数モデルや外部APIをまたぐ: Service
- 複数の入口から同じ処理を呼ぶ: UseCase
- データソースを差し替える: Repository
- 業務ルールが複雑で長期運用する: [DDD(ドメイン駆動設計)](ddd.md)やClean Architectureを1機能で試す
- 読み書きの形が大きく違う: CQRS
- 監査や履歴が中心: Event Sourcing

関連ドキュメント
-------------------------

- [アーキテクチャ参考資料](index.md)
- [Laravel標準MVCとService層](mvc_service_layer.md)
- [ADR(Action-Domain-Responder)](adr_action_domain_responder.md)
- [DDD(ドメイン駆動設計)](ddd.md)
- [Laravelのmakeコマンド一覧](../laravel_make_commands.md)
