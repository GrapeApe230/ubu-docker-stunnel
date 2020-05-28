FROM ubuntu:20.04 
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    openssl \
    stunnel4 \
    && rm -rf /var/lib/apt/lists/*
VOLUME [ "/etc/stunnel" ]
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
USER stunnel4
ENTRYPOINT [ "/usr/local/bin/docker-entrypoint.sh" ]
CMD [ "stunnel","/etc/stunnel/stunnel.conf" ]