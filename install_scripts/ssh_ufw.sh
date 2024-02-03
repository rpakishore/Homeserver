#!/bin/bash
clear
echo "                                                                               "        
echo "==============================================================================="
echo "                                                                               "  
echo "Install and configure UFW"
echo "                                                                               "  
echo "==============================================================================="



sudo apt update
sudo apt -y install ssh ufw
sudo systemctl enable --now ssh
sudo ufw allow ssh 
sudo ufw default deny incoming
sudo ufw enable
