#!/bin/bash
clear

echo "                                                                               "        
echo "==============================================================================="
echo "                                                                               "  
echo "Powertop Install."
echo "                                                                               "  
echo "==============================================================================="

sudo apt -y install powertop
## Create a service file to run powertop --auto-tune at boot
sudo tee -a /etc/systemd/system/powertop.service << EOF
[Unit]
Description=PowerTOP auto tune
[Service]
Type=idle
Environment="TERM=dumb"
ExecStart=/usr/sbin/powertop --auto-tune
[Install]
WantedBy=multi-user.target
EOF
## Enable the service
sudo systemctl daemon-reload
sudo systemctl enable powertop.service
## Tune system now
sudo powertop --auto-tune
## Start the service
sudo systemctl start powertop.service
