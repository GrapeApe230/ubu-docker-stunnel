FROM ubuntu:20.04 
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    openssl \
    stunnel4 \
    && rm -rf /var/lib/apt/lists/*
VOLUME [ "/stunnel" ]
#COPY docker-entrypoint.sh /stunnel/
#RUN chmod +x /stunnel/docker-entrypoint.sh \
RUN chown -R stunnel4 /stunnel \
&& chmod -R 755 /stunnel
USER stunnel4
#ENTRYPOINT [ "docker-entrypoint.sh" ]
#CMD [ "stunnel","/stunnel/stunnel.conf" ]