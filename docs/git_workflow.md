Git運用フロー
=========================

概要
-------------------------

git-flowを元にした運用方法を採用しています。
git-flowは`release/*`ブランチを使用しますが、
本プロジェクトでは`staging`ブランチのみを使用します。

### 参考URL

- [Gitflowワークフロー](https://www.atlassian.com/ja/git/tutorials/comparing-workflows/gitflow-workflow)

ブランチ構成
-------------------------

| ブランチ    | 役割                                                 | 派生元      | マージ先            |
| ----------- | ---------------------------------------------------- | ----------- | ------------------- |
| `master`    | リリース済みの状態を保持し、本番環境へデプロイします | `staging`   | なし                |
| `staging`   | ステージング環境へデプロイします                     | `develop`   | `master`            |
| `develop`   | 開発環境へデプロイします                             | `feature/*` | `staging`           |
| `feature/*` | 新機能を開発します                                   | `develop`   | `develop`           |
| `hotfix/*`  | 緊急の修正を行います                                 | `master`    | `master`と`develop` |

作業ブランチ以外へは直接コミットせず、マージで反映します。
リポジトリの既定ブランチが`main`の場合は、`master`を`main`に読み替えてください。

設定例
-------------------------

git-flow-nextを利用する場合は、次のコマンドで設定します。

```bash
git flow config add base master
git flow config add base staging master --auto-update=true
git flow config add base develop staging --auto-update=true
git flow config add topic feature develop --prefix=feature/ --upstream-strategy=merge --downstream-strategy=rebase
git flow config add topic hotfix master --prefix=hotfix/ --upstream-strategy=merge --downstream-strategy=rebase --tag=false
```

設定は`git flow config list`で確認できます。

操作コマンド
-------------------------

- 機能開発の開始: `git flow feature start <名前>`
- 機能開発の完了: `git flow feature finish <名前>`
- 親ブランチの取り込み: `git flow feature update`
- 緊急修正の開始: `git flow hotfix start <名前>`
- 緊急修正の完了: `git flow hotfix finish <名前>`
- ステージングへの反映: `git flow integrate develop`で`staging`へマージします
- 本番への反映: `git flow integrate staging`で`master`へマージします

コミットのルール
-------------------------

- ステージングの対象は、自分が変更したファイルに限定します
- 1つのコミットには1つの目的だけを含めます
- 一括追加は行わず、ファイルを個別に指定します
- コミット前に`git status`と差分を確認します

詳細は[Git運用プロセス](../.github/processes/git.md)を参照してください。

参考
-------------------------

- [git-flow-next](https://git-flow.sh/)
