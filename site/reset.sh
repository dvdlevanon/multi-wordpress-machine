#!/bin/bash

source common.sh

function main() {
	rm -rf "$WORDPRESS_DIR" || return 1
	rm -rf "$MYSQL_DATA_DIR" || return 1
	rm -rf "$WORDPRESS_CONTENT_DIR" || return 1
}

main "$@"
