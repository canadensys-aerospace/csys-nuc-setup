#!/bin/bash
set -e

if [[ $EUID -eq 0 ]]; then
	>&2 echo "This script must not be run as root"
	exit 1
fi

./update-ubuntu.sh
./install-ssh-server.sh
./install-ros.sh
./install-roboteq-ros.sh
./install-dcdc-nuc-ros.sh
