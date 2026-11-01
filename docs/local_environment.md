ローカル開発環境
=========================

概要
-------------------------

ローカル開発環境の構築手順をまとめるドキュメントです。
環境に関する手順は、このドキュメントへ集約します。

アセット生成
-------------------------

- `public/vendor`: `composer install`時に`adminlte:install --only=assets`で生成します
- `public/build`: `npm run build`で生成します
- `composer install --no-scripts`を使う場合は、`php artisan adminlte:install --only=assets`を別途実行します

Dev Containerの構成
-------------------------

- 設定は`.devcontainer/`に配置しています
- PHP 8.3以上
- Node.js 24
- MariaDB 11
- Apache(ポート8080)
- Mailpit(ポート8025・1025)

ポート
-------------------------

| ポート | 用途                                |
| ------ | ----------------------------------- |
| 8080   | Apache(アプリ本体)                  |
| 8000   | `php artisan serve`・`composer dev` |
| 5173   | Vite開発サーバー(HMR)               |
| 8025   | MailpitのWeb UI                     |
| 1025   | MailpitのSMTP                       |
| 3306   | MariaDB                             |

Viteを継続利用するため、ポートを変更した場合はこの表を更新します。

利用手順
-------------------------

1. VS Codeで「Reopen in Container」を実行します
2. コンテナ起動時の自動セットアップが完了するのを待ちます
3. `http://localhost:8080`でアクセスします

セットアップは`.devcontainer/provision/post_start.sh`が毎回の起動時に冪等に実行します。

Viteの開発サーバーを使う場合は、別ターミナルで`npm run dev`を実行します。

E2Eテスト
-------------------------

- コンテナ起動時に`post_start.sh`がブラウザ本体を導入します
- `npm run test:e2e`で`tests/e2e`を実行します
- 既定の接続先は`http://localhost:8080`です
- ブラウザ導入に失敗した場合は、コンテナ内で`npx playwright install chromium`を実行します

既定の構成
-------------------------

Laravelのスケルトンはシンプルな構成で、データベースはSQLiteを使用します。
Dev ContainerではMariaDB 11を使用します。

関連ドキュメント
-------------------------

- [Laravelプロジェクトのセットアップ](knowledge/laravel_project_setup.md): スケルトン作成と調整
- [技術スタック](technology.md): 使用技術とバージョン
