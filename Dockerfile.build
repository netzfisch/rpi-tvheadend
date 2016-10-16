# for x86_64 platform use 'alpine:v3.4'
FROM hypriot/rpi-alpine-scratch:v3.4
MAINTAINER netzfisch

# add respositories and check package availability at https://pkgs.alpinelinux.org/packages
RUN echo "http://nl.alpinelinux.org/alpine/v3.4/community" >> /etc/apk/repositories
#RUN echo "@edge http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

# install build dependencies, see
# - http://tvheadend.org/projects/tvheadend/wiki/Building,
# - https://github.com/gliderlabs/docker-alpine/issues/24 and
# - http://git.alpinelinux.org/cgit/aports/tree/testing/tvheadend-git/APKBUILD
RUN apk add --update \
    ffmpeg-dev gettext-dev libc-dev linux-headers openssl-dev \
    perl g++ cmake bash wget bzip2 git make \
    libhdhomerun-dev python \
    && rm -rf /var/cache/apk/*

# build tvheadend from master
RUN git clone https://github.com/tvheadend/tvheadend.git /tmp/tvheadend \
    && cd /tmp/tvheadend && ./configure \
    && make && make install \
    && cd && rm -rf /tmp/*

# remove obselete packages
RUN apk del \
    ffmpeg-dev gettext-dev libc-dev linux-headers openssl-dev \
    perl g++ cmake bash wget bzip2 git make

# expose 'config' and 'recordings' directory for persistence
VOLUME /config /recordings

# expose ports for 'web interface' and 'streaming'
EXPOSE 9981 9982

# enter with '/tmp/tvheadend/build.linux/tvheadend' if 'make install' skipped
ENTRYPOINT ["/usr/bin/tvheadend"]
CMD ["--firstrun", "-u", "root", "-g", "root", "-c", "/config"]
