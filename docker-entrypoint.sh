#!/bin/sh
if [ ! -f stunnel.pem ]; then

    cat >> openssl.cnf <<_EOF_
    [ req ]
    prompt = no
    distinguished_name = req_distinguished_name

    [ req_distinguished_name ]
    CN = ${CN}
_EOF_

    openssl req -x509 -nodes -new -newkey rsa:2048 -days 3650 -config openssl.cnf -keyout stunnel.pem -out stunnel.pem
    chmod 600 stunnel.pem
    rm openssl.cnf
fi

if [ ! -f stunnel.conf ]; then

    cat > stunnel.conf <<_EOF_
    foreground = yes
    setuid = stunnel4
    setgid = stunnel4
    socket = l:TCP_NODELAY=1
    socket = r:TCP_NODELAY=1
    cert = /stunnel/stunnel.pem
    client = ${CLIENT:-no}
    pid = /var/run/stunnel4/stunnel.pid

    [${SERVICE}]
    accept = ${ACCEPT}
    connect = ${CONNECT}
_EOF_
fi

exec stunnel "stunnel.conf"