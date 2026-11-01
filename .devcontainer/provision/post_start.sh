#!/usr/bin/env bash
set -eo pipefail

if [ -f composer.json ] && [ ! -f vendor/autoload.php ]; then
  composer install --no-interaction
fi

## npmとyarnのインストール完了マーカーが無い場合は依存パッケージを導入する
node_modules_ready=false
for marker in .package-lock.json .yarn-integrity .yarn-state.yml; do
  if [ -e "node_modules/${marker}" ]; then
    node_modules_ready=true
    break
  fi
done

if [ -f package.json ] && [ "${node_modules_ready}" = false ]; then
  ## @see https://github.com/antfu/ni
  ni
fi

## Playwrightのブラウザ本体を導入(導入済みの場合はスキップされる)
if [ -f package.json ] && [ -d node_modules/@playwright/test ]; then
  if ! npx playwright install chromium; then
    echo "Playwrightのブラウザ導入に失敗しました。" >&2
  fi
fi

## -------------------
## Laravelアプリの初期化
##
## postCreateは失敗するとコンテナを作り直すまで再実行されないため、
## 毎回の起動時に冪等な処理として実行する
## -------------------
if [ -f artisan ]; then
  if [ ! -f .env ] && [ -f .env.dev ]; then
    cp .env.dev .env
  fi

  if [ -f .env ] && ! grep -qE '^APP_KEY=.+' .env; then
    php artisan key:generate --no-interaction
  fi

  ## MariaDBの起動を待ってからマイグレーションを実行(最大60秒)
  if command -v mysqladmin >/dev/null 2>&1 && [ -f "${HOME}/.my.cnf" ]; then
    for _ in $(seq 1 30); do
      if mysqladmin ping --silent >/dev/null 2>&1; then
        break
      fi
      sleep 2
    done
  fi

  if [ -f .env ]; then
    if ! php artisan migrate --force --no-interaction; then
      echo "マイグレーションに失敗しました。DBの起動状態を確認してください。" >&2
    fi
  fi

  if [ -f package.json ] && [ ! -d public/build ]; then
    if ! npm run build; then
      echo "フロントエンドのビルドに失敗しました。" >&2
    fi
  fi
fi

if type "direnv" >/dev/null 2>&1 && [ -f .envrc ]; then
  direnv allow
fi

PROVISION_DIR=$(dirname $0)
if type "ansible" >/dev/null 2>&1 && [ -f "${PROVISION_DIR}/post_start.yml" ]; then
  ansible-playbook  -i 127.0.0.1, -c local --diff "${PROVISION_DIR}/post_start.yml"
fi

if [ -z "${__GIT_PROMPT_SHOW_CHANGED_FILES_COUNT}" ]; then
  source "${HOME}/.bashrc"
fi

if [ -f .pre-commit-config.yaml ] && [ -e ~/.local/pipx/venvs/pre-commit ] && [ ! -f .git/hooks/pre-commit ]; then
  pre-commit install
fi

# .devcontainer/compose.yml側で/usr/local/bin/apache2-foregroundで起動している
# Webサーバーのログなどをターミナルで確認したい場合は、
# compose.yml側のcommand部を`sleep infinity`に変更して、下記のコマンドで起動する
# apache2ctl start
