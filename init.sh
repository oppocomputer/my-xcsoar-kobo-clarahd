#!/bin/sh -e
set -e

STATUS_FILE=./status.txt  # Use persistent path

echo "Starting inetd setup..." > "$STATUS_FILE"

# Create inetd.conf for BusyBox telnetd
cat > /tmp/inetd.conf <<EOF
23 stream tcp nowait root /bin/busybox telnetd -i
EOF

echo "Created inetd.conf" >> "$STATUS_FILE"

# Start inetd (assumed to be full inetd, not busybox version)
if [ -x /usr/sbin/inetd ]; then
    /usr/sbin/inetd /tmp/inetd.conf
    echo "Started inetd" >> "$STATUS_FILE"
else
    echo "inetd not found!" >> "$STATUS_FILE"
fi