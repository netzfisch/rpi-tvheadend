FROM hypriot/rpi-alpine-scratch
MAINTAINER netzfisch

# install tvheadend packages
RUN apk add --update tvheadend tvheadend-dvb-scan \
    && rm -rf /var/cache/apk/*

# expose 'config' and 'recordings' directory for persistence
VOLUME /config /recordings

# expose ports for 'web interface' and 'stream'
EXPOSE 9981 9982

ENTRYPOINT ["/usr/bin/tvheadend"]
CMD ["-C", "-c", "/config"]
