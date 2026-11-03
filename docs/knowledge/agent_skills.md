エージェントスキルとskills CLI
=============================

概要
-------------------------

公開されているエージェントスキルを`npx skills`コマンドで取り込み、
リポジトリへ組み込む方法をまとめます。
スキルは`SKILL.md`を入口とする指示と参照ファイルのまとまりです。
配布元はGitHubリポジトリやURLで指定します。

取り込みの流れ
-------------------------

1. 配布元のスキルを探します。

    ```bash
    npx skills find <query>
    ```

    [skills.sh](https://skills.sh/)からも探せます。

2. 配布元で追加できるスキルを確認します。

    ```bash
    npx skills add <owner>/<repo> --list
    ```

3. 必要なスキルを追加します。

    ```bash
    npx skills add <owner>/<repo> --skill <name>
    ```

4. 取り込み結果を確認します。

    ```bash
    npx skills list
    ```

`npx skills add`はスキルの実体を`.agents/skills/`へ配置します。
あわせて、検出されたエージェント向けのリンクを自動で用意します。

追加したスキルは`skills-lock.json`へ記録されます。
`skills-lock.json`には配布元と`computedHash`が入り、更新の判定に使われます。
このファイルをリポジトリへ含めると、他の環境で同じ構成を復元できます。

コマンド一覧
-------------------------

| 目的                     | コマンド                                                |
| ------------------------ | ------------------------------------------------------- |
| 配布元をキーワードで検索 | `npx skills find <query>`                               |
| 配布元のスキル一覧確認   | `npx skills add <owner>/<repo> --list`                  |
| スキルの追加             | `npx skills add <owner>/<repo> --skill <name>`          |
| 複数スキルの追加         | `npx skills add <owner>/<repo> --skill <name1> <name2>` |
| 配布元の全スキル追加     | `npx skills add <owner>/<repo> --all`                   |
| 導入せずに試す           | `npx skills use <owner>/<repo>@<skill>`                 |
| 導入済みスキルの確認     | `npx skills list`                                       |
| スキルの更新             | `npx skills update`                                     |
| 特定スキルの更新         | `npx skills update <name>`                              |
| スキルの削除             | `npx skills remove <name>`                              |
| ロックファイルからの復元 | `npx skills experimental_install`                       |

`-p`はプロジェクト、`-g`はユーザー全体を対象にします。
`-y`は確認プロンプトを省略します。
`add`は既定でプロジェクトへ導入します。

取り込んだスキルの管理
-------------------------

### 更新する

配布元の最新版を取り込むには、次のコマンドを実行します。

```bash
npx skills update -p
```

特定のスキルだけを更新する場合は、スキル名を指定します。

```bash
npx skills update <name> -p
```

更新すると`skills-lock.json`の`computedHash`が更新されます。
更新後は`npx skills list`で状態を確認します。

### 削除する

```bash
npx skills remove <name>
```

スキル名を省略すると対話形式で選択します。
`--all`を付けると導入済みのスキルをすべて削除します。
削除すると`.agents/skills/<name>/`と`skills-lock.json`のエントリが削除されます。

### 復元する

`skills-lock.json`を共有した環境では、次のコマンドで同じ構成を復元します。

```bash
npx skills experimental_install
```

`--dry-run`を付けると、変更内容の確認だけを行います。
`--force`を付けると、導入済みのスキルも再導入します。
CI環境では`--frozen-lockfile`が既定で有効になり、ロックファイルの変更を防ぎます。

取り込み時の注意
-------------------------

追加したスキルはエージェントの権限で動作します。
配布元の`SKILL.md`と参照ファイルを確認してから取り込んでください。

配布元に変更があると、`update`の実行でローカルの内容は配布版に置き換わります。
そのため`.agents/skills/`の直接編集は避けてください。

配布元が更新されていない場合、`update`はローカル編集を変更として検出しません。
編集内容は残りますが、次に配布元が更新された時点で失われる可能性があります。

補足
-------------------------

`experimental_sync`は`node_modules`のスキルを同期する実験的なコマンドです。
GitHubリポジトリを配布元にする場合は`add`と`update`を使います。

関連ドキュメント
-------------------------

- [ナレッジ索引](index.md)
- [Laravelプロジェクトのセットアップ](laravel_project_setup.md)
- [ディレクトリ構造](../directory_structure.md)
- [skills CLIのリポジトリ](https://github.com/vercel-labs/skills)
- [skills.sh](https://skills.sh/)
