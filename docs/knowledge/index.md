ナレッジ
=========================

概要
-------------------------

学習や開発で得た知識をトピックごとに蓄積するディレクトリです。
このファイルは学習した知識の目次として使用します。

目次
-------------------------

- [Laravelプロジェクトのセットアップ](laravel_project_setup.md): 技術スタックの決定とスケルトン調整
- [Laravelのmakeコマンド一覧](artisan_commands/make.md): makeコマンドの全体像とコマンド一覧
- [Laravelのartisanコマンド一覧](artisan_commands/index.md): make以外のよく使うコマンドと使い分け
- [アーキテクチャ参考資料](architecture/index.md): MVC、Clean Architecture、DDDなどの比較
- [Laravelスケルトンの既定テーブル](laravel_default_tables.md): 既定テーブルと役割
- [Laravel系パッケージの整理](laravel_packages.md): 公式パッケージの用途一覧
- [Laravel公式パッケージ一覧](packages/index.md): 公式パッケージの分類と公式ページ
- [Laravelのテストとデータベース](artisan_commands/test.md): テストの実行と、テスト用DB・環境変数の切り替え
- [git-flow-nextの設定](git_flow_next_configuration.md): ブランチの切り方を定義する設定キー
- [エージェントスキルとskills CLI](agent_skills.md): 公開スキルの取り込みと更新・復元

運用
-------------------------

- トピックごとにMarkdownファイルを作成します
- ファイル名は内容を表すsnake_caseにします
- 知識を追加したら、目次へ`- [タイトル](ファイル名): 一行説明`の形式で追記します
- プロジェクト全体の方針は[docs/index.md](../index.md)を参照してください
