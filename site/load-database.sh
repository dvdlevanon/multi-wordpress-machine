#!/bin/bash

source common.sh

function main() {
	local dump_file=$1

	[ -z "$dump_file" ] && { echo "Usage: ./load-database.sh <DUMP_FILE>"; exit 1; }

	local temp_file
	temp_file=$(mktemp /tmp/tpob_loadXXX)
	echo "mysql -u root -p$DB_PASSWORD -D wordpress < /tmp/dump" > "$temp_file"

	local container_name="${PROJECT_NAME}_db_1"

	docker cp "$dump_file" "$container_name:/tmp/dump"
	docker cp "$temp_file" "$container_name:/tmp/loader.sh"

	docker exec "$container_name" bash /tmp/loader.sh
}

main "$@"
