#!/bin/bash
clear
# Hide commands and show only echo statements
set -x

# Exit on any error
set -e

echo "                                                                               "        
echo "==============================================================================="
echo "                                                                               "  
echo "Updates & Upgrades"
echo "                                                                               "  
echo "==============================================================================="

# Check if the user is root; if not, switch to root user
if [ "$(id -u)" -ne 0 ]; then
    sudo su -s /bin/bash -c "$0"
    exit
fi

# Execute apt commands
echo "Updating package lists..."
apt update

echo "Upgrading installed packages..."
apt upgrade -y

echo "Removing unnecessary packages..."
apt autoremove -y

echo "Cleaning up downloaded packages..."
apt autoclean -y

echo "Cleaning up unused dependencies..."
apt clean -y

# Disable command echoing
set +x

# Trap to handle script termination and revert to the original user if switched to root
trap 'sudo -u "$(logname)" bash -c "exit 1"' EXIT