FROM hypriot/rpi-alpine-scratch
MAINTAINER netzfisch

# add 'edge' respository to get 'latest greatest' packages
RUN echo "http://nl.alpinelinux.org/alpine/v3.3/main" > /etc/apk/repositories
RUN echo "@edge http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories

# install tvheadend packages
RUN apk add --update tvheadend@edge tvheadend-dvb-scan@edge \
    && rm -rf /var/cache/apk/*

# expose 'config' and 'recording' directory for persistence
VOLUME /config /recordings

# expose ports for 'web interface' and 'stream'
EXPOSE 9981 9982

ENTRYPOINT ["/usr/bin/tvheadend"]
CMD ["-C", "-c", "/config"]
