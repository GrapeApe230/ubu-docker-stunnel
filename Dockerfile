FROM ubuntu:20.04 
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    openssl \
    stunnel4 \
    && rm -rf /var/lib/apt/lists/*
#VOLUME [ "/etc/stunnel" ]
WORKDIR /stunnel
#COPY docker-entrypoint.sh /usr/local/bin/
COPY docker-entrypoint.sh .
RUN chown -R stunnel /stunnel \
&& chmod -R 600  /stunnel \
&& chmod +x /docker-entrypoint.sh
USER stunnel4
ENTRYPOINT [ "/usr/local/bin/docker-entrypoint.sh" ]