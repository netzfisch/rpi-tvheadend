FROM hypriot/rpi-alpine-scratch:v3.4
MAINTAINER netzfisch

# add respositories to get certain packages, check here https://pkgs.alpinelinux.org/packages
RUN echo "http://nl.alpinelinux.org/alpine/v3.4/community" >> /etc/apk/repositories
RUN echo "@edge http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

# install tvheadend packages
RUN apk add --update libhdhomerun-dev \
    tvheadend-git@edge \
    tvheadend-git-dvb-scan@edge \
    tvheadend-git-satellites-xml@edge \
    && rm -rf /var/cache/apk/*

# expose 'config' and 'recordings' directory for persistence
VOLUME /config /recordings

# expose ports for 'web interface' and 'streaming'
EXPOSE 9981 9982

ENTRYPOINT ["/usr/bin/tvheadend"]
CMD ["--firstrun", "-u", "root", "-g", "root", "-c", "/config"]
