#!/bin/bash
# <!------------Install base required software------------>
echo "___________________________"
echo "Install required packages"
echo "___________________________"
sudo apt -y install build-essential net-tools ncdu nala python3-pip

# <!------------Setup SSH, ufw & fail2ban------------>
echo "---------------------------------------------------------------------------"
echo "Setup SSH, ufw & fail2ban? (recommend: y)         "
read -p "y or n ?" answer
case ${answer:0:1} in
    y|Y )
    echo "___________________________"
    echo "SSH: remote terminal & SFTP"
    echo "___________________________"
    sudo apt -y install ssh ufw
    sudo systemctl enable --now ssh
    sudo ufw allow ssh 
    sudo ufw default deny incoming
    sudo ufw enable

    echo "___________________________"
    echo "Setup Fail2ban"
    echo "___________________________"
    sudo apt-get install fail2ban -y
    sudo cp /etc/fail2ban/fail2ban.{conf,local}
    sudo cp /etc/fail2ban/jail.{conf,local}
    sudo sed -i "s/backend = auto/backend = systemd/" /etc/fail2ban/jail.local

    echo "___________________________"
    echo "Disable root ssh login"
    echo "___________________________"

sudo tee -a /etc/ssh/sshd_config << EOF
PermitRootLogin no
AllowUsers rpakishore
EOF

    ;;
    * )
        echo "SKIPPED SSH, ufw & fail2ban setup"
    ;;
esac

# <!------------NFSv4.2------------>
echo "--------------------------------------------------------------------------------------------------------------"
echo "Install NFSv4.2: fastest solution for local network folder sharing? (recommend: y)" 
read -p "y or n ?" answer
case ${answer:0:1} in
    y|Y )
    sudo apt -y install nfs-server
    ;;
    * )
        echo "SKIPPED NFSv4.2 installation"
    ;;
esac

# <!------------Run-if-today------------>
echo "--------------------------------------------------------------------------------------------------------------"
echo "Install Run-if-today: simplify scheduling of weekly or monthly tasks? (recommend: y)" 
read -p "y or n ?" answer
case ${answer:0:1} in
    y|Y )
    sudo wget -O /usr/bin/run-if-today https://raw.githubusercontent.com/xr09/cron-last-sunday/master/run-if-today
    sudo chmod +x /usr/bin/run-if-today
    ;;
    * )
        echo "SKIPPED Run-if-today installation"
    ;;
esac

# <!------------nocache and grsync------------>
echo "--------------------------------------------------------------------------------------------------------------"
echo "Install nocache and grsync - secure file copy tools? (recommend: y)" 
read -p "y or n ?" answer
case ${answer:0:1} in
    y|Y )
    echo "nocache - handy when moving lots of files at once in the background, without filling up cache and slowing down the system."
    sudo apt -y install nocache
    echo "Grync - friendly UI for rsync"
    sudo apt -y install grync
    ;;
    * )
        echo "SKIPPED nocache and grsync installation"
    ;;
esac

# <!------------lm-sensors------------>
echo "______________________________________________________"
echo "Install lm-sensors & detect system sensors for Netdata"
echo "______________________________________________________"
echo "--------------------------------------------------------------------------------------------------------------"
echo "Install lm-sensors & detect system sensors for Netdata? (recommend: y)" 
read -p "y or n ?" answer
case ${answer:0:1} in
    y|Y )
    sudo apt -y install lm-sensors
    sudo sensors-detect --auto
    echo "--------------------------------------"
    echo "Install Netdata - monitoring dashboard"
    echo "______________________________________"
    bash <(curl -Ss https://my-netdata.io/kickstart.sh) --dont-wait --stable-channel
    ;;
    * )
        echo "SKIPPED lm-sensors installation"
    ;;
esac

# <!------------Scrutiny------------>
echo "--------------------------------------------------------------------------------------------------------------"
echo "Prepare for Scrutiny: a nice webUI to monitor your SSD & HDD drives health? (recommend: y)" 
read -p "y or n ?" answer
case ${answer:0:1} in
    y|Y )
        # Scrutiny (S.M.A.R.T. disk health monitoring)
        # --------------------------------------------
        sudo mkdir -p $HOME/docker/config/scrutiny
        sudo chown ${USER}:${USER} $HOME/docker/config/scrutiny
        wget -O $HOME/docker/config/scrutiny/collector.yaml https://raw.githubusercontent.com/zilexa/Homeserver/master/docker/scrutiny/collector.yaml
        sudo chmod 644 $HOME/docker/config/scrutiny/collector.yaml
        echo "Done, Before running compose, manually adjust the file /docker/config/scrutiny/collector.yaml to the number of nvme drives you have."
        read -p "hit a button to continue..."
    ;;
    * )
        echo "SKIPPED downloading config yml file.."
    ;;
esac

