FROM ubuntu:20.04 
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    openssl \
    stunnel4 \
    && rm -rf /var/lib/apt/lists/*
VOLUME [ "/etc/stunnel" ]
COPY docker-entrypoint.sh .
RUN chmod +x docker-entrypoint.sh 
ENTRYPOINT [ "/docker-entrypoint.sh" ]