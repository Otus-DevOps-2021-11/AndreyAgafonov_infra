#!/bin/bash
cat <<EOF>/etc/systemd/system/otus.service
[Unit]
Description=Puma HTTP Server
After=network.target

[Service]
Type=fork
#WatchdogSec=10
PIDFile=/var/run/puma.pid
WorkingDirectory=/opt/reddit
ExecStart=/usr/local/bin/puma
# Variant: Rails start.
#ExecStart=/usr/local/bin/puma -C /opt/reddit/helpers.rb ./config.ru
Restart=always

[Install]
WantedBy=multi-user.target

EOF


systemctl daemon-reload
systemctl start otus.service
systemctl enable otus.service
