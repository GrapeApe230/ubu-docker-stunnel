#!/bin/sh

touch openssl.cnf

cat >> openssl.cnf <<_EOF_
[ req ]
prompt = no
distinguished_name = req_distinguished_name

[ req_distinguished_name ]
CN = ${CN}
_EOF_

openssl req -x509 -nodes -newkey rsa:2048 -days 3650 -config openssl.cnf -keyout stunnel.pem -out /etc/ssl/private/stunnel.pem
rm openssl.cnf

cd /etc/stunnel

cat > stunnel.conf <<_EOF_
foreground = yes
setuid = stunnel4
setgid = stunnel4
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1
cert = /etc/ssl/private/stunnel.pem
client = ${CLIENT:-no}
pid = /var/run/stunnel4/stunnel.pid

[${SERVICE}]
accept = ${ACCEPT}
connect = ${CONNECT}
_EOF_

exec stunnel "$@"