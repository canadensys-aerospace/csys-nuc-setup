#!/bin/bash
set -e

sudo sed -i 's|http://ca\.archive\.ubuntu\.com|http://ubuntu.mirror.rafal.ca|g' /etc/apt/sources.list
sudo sed -i 's|http://security\.ubuntu\.com|http://ubuntu.mirror.rafal.ca|g' /etc/apt/sources.list
sudo apt-get update
sudo apt-get -y upgrade
