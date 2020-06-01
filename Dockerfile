FROM ubuntu:20.04 
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    openssl \
    stunnel4 \
    && rm -rf /var/lib/apt/lists/*
RUN mkdir stunnel \
&& chown stunnel4 stunnel
WORKDIR /stunnel    
VOLUME [ "/stunnel" ]
COPY docker-entrypoint.sh .
RUN chmod +x docker-entrypoint.sh
USER stunnel4
ENTRYPOINT [ "/stunnel/docker-entrypoint.sh" ]