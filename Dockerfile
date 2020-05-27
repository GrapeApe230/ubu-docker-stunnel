FROM ubuntu:20.04

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    stunnel4 \
    openssl \
    && rm -rf /var/lib/apt/lists/*

VOLUME [ "/etc/stunnel" ]

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT [ "/usr/local/bin/docker-entrypoint.sh" ]