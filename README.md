# Tvheadend Docker Image

> Orginaly just made for **ARM architecture** but **now also supporting x86/x64 platform**, see [Dockerfile.x86_64](https://github.com/netzfisch/rpi-tvheadend/blob/master/Dockerfile.x86_64) and/or get the [x86_64-image](https://hub.docker.com/r/netzfisch/tvheadend/)!

Turn your [Raspberry PI](http://raspberrypi.org) (or x86_64 machine) within **15 minutes** into a **TV streaming and recording server** for your local network! This project uses the well known **[Tvheadend](https://tvheadend.org/)** software, is **based on [alpine Linux](http://www.alpinelinux.org/)**, which is with ~5 MB much smaller than most other distribution base, and thus leads to a **slimmer** Tvheadend **target image**.

[![](https://images.microbadger.com/badges/version/netzfisch/rpi-tvheadend.svg)](https://microbadger.com/images/netzfisch/rpi-tvheadend "Inspect image!") [![](https://images.microbadger.com/badges/image/netzfisch/rpi-tvheadend.svg)](https://microbadger.com/images/netzfisch/rpi-tvheadend "Inspect image!")

Find the full **source code** at [GitHub](https://github.com/netzfisch/rpi-tvheadend) or the ready-to-run **images in the DockerHub** for the  [ARM](https://hub.docker.com/r/netzfisch/rpi-tvheadend/) or [x86_64](https://hub.docker.com/r/netzfisch/tvheadend/) platform and do **not forget to _star_** the repository ;-)

## Requirements

- [Raspberry PI](http://raspberrypi.org)
- Linux compatible [DVB-C/S/T USB-Tuner](http://www.linuxtv.org/wiki/index.php/DVB-T_USB_Devices)
- [Docker Engine](https://docs.docker.com/engine/quickstart/)

## Setup

- **Install a debian Docker package**, which you download [here](http://blog.hypriot.com/downloads/) and install with `dpkg -i package_name.deb`. Alternatively install HypriotOS, which is based on Raspbian a debian derivate and results to a fully working docker host, see [Getting Started](http://blog.hypriot.com/getting-started-with-docker-and-linux-on-the-raspberry-pi/)!
- Get the right **DVB-C/S/T Linux firmware**, e.g.

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
  192.168.NAS.IP:/nfs/Public /mnt nfs auto  0 0
  ...
```

Alternatively ... if you are **lazy**, use a **docker volume plugin**, which enables the volume type **NFS to be mounted directly** within the container, see [Netshare docker plugin](http://netshare.containx.io/). After install you can use it like this

    $ docker run -it --volume-driver=nfs --volume NFShost/path:/data alpine /bin/ash
    $ cd /data
    $ touch testfile

- **Pull** the respective **docker image** `$ docker pull netzfisch/rpi-tvheadend`

### Build

To build the image and/or compile by yourself from git source, use Dockerfile.build

```sh
$ cat Dockerfile.build
$ docker build -f Dockerfile.build -t netzfisch/tvheadend:git-build .
$ docker tag netzfisch/tvheadend:git-build netzfisch/tvheadend:4.1_git20161008
```

Find the **automated build** for that at [DockerHub](https://hub.docker.com/r/netzfisch/tvheadend/).

## Usage

Get ready to roll and run the container:

    $ docker run --detach \
                 --name tvheadend \
                 --restart unless-stopped \
                 --volume /mnt/Configs/tvh-config:/config \
                 --volume /mnt/Movies:/recordings \
                 -p 9981-9982:9981-9982 \
                 --privileged netzfisch/rpi-tvheadend

Finally [configure Tvheadend](http://docs.tvheadend.org/configure_tvheadend/) via the web interface at **http://192.168.PI.IP:9981**. An initial user is created, so you will be **logged in flawless, and setup wizard** should start immediately!

**HEADS UP** If you are running into **problems like**

    2016-10-02 18:32:25.705 dvr: Unsupported charset ASCII using ASCII
    2016-10-02 18:32:25.705 dvr: Recording error: Unable to create file

**check the Web-GUI** [ Recording > DVR-Profile > Advanced View > Filename Charset ] if set to a **supported charset format**, e.g. **UTF-8**! At my installation it was set to **ASCII** which **failed to write to the NAS**, and cost me too much time to debug ;-( ... encoding in 2016 still sucks!

## Debugging

If you run into trouble, try to get a **clean setup at docker host level**

    $ docker stop tvheadend && docker rm tvheadend # stop and remove container
    $ rmmod dvb_usb_vp7045 dvb_usb dvb_core        # remove DVB-T linux modules
    $ modprobe dvb_usb_vp7045                      # reload DVB-T linux modules
    $ docker run --detach \                        # create new containter
                 --name tvheadend \
                 ...

and than **go into the container** for further debugging:

    $ docker exec -it tvheadend /bin/ash

## Contributing

If you find a problem, please create a [GitHub Issue](https://github.com/netzfisch/rpi-tvheadend/issues).

Have a fix, want to add or request a feature? [Pull Requests](https://github.com/netzfisch/rpi-tvheadend/pulls) are welcome!

### License

The MIT License (MIT), see [LICENSE](https://github.com/netzfisch/rpi-tvheadend/blob/master/LICENSE) file.