# <!------------QBittorrent------------>
echo "--------------------------------------------------------------------------------------------------------------"
echo "Download recommended/best-practices configuration for QBittorrent: to download media, torrents? (recommend: n)" 
read -p "y or n ?" answer
case ${answer:0:1} in
    y|Y )
        sudo mkdir -p $HOME/docker/qbittorrent/config
        sudo chown ${USER}:${USER} $HOME/docker/qbittorrent/config
        wget -O $HOME/docker/qbittorrent/config/qBittorrent.conf https://raw.githubusercontent.com/zilexa/Homeserver/master/docker/qbittorrent/config/qBittorrent.conf
        sudo chmod 644 $HOME/docker/qbittorrent/config/qBittorrent.conf
    ;;
    * )
        echo "SKIPPED downloading QBittorrent config file.."
    ;;
esac

# <!------------Organizr------------>
echo "---------------------------------------------------------------------------------------------"
echo "Download preconfigured Organizr config: your portal to all your apps and services? (optional)" 
read -p "y or n ?" answer
case ${answer:0:1} in
    y|Y )
        # Not sure if this works, it will download my config, a homepage with all services. MANUALLY via the Organizr settings, add the credentials and change the ip:port for each.
        # Just to get you started with a homepage instead of the basic blank stuff. 
        # MANUALLY stop the container, delete these files and restart if Organizr doesn't work. 
        sudo mkdir -p $HOME/docker/organizr/www/organizr/api/config
        sudo chown -R ${USER}:${USER} $HOME/docker/organizr
        wget -O $HOME/docker/organizr/www/organizr/api/config/config.php https://raw.githubusercontent.com/zilexa/Homeserver/master/docker/organizr/www/organizr/api/config/config.php
        wget -O $HOME/docker/organizr/www/organizr/organizrdb.db https://github.com/zilexa/Homeserver/blob/master/docker/organizr/www/organizr/organizrdb.db?raw=true
    ;;
    * )
        echo "SKIPPED downloading Organizr pre-configuration.."
    ;;
esac

# <!------------elasticsearch------------>
echo "-------------------------------------------------------------------------------------------------"
echo "Prepare for elasticsearch: allow indexing and searching through contents of files? (recommend: n)" 
read -p "y or n ?" answer
case ${answer:0:1} in
    y|Y )
        # FileRun & ElasticSearch ~ requirements
        # ---------------------------------------------
        # Create folder and set permissions
        sudo mkdir -p $HOME/docker/filerun/esearch
        sudo chown -R $USER:$USER $HOME/docker/filerun/esearch
        sudo chmod 755 $HOME/docker/filerun/esearch
        # IMPORTANT! Should be the same user:group as the owner of the personal data you access via FileRun!
        sudo mkdir -p $HOME/docker/filerun/html
        sudo chown -R $USER:$USER $HOME/docker/filerun/html
        sudo chmod 755 $HOME/docker/filerun/html
        # Change OS virtual mem allocation as it is too low by default for ElasticSearch
        sudo sysctl -w vm.max_map_count=262144
        # Make this change permanent
        sudo sh -c "echo 'vm.max_map_count=262144' >> /etc/sysctl.conf"
    ;;
    * )
        echo "SKIPPED prepping elasticsearch.."
    ;;
esac

# <!------------Ubuntu DNS resolver------------>
echo "---------------------------------------------------------------------------"
echo "Disable Ubuntu own DNS resolver, it blocks port 53? (recommend: n)         "
echo "Required if you will run your own DNS server (AdGuardHome,PiHole, Unbound) " 
read -p "y or n ?" answer
case ${answer:0:1} in
    y|Y )
        # Required on Ubuntu systems if you will run your own DNS resolver and/or adblocking DNS server.
        # ---------------------------------------------
        sudo systemctl disable systemd-resolved.service
        sudo systemctl stop systemd-resolved.service
        echo "dns=default" | sudo tee -a /etc/NetworkManager/NetworkManager.conf
        echo "-------------------------------------------------------------------------------"
        echo "You need to do the next step yourself, please read carefully before continuing!"
        echo "-------------------------------------------------------------------------------"
        echo "A text file will open when you hit a key. Please do the following:             "
        echo "Move dns=default to the [MAIN] section by manually deleting it and typing it.  "
        echo "You can also copy with mouse, delete it and paste it below [MAIN]              "
        echo "AFTER you have done that, save changes via CTRL+O, exit the editor via CTRL+X. "
        echo "                                                                               "
        read -p "ready to do this? Hit a key..."
        sudo nano /etc/NetworkManager/NetworkManager.conf
        sudo rm /etc/resolv.conf
        sudo systemctl restart NetworkManager.service
    ;;
    * )
        echo "SKIPPED disabling of Ubuntu DNS resolver.."
    ;;
esac

# <!------------OpenVPN------------>
echo "---------------------------------------------------------------------------"
echo "Install OpenVPN server? (recommend: y)         "
read -p "y or n ?" answer
case ${answer:0:1} in
    y|Y )
    wget https://git.io/vpn -O openvpn-install.sh && bash openvpn-install.sh
    ;;
    * )
        echo "SKIPPED installation of OpenVPN server"
    ;;
esac


echo "                                                                               "        
echo "==============================================================================="
echo "                                                                               "  
echo "All done! Please log out/in first, before running Docker (reboot not required)."
echo "                                                                               "  
echo "==============================================================================="
