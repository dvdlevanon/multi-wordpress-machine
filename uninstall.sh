#!/bin/bash

function main() {
	local name=$1
	
	if [ -z "$name" ]; then
		echo "Usage ./install.sh <name>"
		return 1
	fi
	
	local homedir=/home/$name
	local sitedir=$homedir/site
	
	local answer="n"
	read -r -e -p "Are you sure you want to uninstall site named: $name (y/N)? " answer < /dev/tty;
	
	if [ "$answer" != "y" ] && [ "$answer" != "Y" ]; then
		return 0
    fi
    
    local daemon_name="docker-compose@${name}.service"
    
    sudo rm "/lib/systemd/system/$daemon_name" || return 1
    pushd "$sitedir" || return 1
    ./run.sh down || return 1 
    sudo userdel "$name" || return 1
    sudo groupdel "$name" || return 1
    sudo rm -rf "$homedir" || return 1
    
    popd || return 1
}

main "$@"
