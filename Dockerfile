FROM alpine:3.20
RUN apk add --no-cache ca-certificates curl unzip
RUN curl -L -o /tmp/Xray-linux-64.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && unzip /tmp/Xray-linux-64.zip -d /usr/local/bin/ && chmod +x /usr/local/bin/xray && rm /tmp/Xray-linux-64.zip && mkdir -p /etc/xray
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
