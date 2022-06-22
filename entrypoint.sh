#!/bin/bash

set -x

ARG=$1

# from inside the shell
#mkdir -p /home/user/app/source-disk
#sudo mount ~/iso/ubuntu-18.04.6-desktop-amd64.iso /home/user/app/source-disk
sudo service dbus start

export PATH=/bin:/usr/bin:/sbin:/usr/sbin 
[ -z "$ARG" ] && exec /usr/bin/cubic
[ "$ARG" == debug ] && exec /usr/bin/cubic --verbose

set +x
