FROM ubuntu:20.04 AS builder

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    openssl \
    && rm -rf /var/lib/apt/lists/*

RUN openssl req -x509 -nodes -newkey rsa:2048 -days 3650 -subj '/CN=stunnel' -keyout stunnel.pem -out stunnel.pem \
&& chmod 600 stunnel.pem

FROM ubuntu:20.04 
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    stunnel4 \
    && rm -rf /var/lib/apt/lists/*
VOLUME [ "/etc/stunnel" ]
COPY --from=builder stunnel.pem /etc/stunnel/stunnel.pem
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT [ "/usr/local/bin/docker-entrypoint.sh" ]