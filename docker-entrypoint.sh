#!/bin/sh

#touch /var/run/stunnel4.pid
cd /etc/stunnel

cat > stunnel.conf <<_EOF_
foreground = yes
setuid = stunnel4
setgid = stunnel4
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1
cert = /etc/stunnel/stunnel.pem
client = ${CLIENT:-no}
pid = /var/run/stunnel4/stunnel.pid

[${SERVICE}]
accept = ${ACCEPT}
connect = ${CONNECT}
_EOF_

exec stunnel "$@"