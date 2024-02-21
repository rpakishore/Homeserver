#!/bin/bash

# Function to execute apt commands and echo process
execute_apt() {
    echo "Executing: $1"
    if [ "$(id -u)" -ne 0 ]; then
        eval sudo "$1" >/tmp/apt_log 2>&1
    else
        eval "$1" >/tmp/apt_log 2>&1
    fi
    echo "Done."
}
if command -v ansible-playbook &> /dev/null; then
    #echo "Ansible is already installed."
    :
else
    # Install Ansible per https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html
    echo "Installing Ansible"
    execute_apt "apt update"
    execute_apt "apt install software-properties-common"
    execute_apt "sudo add-apt-repository --yes --update ppa:ansible/ansible"
    execute_apt "apt install ansible -y"
    echo "Ansible has been installed."
fi

clear

files=('reinstall_docker' 'install_fail2ban' 'install_log2ram' 'install_oh-my-zsh' 
'install_powertop' 'ssh_authorized_keys' 'update_debian' 'debloat_debian')

echo "Options: "
# Print numbered list
for ((i=0; i<${#files[@]}; i++)); do
    printf "\t%02d. %s\n" "$((i+1))" "${files[i]}"
done

echo 
# Ask user for input
read -p "Choose the # you want to call: " choice

# Validate user input
if [[ $choice -ge 1 && $choice -le ${#files[@]} ]]; then
    selected_file=${files[$((choice-1))]}

    url="https://raw.githubusercontent.com/rpakishore/Homeserver/main/playbooks/$selected_file.yml"
    ansible-playbook <(curl -s $url)

else
    echo "Invalid choice. Please select a valid number."
fi

# Display command output
#echo "Command Output:"
#cat /tmp/apt_log

# Remove temporary file
rm -f /tmp/apt_log
