FROM haproxy:1.9-alpine

ENTRYPOINT ["/magic-entrypoint", "/docker-entrypoint.sh"]

CMD ["haproxy", "-f", "/usr/local/etc/haproxy/haproxy.cfg"]

ENV NAMESERVERS="208.67.222.222 8.8.8.8 208.67.220.220 8.8.4.4" \
    LISTEN=:10000 \
    PRE_RESOLVE=0 \
    TALK=google.com:80 \
    TIMEOUT_CLIENT=5s \
    TIMEOUT_CLIENT_FIN=5s \
    TIMEOUT_CONNECT=5s \
    TIMEOUT_SERVER=5s \
    TIMEOUT_SERVER_FIN=5s \
    TIMEOUT_TUNNEL=5s \
    UDP=0 \
    VERBOSE=0

EXPOSE ${LISTEN}

RUN apk add --no-cache python3 busybox-extras netcat-openbsd &&\
    pip3 install --no-cache-dir dnspython

COPY magic-entrypoint.py /magic-entrypoint

RUN chgrp -R root /usr/local/etc && chmod -R g+rw /usr/local/etc
