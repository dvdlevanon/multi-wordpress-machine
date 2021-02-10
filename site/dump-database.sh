#!/bin/bash

source common.sh

function main() {
	local dump_file
	dump_file="database_dump-$(date +"%d-%m-%Y").sql"
	
	local container_name="${PROJECT_NAME}_db_1"
	
	docker exec -it "$container_name" \
		mysqldump -u root "-p$DB_PASSWORD" wordpress --extended-insert=FALSE > "$dump_file"
}

main "$@"
