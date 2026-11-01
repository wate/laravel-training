Laravel公式パッケージ一覧
=========================

概要
-------------------------

Laravel 13.xの公式ドキュメントに掲載されているパッケージを中心に、Laravel公式のパッケージとツールを分類してまとめます。
各パッケージの用途と公式ページへのリンクを確認できます。
対象は公式ドキュメントに掲載されているパッケージと、本プロジェクトが利用する公式パッケージです。
GitHub organizationのすべてのリポジトリを対象にはしていません。

確認先
-------------------------

- [Laravel 13.x ドキュメント](https://laravel.com/docs/13.x/documentation): 公式パッケージの目次
- [Laravel GitHub organization](https://github.com/laravel): 公開リポジトリの一覧
- [Laravel Starter Kits](https://laravel.com/starter-kits): スターターキットの公式ページ

フレームワークと開発ツール
--------------------------

| パッケージ                     | 用途                         | 公式ページ                                                |
| ------------------------------ | ---------------------------- | --------------------------------------------------------- |
| `laravel/framework`            | Laravel本体                  | [ドキュメント](https://laravel.com/docs/13.x)             |
| `laravel/installer`            | プロジェクト作成CLI          | [GitHub](https://github.com/laravel/installer)            |
| `laravel/tinker`               | 対話型REPL                   | [ドキュメント](https://laravel.com/docs/13.x/artisan)     |
| `laravel/pint`                 | PHPコードフォーマッター      | [ドキュメント](https://laravel.com/docs/13.x/pint)        |
| `laravel/pail`                 | ログのリアルタイム表示       | [GitHub](https://github.com/laravel/pail)                 |
| `laravel/pao`                  | AIエージェント向けの出力整形 | [GitHub](https://github.com/laravel/pao)                  |
| `laravel/prompts`              | CLIの対話プロンプト          | [ドキュメント](https://laravel.com/docs/13.x/prompts)     |
| `laravel/agent-detector`       | AIエージェント環境の判定     | [GitHub](https://github.com/laravel/agent-detector)       |
| `laravel/serializable-closure` | クロージャのシリアライズ     | [GitHub](https://github.com/laravel/serializable-closure) |

認証とAPI
-------------------------

| パッケージ          | 用途             | 公式ページ                                              |
| ------------------- | ---------------- | ------------------------------------------------------- |
| `laravel/fortify`   | 認証バックエンド | [ドキュメント](https://laravel.com/docs/13.x/fortify)   |
| `laravel/sanctum`   | APIトークン認証  | [ドキュメント](https://laravel.com/docs/13.x/sanctum)   |
| `laravel/passport`  | OAuth2サーバー   | [ドキュメント](https://laravel.com/docs/13.x/passport)  |
| `laravel/socialite` | SNSログイン      | [ドキュメント](https://laravel.com/docs/13.x/socialite) |

各パッケージの詳細は[Fortify](fortify.md)、[Sanctum](sanctum.md)、[Passport](passport.md)、[Socialite](socialite.md)を参照してください。

決済
-------------------------

| パッケージ               | 用途       | 公式ページ                                                   |
| ------------------------ | ---------- | ------------------------------------------------------------ |
| `laravel/cashier`        | Stripe決済 | [ドキュメント](https://laravel.com/docs/13.x/billing)        |
| `laravel/cashier-paddle` | Paddle決済 | [ドキュメント](https://laravel.com/docs/13.x/cashier-paddle) |

アプリケーション機能
-------------------------

| パッケージ             | 用途                               | 公式ページ                                                 |
| ---------------------- | ---------------------------------- | ---------------------------------------------------------- |
| `laravel/scout`        | 全文検索                           | [ドキュメント](https://laravel.com/docs/13.x/scout)        |
| `laravel/pennant`      | フィーチャーフラグ                 | [ドキュメント](https://laravel.com/docs/13.x/pennant)      |
| `laravel/folio`        | ページベースのルーティング         | [ドキュメント](https://laravel.com/docs/13.x/folio)        |
| `laravel/head`         | head要素のメタデータ管理           | [ドキュメント](https://laravel.com/docs/13.x/head)         |
| `laravel/precognition` | フロントエンドの事前バリデーション | [ドキュメント](https://laravel.com/docs/13.x/precognition) |

`laravel/precognition`の詳細は[Precognition](precognition.md)を参照してください。

インフラと運用
-------------------------

| パッケージ          | 用途                         | 公式ページ                                              |
| ------------------- | ---------------------------- | ------------------------------------------------------- |
| `laravel/horizon`   | Redisキューの監視            | [ドキュメント](https://laravel.com/docs/13.x/horizon)   |
| `laravel/reverb`    | WebSocketサーバー            | [ドキュメント](https://laravel.com/docs/13.x/reverb)    |
| `laravel/octane`    | 高速アプリケーションサーバー | [ドキュメント](https://laravel.com/docs/13.x/octane)    |
| `laravel/pulse`     | パフォーマンス監視           | [ドキュメント](https://laravel.com/docs/13.x/pulse)     |
| `laravel/telescope` | デバッグ支援                 | [ドキュメント](https://laravel.com/docs/13.x/telescope) |
| `laravel/envoy`     | リモートサーバーのタスク実行 | [ドキュメント](https://laravel.com/docs/13.x/envoy)     |
| `laravel/sail`      | Docker開発環境               | [ドキュメント](https://laravel.com/docs/13.x/sail)      |
| `laravel/valet`     | macOS向け開発環境            | [ドキュメント](https://laravel.com/docs/13.x/valet)     |
| `laravel/homestead` | Vagrantベースの開発環境      | [ドキュメント](https://laravel.com/docs/13.x/homestead) |

`laravel/envoy`の詳細は[Envoy](envoy.md)を参照してください。
`laravel/sail`と`laravel/homestead`の詳細は[Sail](sail.md)と[Homestead](homestead.md)を参照してください。
`laravel/telescope`の詳細は[Telescope](telescope.md)を参照してください。

テスト
-------------------------

| パッケージ     | 用途           | 公式ページ                                         |
| -------------- | -------------- | -------------------------------------------------- |
| `laravel/dusk` | ブラウザテスト | [ドキュメント](https://laravel.com/docs/13.x/dusk) |

`laravel/dusk`の詳細は[Dusk](dusk.md)を参照してください。

AI
-------------------------

| パッケージ      | 用途                      | 公式ページ                                           |
| --------------- | ------------------------- | ---------------------------------------------------- |
| `laravel/ai`    | AI SDK                    | [ドキュメント](https://laravel.com/docs/13.x/ai-sdk) |
| `laravel/mcp`   | MCPサーバーとクライアント | [ドキュメント](https://laravel.com/docs/13.x/mcp)    |
| `laravel/boost` | AI開発支援                | [ドキュメント](https://laravel.com/docs/13.x/boost)  |

フロントエンド
-------------------------

| パッケージ          | 用途                           | 公式ページ                                                 |
| ------------------- | ------------------------------ | ---------------------------------------------------------- |
| `laravel/wayfinder` | TypeScript向けのルート定義生成 | [GitHub](https://github.com/laravel/wayfinder)             |
| `laravel-echo`      | WebSocketクライアント          | [ドキュメント](https://laravel.com/docs/13.x/broadcasting) |
| `laravel-mix`       | Vite以前のアセットビルド       | [ドキュメント](https://laravel.com/docs/13.x/mix)          |

`laravel/wayfinder`はBeta版です。
`laravel-echo`と`laravel-mix`はnpmで導入します。

スターターキット
-------------------------

| パッケージ          | 用途                             | 公式ページ                                                 |
| ------------------- | -------------------------------- | ---------------------------------------------------------- |
| `laravel/breeze`    | 認証UIの最小構成                 | [ドキュメント](https://laravel.com/docs/13.x/starter-kits) |
| `laravel/jetstream` | 認証UIとチーム機能               | [ドキュメント](https://laravel.com/docs/13.x/starter-kits) |
| `laravel/ui`        | レガシーな認証UIスキャフォールド | [GitHub](https://github.com/laravel/ui)                    |

`laravel/ui`はレガシー扱いですが、Laravel 13でも動作し、互換性の更新は継続しています。
READMEではBreezeまたはJetstreamが推奨されていますが、どちらもLaravel 12以降は更新が終了しています。

商用パッケージ
-------------------------

| パッケージ             | 用途           | 公式ページ                                     |
| ---------------------- | -------------- | ---------------------------------------------- |
| `laravel/nova`         | 管理画面       | [ドキュメント](https://nova.laravel.com/docs)  |
| `laravel/spark-stripe` | SaaS向けの課金 | [ドキュメント](https://spark.laravel.com/docs) |

関連ドキュメント
-------------------------

- [Laravel系パッケージの整理](../laravel_packages.md): 本プロジェクトで使用中のパッケージ
