#!/bin/bash

if [[ $EUID -eq 0 ]]; then
	>&2 echo "This script must not be run as root"
	exit 1
fi

source ~/catkin_ws/devel/setup.bash

roslaunch --core &

ncpu=0
nuser=0
nunknown=0

dcdc_nuc_list | while read line
do
	IFS=',' read -a fields <<< $line
	case "${fields[2]}" in
		0)
			name=dcdc_psu_user${nuser}
			nuser=$(($nuser + 1))
			;;
		1)
			name=dcdc_psu_cpu${ncpu}
			ncpu=$(($ncpu + 1))
			;;
		*)
			name=dcdc_psu_unknown${nunknown}
			nunknown=$(($nunknown + 1))
			;;
	esac
	roslaunch --wait dcdc_nuc dcdc_nuc.launch name:=${name} bus:=${fields[0]} dev:=${fields[1]} &
done

[ -L /dev/ttyUSB-CSYS-M1 ] && roslaunch --wait roboteq_driver example.launch &
