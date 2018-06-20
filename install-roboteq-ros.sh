#!/bin/bash
set -e

if [[ $EUID -eq 0 ]]; then
	>&2 echo "This script must not be run as root"
	exit 1
fi

sudo apt-get update
sudo apt-get -y install ros-kinetic-serial

sudo cp usb-serial.rules /etc/udev/rules.d

source ~/catkin_ws/devel/setup.bash

cd ~/catkin_ws/src
git clone https://github.com/canadensys-aerospace/csys-ros-roboteq.git

cd ~/catkin_ws
catkin_make
