FROM alpine

# Install runtime dependencies.
RUN apk --no-cache --no-progress upgrade && \
    apk --update add curl openvpn wget tini shadow gettext && \
    addgroup -S vpn

COPY scripts/start.sh /start.sh
COPY login.data.tmpl /vpn/
COPY config.ovpn.tmpl /vpn/

# Log the public ip address of the container in every minute.
HEALTHCHECK --interval=60s --timeout=15s --start-period=120s \
  CMD curl 'https://api.ipify.org'

ENV OPENVPN_USERNAME ""
ENV OPENVPN_PASSWORD ""
ENV OPENVPN_CA ""
ENV OPENVPN_CERT ""
ENV OPENVPN_KEY ""
ENV OPENVPN_TLSAUTH ""
ENV OPENVPN_REMOTE ""

ENTRYPOINT ["/sbin/tini", "--"]

CMD ["sh", "-c", "/start.sh"]
