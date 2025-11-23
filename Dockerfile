FROM alpinelinux/unbound AS base

RUN apk add drill busybox-openrc --no-cache
RUN wget -S https://www.internic.net/domain/named.cache -O /etc/unbound/root.hints

ADD ./unbound.conf /etc/unbound/unbound.conf
ADD ./healthcheck.sh /usr/local/bin/healthcheck.sh
ADD ./updater.sh /usr/local/bin/updater.sh
RUN chmod +x /usr/local/bin/healthcheck.sh
RUN chmod +x /usr/local/bin/updater.sh

RUN ln -s /usr/local/bin/updater.sh /etc/periodic/15min/updater

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD ["healthcheck.sh"]

ENTRYPOINT ["/bin/sh", "-c", "crond && entrypoint.sh"]