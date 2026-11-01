コーディング規約
=========================

Laravel学習用サンプルアプリケーションのコーディング規約をまとめます。

改行コードとインデントのルール
-------------------------

基本的なコーディングスタイルは`.editorconfig`に従います。

- 文字コード: UTF-8
- 改行コード: LF
- インデント: スペース
- インデント幅: 2スペース(既定)
- 行末のスペース: 削除する
- ファイル末尾: 改行を入れる

言語別のインデント設定は次のとおりです。

- PHP(`*.php`): 4スペース
- Markdown(`*.md`): 4スペース、行末のスペースを削除しない

言語別のコーディング規約
-------------------------

### PHP

- フォーマッター: `laravel/pint`
- `pint.json`で`laravel`プリセットを適用する
- `.editorconfig`により、文字コードUTF-8・改行コードLF・インデント4スペースが適用される
- 静的解析: `larastan/larastan`(PHPStanのLaravel拡張)
- 解析設定は`phpstan.neon`で管理し、レベル5・対象は`app/`とする

詳細は[pint.json](../pint.json)と[phpstan.neon](../phpstan.neon)を参照してください。

### JavaScript・CSS

- フォーマッター: Prettier(`prettier ^3.9`)
- 設定: `.prettierrc.yml`
- 主な設定: 折り返し120文字、シングルクォート
- 対象: JavaScriptとCSS
- 除外: `.prettierignore`(Markdown・YAML・JSON・HTML・Blade・生成物)

### Markdown

規約は`.markdownlint.yml`に基づきます。
既定で全ルールが有効になり、ファイル内の明示設定が優先されます。

- 見出しスタイル: h1とh2はsetext記法、h3以降はatx記法
- 見出しレベルは1つずつ増やす
- 箇条書きをネストする場合のインデントは4スペース
- 箇条書きの記号は統一する
- 行の長さは最大100文字(コードブロックと表は対象外)

詳細は[.markdownlint.yml](../.markdownlint.yml)を参照してください。

Gitフック
-------------------------

`.pre-commit-config.yaml`により、コミット時に次のチェックを実行します。

- PHP: `php -l`による構文チェック、Pintによる整形、PHPStan(Larastan)による静的解析
- JavaScript・CSS: Prettierによる整形
- Markdown: markdownlintによる検査と自動修正
- 共通: 秘密情報の検出(`gitleaks`)、大容量ファイル・改行コード・末尾空白の検査

Dev Containerでは`post_start.sh`が`pre-commit install`を実行し、フックを有効にします。
