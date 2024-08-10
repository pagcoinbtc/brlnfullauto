#!/bin/bash

# Allow user "admin" to work with LND
ln -s /data/lnd /home/admin/.lnd
sudo chmod -R g+X /data/lnd
sudo chmod 640 /run/tor/control.authcookie
sudo chmod 750 /run/tor

# Cria o arquivo de serviço systemd para o lnd
sudo bash -c 'cat << EOF > /etc/systemd/system/lnd.service
# MiniBolt: systemd unit for lnd
# /etc/systemd/system/lnd.service

[Unit]
Description=Lightning Network Daemon

[Service]
ExecStart=/usr/local/bin/lnd
ExecStop=/usr/local/bin/lncli stop

# Process management
####################
Restart=on-failure
RestartSec=60
Type=notify
TimeoutStartSec=1200
TimeoutStopSec=3600

# Directory creation and permissions
####################################
RuntimeDirectory=lightningd
RuntimeDirectoryMode=0710
User=admin
Group=admin

# Hardening Measures
####################
PrivateTmp=true
ProtectSystem=full
NoNewPrivileges=true
PrivateDevices=true
MemoryDenyWriteExecute=true

[Install]
WantedBy=multi-user.target
EOF'

# Allow user "admin" to work with LND
ln -s /data/lnd /home/admin/.lnd
sudo chmod -R g+X /data/lnd
sudo chmod 640 /run/tor/control.authcookie
sudo chmod 750 /run/tor

# Habilita e inicia o serviço lnd
sudo systemctl enable lnd
sudo systemctl start lnd