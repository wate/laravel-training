Laravel Homestead
=========================

概要
-------------------------

Laravel HomesteadはVagrantで動く公式の仮想開発環境です。
PHP、Nginx、MySQL、PostgreSQL、Redisなどをまとめて提供します。
現在はレガシー扱いで、活発なメンテナンスは行われていません。
公式ドキュメントも代替としてSailを案内しています。

向いている場面
-------------------------

- Vagrantベースの環境をすでに利用している
- 仮想マシン上で複数のPHPバージョンを切り替えたい
- チームで同じVagrant環境を共有したい

新規プロジェクトではSailの利用を検討します。

主な機能
-------------------------

- `Homestead.yaml`によるサイトとフォルダの設定
- MySQL、PostgreSQL、Redis、Mailpitなどの同梱
- PHP 5.6から8.3までの切り替え
- プロジェクト単位のインストール
- XdebugとBlackfireによるデバッグとプロファイリング

導入
-------------------------

```
git clone https://github.com/laravel/homestead.git ~/Homestead
cd ~/Homestead
git checkout release
bash init.sh
vagrant up
```

事前にVagrantとVirtualBoxまたはParallelsが必要です。
Apple SiliconではParallelsを利用します。

設定
-------------------------

`Homestead.yaml`でプロバイダー、共有フォルダ、サイト、データベースを設定します。
設定変更後は`vagrant reload --provision`で反映します。

プロジェクト単位で導入する場合は`composer require laravel/homestead --dev`を実行します。
その後`php vendor/bin/homestead make`で`Vagrantfile`と`Homestead.yaml`を生成します。

このプロジェクトでの利用
-------------------------

未使用です。
現在はDev Containerで開発しており、Vagrant環境は利用していません。

公式ドキュメント
-------------------------

- [Laravel Homestead](https://laravel.com/docs/13.x/homestead)
