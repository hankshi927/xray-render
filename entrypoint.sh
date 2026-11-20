#!/bin/sh
set -eu
if [ -z "${UUID:-}" ]; then echo "UUID env var is required" >&2; exit 1; fi
PORT="${PORT:-10000}"
mkdir -p /etc/xray
cat > /etc/xray/config.json <<EOF
{
  "log": {"loglevel": "warning"},
  "inbounds": [
    {
      "port": $PORT,
      "listen": "0.0.0.0",
      "protocol": "vless",
      "settings": {
        "clients": [{"id": "$UUID"}],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": {"path": "/xray"}
      }
    }
  ],
  "outbounds": [{"protocol": "freedom"}]
}
EOF
echo "Starting Xray on port $PORT, ws path /xray"
exec /usr/local/bin/xray run -c /etc/xray/config.json
