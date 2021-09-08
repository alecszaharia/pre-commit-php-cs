#!/usr/bin/env bash
set -eu

# move in project root
LIB_ROOT_DIR="$(dirname "$0")/.."
PROJECT_ROOT_DIR="$(dirname "$0")/../../.." # theoretically we should in project root

CS_FIXER="${PROJECT_ROOT_DIR}/vendor/bin/php-cs-fixer"
GIT_HOOK_PRE_COMMIT="${PROJECT_ROOT_DIR}/.git/hooks/pre-commit"
CS_FIXER_CONFIG=".php-cs-fixer.dist.php"
CS_FIXER_CONFIG_NEW=".php-cs-fixer.dist.php"
CS_FIXER_CONFIG_OLD=".php-cs-fixer.dist"


if test -f "$GIT_HOOK_PRE_COMMIT";  then
  echo "You already have a pre-commit git hook created. Aborting.."
  exit 1;
fi

if ! test -f "$CS_FIXER"; then
    echo "$CS_FIXER does not exist. Please run composer install";
fi

if test -f "$PROJECT_ROOT_DIR/$CS_FIXER_CONFIG_NEW";  then
  CS_FIXER_CONFIG=$CS_FIXER_CONFIG_NEW
fi


if test -f "$PROJECT_ROOT_DIR/$CS_FIXER_CONFIG_OLD";  then
  CS_FIXER_CONFIG=$CS_FIXER_CONFIG_OLD
fi

if test -z "$var"; then
  echo "Unable to find the ${PROJECT_ROOT_DIR}/.php-cs-fixer.dist[.php] file. More info: https://github.com/FriendsOfPHP/PHP-CS-Fixer"
  exit 1;
fi

docker pull php:cli

mv $LIB_ROOT_DIR/bin/pre-commit.dist $GIT_HOOK_PRE_COMMIT

echo "All done!!"