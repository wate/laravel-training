git-flow-nextの設定
=================================

概要
-------------------------

git-flow-nextはすべての設定を`gitflow.*`名前空間へ保存し、
ブランチの切り方を自由に定義できます。
ブランチは寿命の長い`base`と、作業用の`topic`の2種類で表します。

### 設定の優先順位

1. コマンドラインのフラグ
2. コマンド単位の上書き(`gitflow.<type>.<command>.*`)
3. ブランチ種別の既定値(`gitflow.branch.<type>.*`)

設定は既定で`.git/config`へ保存します。
`git flow init --shared`を使うと、リポジトリ直下の`.gitflow`へ保存してチームで共有できます。

ブランチの種類
-------------------------

### baseブランチ

`master`・`staging`・`develop`など、常に存在するブランチです。
設定では`type = base`を指定します。

- `parent`: マージ先になる親ブランチです
- `upstreamstrategy`: 親ブランチへマージするときの戦略です
- `downstreamstrategy`: 親ブランチから取り込むときの戦略です
- `autoupdate`: 完了時に親ブランチの変更を取り込みます

### topicブランチ

`feature/*`や`hotfix/*`など、作業用に一時的に作るブランチです。
設定では`type = topic`を指定します。

- `parent`: マージ先になる親ブランチです
- `startpoint`: 作成元になるブランチです。省略時は`parent`と同じです
- `prefix`: ブランチ名の接頭辞です。既定は`<type>/`です
- `upstreamstrategy`: 親ブランチへマージするときの戦略です
- `downstreamstrategy`: 親ブランチから取り込むときの戦略です
- `tag`: 完了時にタグを作成します
- `tagprefix`: タグの接頭辞です
- `forcedelete`: マージ未完了でもブランチを削除します
- `worktree`: 作業用のworktreeを自動作成します

### 名前の読み方

`upstream`は親ブランチへ戻す向き、`downstream`は親ブランチから取り込む向きを指します。
直感と逆に見えるため、設定を読むときは向きを意識します。

設定キー
-------------------------

設定キーは`gitflow.branch.<名前>.<キー>`の形式です。

| キー                 | 対象        | 内容                       | 既定値           |
| -------------------- | ----------- | -------------------------- | ---------------- |
| `type`               | base・topic | ブランチの種類             | なし             |
| `parent`             | base・topic | マージ先の親ブランチ       | なし             |
| `startpoint`         | topic       | 作成元のブランチ           | `parent`         |
| `prefix`             | topic       | ブランチ名の接頭辞         | `<type>/`        |
| `upstreamstrategy`   | base・topic | 親へマージするときの戦略   | プリセットによる |
| `downstreamstrategy` | base・topic | 親から取り込むときの戦略   | プリセットによる |
| `autoupdate`         | base        | 完了時に親の変更を取り込む | `false`          |
| `tag`                | topic       | 完了時にタグを作成する     | `false`          |
| `tagprefix`          | topic       | タグの接頭辞               | なし             |
| `forcedelete`        | topic       | 未マージでも削除する       | `false`          |
| `worktree`           | topic       | worktreeを自動作成する     | `false`          |

マージ戦略
-------------------------

| 値       | 動作                                       |
| -------- | ------------------------------------------ |
| `merge`  | マージコミットを作成し、履歴を残します     |
| `rebase` | 対象ブランチへrebaseし、履歴を直線にします |
| `squash` | すべてのコミットを1つにまとめます          |
| `none`   | 自動マージを行いません                     |

`none`はbaseブランチでのみ使用できます。

設定コマンド
-------------------------

- 一覧表示: `git flow config list`
- baseブランチの追加: `git flow config add base <名前> [親]`
- topicブランチ種別の追加: `git flow config add topic <名前> <親>`
- 設定の変更: `git flow config edit topic <名前>`
- 名前の変更: `git flow config rename base <旧名> <新名>`
- 設定の削除: `git flow config delete topic <名前>`

### プリセットによる初期化

プリセットを使うと、代表的な構成をまとめて設定できます。

```bash
git flow init --preset=classic
```

プロジェクト固有の定義例は、[Git運用フロー](../git_workflow.md)を参照してください。

### 共有設定の例

`.gitflow`へ保存する場合は、同じキーをINI形式で記述します。

```ini
[gitflow]
    version = 1.0
    initialized = true
[gitflow "branch.main"]
    type = base
[gitflow "branch.develop"]
    type = base
    parent = main
    autoupdate = true
[gitflow "branch.feature"]
    type = topic
    parent = develop
    prefix = feature/
    upstreamstrategy = merge
    downstreamstrategy = rebase
```

参考
-------------------------

- [git-flow-nextの設定](https://git-flow.sh/docs/configuration/)
- [git-flow-nextのコマンド](https://git-flow.sh/docs/commands)
