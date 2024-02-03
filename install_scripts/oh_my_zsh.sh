#!/bin/bash
clear

echo "                                                                               "        
echo "==============================================================================="
echo "                                                                               "  
echo "Oh My ZSH install."
echo "                                                                               "  
echo "==============================================================================="

# Update package lists
sudo apt update

# Install Zsh
sudo apt install zsh curl git -y

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Clone Powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

# Modify ZSH_THEME in ~/.zshrc
sed -i 's/ZSH_THEME="robbyrussel"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc

# Install Autosuggestions Plugin
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Modify plugins in ~/.zshrc
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions)/' ~/.zshrc

echo Installation Complete. You need to restart the terminal for changes to take effect
