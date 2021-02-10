#!/bin/bash

export SCRIPTS_DIR
SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

export DB_PASSWORD=123456
export WORDPRESS_CONTENT_DIR=$SCRIPTS_DIR/wp-content
export MYSQL_DATA_DIR=$SCRIPTS_DIR/mysql
export WORDPRESS_DIR=$SCRIPTS_DIR/wordpress

export PROJECT_NAME=
PROJECT_NAME=$(cat PROJECT_NAME)

export HTTP_PORT
HTTP_PORT=$(cat HTTP_PORT)

export USER_ID
USER_ID=$(cat USER_ID)

export GROUP_ID
GROUP_ID=$(cat GROUP_ID)

export DB_PASSWORD=
DB_PASSWORD=$(cat DB_PASSWORD)
