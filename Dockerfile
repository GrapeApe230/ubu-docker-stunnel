FROM ubuntu:20.04 
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    openssl \
    stunnel4 \
    && rm -rf /var/lib/apt/lists/*
VOLUME [ "/stunnel" ]
WORKDIR /stunnel
COPY docker-entrypoint.sh /stunnel
RUN chmod +x /stunnel/docker-entrypoint.sh \
&& chown -R stunnel4 /stunnel \
&& chmod -R 755 /stunnel
USER stunnel4
ENTRYPOINT [ "/usr/local/bin/docker-entrypoint.sh" ]
CMD [ "stunnel","/stunnel/stunnel.conf" ]