# rpi-tvheadend

Turn your RaspberryPI into a "TV Headend"!

# Ingredients

- [RaspberryPI](http://raspberrypi.org)
- USB DVB-Tuner
- Docker Engine

# Setup

- Install
  [HypriotOS](http://blog.hypriot.com/getting-started-with-docker-and-linux-on-the-raspberry-pi/)
- Switch to static IP
- Mount your NAS
- Get ready `docker pull netzfisch/tvheadend`

# Usage

    docker run --name tvheadend \
               --privileged netzfisch/rpi-tvheadend \
               --volume /persistent-configuration:/config \
               --volume /persistent-recordings:/recordings \
               --expose 9981-9981:9982-9982 \
               --restart=unless-stopped

## Contributing

If you find a problem, please create a
[GitHub Issue](https://github.com/netzfisch/rpi-tvheadend/issues).

Have a fix, want to add or request a feature?
[Pull Requests](https://github.com/netzfisch/rpi-tvheadend/pulls) are welcome!

## License

The MIT License (MIT), see [LICENSE](LICENSE) file.
