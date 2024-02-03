#!/bin/bash
clear

echo "                                                                               "        
echo "==============================================================================="
echo "                                                                               "  
echo "Installing Docker and Docker-Compose"
echo "                                                                               "  
echo "==============================================================================="

# Docker
sudo apt install curl -y
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
printf '\nDocker installed successfully\n\n'

printf 'Waiting for Docker to start...\n\n'
sleep 5

# Docker Compose
COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep 'tag_name' | cut -d\" -f4)
sudo curl -L https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo curl -L https://raw.githubusercontent.com/docker/compose/${COMPOSE_VERSION}/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose
printf '\nDocker Compose installed successfully\n\n'

sudo usermod -aG docker $(whoami)

mkdir -p ~/docker

echo ""
echo ""
echo "Docker has been installed. Logout and log back in for the changes to take effect"
