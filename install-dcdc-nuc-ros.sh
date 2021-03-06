#!/bin/bash
set -e

if [[ $EUID -eq 0 ]]; then
	>&2 echo "This script must not be run as root"
	exit 1
fi

sudo apt-get update
sudo apt-get -y install libusb-dev

sudo cp dcdc-nuc.rules /etc/udev/rules.d

cd ~
git clone https://github.com/canadensys-aerospace/csys-dcdc-nuc-list
cd csys-dcdc-nuc-list
make
sudo make install

source ~/catkin_ws/devel/setup.bash

cd ~/catkin_ws/src
git clone https://github.com/canadensys-aerospace/csys-ros-dcdc-nuc

cd ~/catkin_ws
catkin_make
