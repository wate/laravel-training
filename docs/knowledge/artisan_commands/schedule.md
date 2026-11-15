Laravelのスケジュールコマンド
=========================

概要
-------------------------

`schedule`系のコマンドは、登録済みの定期実行タスクを確認・実行します。
本番環境ではcronから`schedule:run`を毎分呼び出します。
`schedule:work`はローカルでタスクを常駐実行します。
このページはLaravel 13.xの`schedule:*`を対象にしています。
バージョンによってコマンドが増減するため、全コマンドは`php artisan list schedule`で確認してください。

主なコマンド
-------------------------

| コマンド                       | 用途                             |
| ------------------------------ | -------------------------------- |
| `php artisan schedule:list`    | 登録済みタスクを一覧表示します   |
| `php artisan schedule:test`    | 指定したタスクを即時実行します   |
| `php artisan schedule:run`     | 対象タスクを1回実行します        |
| `php artisan schedule:work`    | ローカルでタスクを常駐実行します |

その他のスケジュールコマンド
-------------------------

| コマンド                           | 用途                             |
| ---------------------------------- | -------------------------------- |
| `php artisan schedule:clear-cache` | スケジューラのロックを削除します |
| `php artisan schedule:interrupt`   | 実行中のスケジュールを中断します |
| `php artisan schedule:pause`       | スケジューラを一時停止します     |
| `php artisan schedule:resume`      | スケジューラを再開します         |

主なオプション
-------------------------

- `schedule:list --timezone=Asia/Tokyo`: 表示するタイムゾーンを指定します
- `schedule:list --environment=<env>`: 対象環境のタスクを表示します
- `schedule:list --next`: 次回実行日時で並び替えます
- `schedule:list --json`: JSONで出力します
- `schedule:test --name=<name>`: 実行するタスク名を指定します
- `schedule:run --whisper`: 実行対象がない場合のメッセージを抑制します
- `schedule:work --run-output-file=<path>`: `schedule:run`の出力先を指定します
- `schedule:work --whisper`: 実行対象がない場合のメッセージを抑制します

使用例
-------------------------

### 登録済みタスクを確認する

```bash
php artisan schedule:list
```

次回実行日時で並び替える場合は`--next`を付けます。

```bash
php artisan schedule:list --next
```

### 特定のタスクを即時実行する

```bash
php artisan schedule:test --name="task-name"
```

### 実行時刻を迎えたタスクを実行する

```bash
php artisan schedule:run
```

### ローカルで常駐実行する

```bash
php artisan schedule:work
```

### スケジューラを一時停止・再開する

```bash
php artisan schedule:pause
php artisan schedule:resume
```

### スケジューラのロックを削除する

```bash
php artisan schedule:clear-cache
```

注意点
-------------------------

- 本番環境ではcronから毎分`schedule:run`を呼び出します
- `schedule:work`はローカル開発用です。本番環境では使いません
- `schedule:test`はタスクを即時実行するため、副作用を確認してから使います
- `schedule:list`の表示はタイムゾーンの影響を受けます。`--timezone`で確認します
- `schedule:pause`と`schedule:resume`はスケジューラ全体の実行を制御します
- `schedule:interrupt`は実行中のスケジュールを中断します
- `schedule:clear-cache`はスケジューラのロックが残った場合に使います
- タスクの定義は`routes/console.php`または`app/Console/Kernel.php`にあります

関連ドキュメント
-------------------------

- [Laravelのartisanコマンド一覧](index.md): コマンド一覧とカテゴリー
- [Laravelのキュージョブコマンド](queue.md): キューの実行と失敗ジョブ対応
- [LaravelのPail](pail.md): ログのリアルタイム表示
- [Laravelの設定確認コマンド](config.md): スケジュール設定の確認
