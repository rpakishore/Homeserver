# https://pimylifeup.com/raspberry-pi-log2ram/
clear

echo "                                                                               "        
echo "==============================================================================="
echo "                                                                               "  
echo "Log2RAM install"
echo "                                                                               "  
echo "==============================================================================="

sudo apt update
sudo apt full-upgrade -y
sudo apt install rsync -y
wget https://github.com/azlux/log2ram/archive/master.tar.gz -O ~/log2ram.tar.gz
cd ~
tar xf log2ram.tar.gz
cd ~/log2ram-master
sudo ./install.sh

rm ~/log2ram.tar.gz
echo "log2ram installed. Reboot for changes to take effect. The config files can be edited at: /etc/log2ram.conf"
