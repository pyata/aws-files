#!/bin/bash

### Install packages
export DEBIAN_FRONTEND=noninteractive
add-apt-repository ppa:gns3/unstable -y
apt update && apt-get upgrade -yqq
#apt install gns3-gui firefox gdm3 gnome-terminal nautilus xtightvncviewer ssh -yqq
apt install gns3-gui firefox gdm3 gnome-terminal nautilus ssh lxde xrdp -yqq
systemctl set-default runlevel5.target

### Download config files
GNS3_VER=`dpkg -s gns3-gui | grep Version | cut -d " " -f 2 | sed 's/~.*//'`
GNS3_SHORTVER=`echo $GNS3_VER | sed 's/[a-z].*//'`

# Checking if version number ends with 0. If yes, strip the patch number
GNS3_SHORTVER_LAST=`echo "${GNS3_SHORTVER:(-2)}"`
if [ "$GNS3_SHORTVER_LAST" == ".0" ]; then
    GNS3_SHORTVER=`echo $GNS3_SHORTVER | cut -d "." -f -2`
fi

GNS3_CONFDIR="/home/ubuntu/.config/GNS3/${GNS3_SHORTVER}"
mkdir -p $GNS3_CONFDIR
sudo cp /aws-files/gns3_gui.conf $GNS3_CONFDIR/gns3_gui.conf
sudo cp /aws-files/gns3_server.conf $GNS3_CONFDIR/gns3_server.conf

# Adding GNS3 version to the GUI config file
sed -i "s/\"version\":/\"version\": \"${GNS3_VER}\"/g" $GNS3_CONFDIR/gns3_gui.conf

# This script runs as root, need to change the .config directory's ownership
chown -R ubuntu:ubuntu /home/ubuntu/.config/

# Reboot
#reboot  >> This was causing an issue after the reboot, the VM will loose the synced folder. Migrated to vagrant reload plugin "vagrant plugin install vagrant-reload"
