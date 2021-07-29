echo "[Unit]
Description=banip
After=network.target

[Service]
Type=oneshot
User=root
ExecPre=/bin/sleep 5
ExecStart=/bin/bash ban.sh
TimeoutStartSec=300

[Install]
WantedBy=multi-user.target"> /lib/systemd/system/banip.service
systemctl daemon-reload
systemctl enable banip
systemctl start banip
systemctl status banip
