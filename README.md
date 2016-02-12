# Tvheadend Docker Image for Raspberry PI

Turn your [Raspberry PI](http://raspberrypi.org) within **15 minutes** into a
**TV streaming and recording server** for your local network!

This repository defines a **docker image for the ARM architecture**, based on
[alpine Linux](http://www.alpinelinux.org/), which is with ~5 MB much smaller
than most other distribution base images, and thus leads to a **slimmer Tvheadend
image of ~18 MB**.

[![](https://badge.imagelayers.io/netzfisch/rpi-tvheadend:latest.svg)](https://imagelayers.io/?images=netzfisch/rpi-tvheadend:latest)

Find the source code at [GitHub](https://github.com/netzfisch/rpi-tvheadend) or
the ready-to-run image in the [DockerHub](https://hub.docker.com/r/netzfisch/rpi-tvheadend/).

## Requirements

- [Raspberry PI](http://raspberrypi.org)
- Linux compatible [DVB-C/S/T USB-Tuner](http://www.linuxtv.org/wiki/index.php/DVB-T_USB_Devices)
- [Docker Engine](https://docs.docker.com/engine/quickstart/)

## Setup

- Install HypriotOS, which is based on Raspbian a debian derivate and results to
a working docker host, see
[Getting Started](http://blog.hypriot.com/getting-started-with-docker-and-linux-on-the-raspberry-pi/) !
- Get the right DVB-C/S/T Linux firmware, e.g.

```sh
/lib/firmware $ wget https://www.linuxtv.org/downloads/firmware/dvb-usb-vp7045-01.fw
```
- Change your network interface to a static IP

```sh
$ cat /etc/network/interfaces
  ...
  allow-hotplug eth0
  iface eth0 inet static
    address 192.168.PI.IP
    netmask 255.255.255.0
    gateway 192.168.XXX.XXX
  ...
```

- Integrate your NAS permanently

```sh
$ cat /etc/fstab
  ...
  192.168.XXX.NAS:/NAS/Movies /media/movies nfs auto  0 0
  ...
```

- **Pull** the respective **docker image** `$ docker pull netzfisch/tvheadend`

### Usage

Get ready to roll and run the container:

    $ docker run --detach \
                 --name tvheadend \
                 --restart unless-stopped \
                 --volume /media/movies/tvh-config:/config \
                 --volume /media/movies:/recordings \
                 -p 9981-9982:9981-9982 \
                 --privileged netzfisch/rpi-tvheadend

Finally [configure Tvheadend](http://docs.tvheadend.org/configure_tvheadend/)
via the web interface at **http://192.168.PI.IP:9981**. An initial user is
created, so you will be logged in flawless, but you should change that asap!

## Contributing

If you find a problem, please create a
[GitHub Issue](https://github.com/netzfisch/rpi-tvheadend/issues).

Have a fix, want to add or request a feature?
[Pull Requests](https://github.com/netzfisch/rpi-tvheadend/pulls) are welcome!

### License

The MIT License (MIT), see [LICENSE](LICENSE) file.
