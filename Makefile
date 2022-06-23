DOCKER_OPT=--platform linux/x86_64
CUBIC_IMG=cubic:0.1

ISO=/iso/ubuntu-18.04.6-desktop-amd64.iso
MOUNTPOINT=/tmp/cubic-docker/app/source-disk

default: x11

x11: cubic-x11

wayland: cubic-wayland

cubic-img:
	docker build $(DOCKER_OPT) -t $(CUBIC_IMG) . -f Dockerfile

# launch cubic through docker on a local X11 display (this works, tested ok)

cubic-x11: cubic-img
	./launch-cubic-via-docker-x11.sh $(ISO) $(MOUNTPOINT)

# launch cubic through docker on a local Wayland display (untested, please give feedback)

cubic-wayland: cubic-img
	./launch-cubic-via-docker-wayland.sh $(ISO) $(MOUNTPOINT)
