#!/bin/bash

source common.sh

function make_sure_directory_exists() {
	local directory=$1
	
	if [ -d "$directory" ]; then
		return
	fi
	
	mkdir "$directory" || return 1
	sudo chown "$USER_ID":"$GROUP_ID" "$directory" || return 1
}

function main() {
	make_sure_directory_exists "$MYSQL_DATA_DIR" || return 1
	make_sure_directory_exists "$WORDPRESS_DIR" || return 1
	make_sure_directory_exists "$WORDPRESS_CONTENT_DIR" || return 1
	
	pushd deploy || return 1
	
	echo "Details:"
	echo "  Name: $PROJECT_NAME"
	echo "  Port: $HTTP_PORT"
	echo "  User: $USER_ID"
	echo "  Group: $GROUP_ID"
	echo "  Mysql: $MYSQL_DATA_DIR"
	echo "  Wordpress: $WORDPRESS_DIR"
	echo "  Wordpress content: $WORDPRESS_CONTENT_DIR"
	
	docker-compose -p "$PROJECT_NAME" "$@"
	
	popd || return 1
}

main "$@"
