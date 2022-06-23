#!/bin/bash

set -x

# launch cubic on a local X11 display

# in some cases, you might need to 
# docker exec <running cubic container> bash, 
# sudo service dbus restart
# to fix some strange issue when selecting the ISO file at second step

[ $# -ne 2 ] && {
	echo ""
	echo "Fatal: insufficient number of arguments, need 2"
	echo "<isofile: ex: ~/iso/ubuntu-18.04.6-desktop-amd64.iso > <mountpoint: ex: /home/user/app/source-disk >"
	echo ""
	exit 92
}

mkdir -p /tmp/cubic-docker/{iso,app}
mkdir -p /tmp/cubic-docker/app/source-disk

ISO=$1
MOUNTPOINT=$2

ISO_FILE=$(basename $ISO)
ISO_DIR=$(dirname $ISO)

sudo umount $MOUNTPOINT
set -e
sudo mount $ISO $MOUNTPOINT
set +e

xhost +

HOSTNAME=$(hostname)

export DISPLAY=${DISPLAY:-:0}

[ -z "$HOSTNAME" ] && exit 93
[ -z "$USER" ] && exit 94
[ -z "$HOME" ] && exit 95

docker run -e DISPLAY=$DISPLAY \
           --name cubic \
           -h $HOSTNAME \
	   -v /tmp/.X11-unix:/tmp/.X11-unix \
	   -v $HOME/.Xauthority:/home/$USER/.Xauthority \
           -v /tmp/cubic-docker/iso:/home/user/iso \
           -v $ISO:/home/user/iso/$ISO_FILE \
           -v /tmp/cubic-docker/app:/home/user/app \
	   --privileged \
           --user=$(id -u):$(id -g) \
           -it cubic:0.1 cubic