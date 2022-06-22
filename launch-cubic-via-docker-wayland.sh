set -x

# from inside the shell
# sudo mount ~/iso/ubuntu-18.04.6-desktop-amd64.iso /home/user/iso/rootfs/ubuntu-1804
# sudo service dbus start

# arg= gui to launch the gui
# arg= bash to debug

CMD=$1

# launch cubic on a local Wayland display

export WAYLAND_DISPLAY=$XDG_RUNTIME_DIR/wayland-0

[ $CMD = gui ] && \
docker run -e XDG_RUNTIME_DIR=/tmp \
           -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
           -v $WAYLAND_DISPLAY:$WAYLAND_DISPLAY \
           -v /iso:/home/user/iso  \
           -v /app:/home/user/app  \
	   --privileged \
           --user=$(id -u):$(id -g) \
           -it cubic:0.1 cubic

[ $CMD = bash ] && \
docker run -e XDG_RUNTIME_DIR=/tmp \
           -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
           -v $WAYLAND_DISPLAY:$WAYLAND_DISPLAY \
           -v /iso:/home/user/iso  \
           -v /app:/home/user/app  \
	   --privileged \
           --user=$(id -u):$(id -g) \
           -it cubic:0.1 $CMD 
set +x
