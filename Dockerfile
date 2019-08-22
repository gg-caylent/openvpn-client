FROM alpine

# Install runtime dependencies.
RUN apk --no-cache --no-progress upgrade && \
    apk --update add curl openvpn wget tini shadow && \
    addgroup -S vpn

ADD scripts/start.sh /

# Log the public ip address of the container in every minute.
HEALTHCHECK --interval=60s --timeout=15s --start-period=120s \
  CMD curl 'https://api.ipify.org'

VOLUME [ "/vpn" ]

CMD ["/sbin/tini", "--", "/start.sh"]
