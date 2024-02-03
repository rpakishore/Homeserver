#!/bin/bash
clear

echo "                                                                               "        
echo "==============================================================================="
echo "                                                                               "  
echo "Unattended Upgrades"
echo "                                                                               "  
echo "==============================================================================="

sudo apt-get install unattended-upgrades apt-listchanges -y
sudo dpkg-reconfigure --priority=low unattended-upgrades
