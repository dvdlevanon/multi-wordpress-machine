#!/bin/bash

function main() {
	local name=$1
	local port=$2
	
	if [ -z "$name" ] || [ -z "$port" ]; then
		echo "Usage ./install.sh <name> <port>"
		return 1
	fi
	
	local homedir=/home/$name
	local sitedir=$homedir/site
	
	sudo groupadd "$name" || return 1
	sudo useradd -d "$homedir" -g "$name" -m "$name" || return 1
	sudo chsh --shell /bin/bash "$name" || return 1
	sudo passwd "$name" || return 1
	local current_user_name="$USER"
	sudo usermod -a -G "$name" "$current_user_name" || return 1
	sudo cp -r /etc/skel/. "$homedir" || return 1
	sudo mkdir "$sitedir" || return 1
	sudo cp -r site/* "$sitedir" || return 1
	
	echo -n "$port" | sudo tee -a "$sitedir/HTTP_PORT" > /dev/null || return 1
	echo -n "$name" | sudo tee -a "$sitedir/PROJECT_NAME" > /dev/null || return 1
	echo -n "123456" | sudo tee -a "$sitedir/DB_PASSWORD" > /dev/null || return 1
	echo -n "$(id -u "$name")" | sudo tee -a "$sitedir/USER_ID" > /dev/null || return 1
	echo -n "$(id -g "$name")" | sudo tee -a "$sitedir/GROUP_ID" > /dev/null || return 1
	
	sudo chmod 770 "$homedir" || return 1
	sudo chown "$name:$name" "$sitedir" || return 1
	
	local daemon_name="docker-compose@${name}.service"
	sudo cp systemd.service "/lib/systemd/system/$daemon_name" || return 1
	
	echo ""
	echo "Site $name is ready"
	echo "  sudo systemctl start $daemon_name"
	echo "  sudo systemctl status $daemon_name"
	echo "  sudo systemctl stop $daemon_name"
	echo "  sudo systemctl restart $daemon_name"
	echo ""
}

main "$@"
