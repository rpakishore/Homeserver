#!/bin/bash
clear

echo "                                                                               "        
echo "==============================================================================="
echo "                                                                               "  
echo "Installing Fail2Ban."
echo "                                                                               "  
echo "==============================================================================="
sudo apt-get install fail2ban -y
sudo cp /etc/fail2ban/fail2ban.{conf,local}
sudo cp /etc/fail2ban/jail.{conf,local}
sudo sed -i "s/backend = auto/backend = systemd/" /etc/fail2ban/jail.local
