#!/bin/bash
clear

echo "                                                                               "        
echo "==============================================================================="
echo "                                                                               "  
echo "Installing SSH Keys."
echo "                                                                               "  
echo "==============================================================================="
mkdir -p ~/.ssh
chmod 700 ~/.ssh/

if [ -f ~/.ssh/authorized_keys ]; then
    echo "Existing `authorized_keys` folder found. Backing up."
    mv ~/.ssh/authorized_keys ~/.ssh/authorized_keys.bak
    echo
else
    echo 
fi

touch ~/.ssh/authorized_keys
echo "Creating new file - OK"

sudo tee -a ~/.ssh/authorized_keys << EOF
# x360 - Windows
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDE/3u4Wql94iUyEMTLPoVKER7oOUk8nyclF1vh/SKiKCMCj5lYqnWRrmSN9Y5wPaPyLkIf1piii1om8pl2VapJ1FUAOYFV9hnSSbKtEGCCXEja0IGGXKBx2Eu3PvBuMk/IIodrNcVT519QGbfto8FtIVrgdxuG2gjgVf5JaGG5Dc2Z/g9jCCVFrQzkTRY29sdJtDjNNTWQduTkUAuafE59a+w5JM6IF9UCzejsbzK1Gbuk1XeEVrEQdm9PLGOzLb4k3mUZnKutbNg4RRxfTTbZMXRieb7EYMd7Gso8n0+Hwb5wTtaCwc9N0BXzqRENO41VGhW5ztSKaNHBrZQ30uO/lnkWMcNJomiBjObNSZmKSexLds44XGZhMJr+vCFJivEUyZxn/toY1onHJb8EbMgtKRnZQ9/rRNPrcRroB9BeHGI5qamlTcwpVxsdVOAcs0cB8hIXg9288ZIe2ZzOVsmfD8+w/Z1FBvyWHnz6l8GVLRhLAR+KPoZHJVFIZJigWlGjINN6ytF7qN+rAD168NImtR6pJHtYHTF9gLGHArQ4hTyyZM/yTIoY/FNibT1qIax9vWjAnLFke0WvyGMh+BlHdKJjQDrLtP5KVi8YogkdaSK/660ARyVXzusPEbGHSyzJmjB5AIo4GEcgiIJmRxipz2bun7qXAtBMhVNpTQi9iQ== rpakishore@Spectre
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCwDhHM3TsjOiypYDKKC2nQklDtz316jJwBwpBqilyy+pno+l6gMef3nFO/I2t3xTMlQ+hBpgDP3E2dDSwddfcvpmRR02Jdoyy1aTdW11eScylBGV0/EQ4jlAErA7FNZtNwz68H4JHyeY8YloiuRelyrJb0ar6xrhAnp6VcseZWZwrOWL04g0n/reVrcaU2+zV6WN486llY/TNcTmG0kgPZe0c9IWBc3P2/G0E09g1+wB3oLD7VqqN3S5YQ1SgcQUEAhorRAxs2xpOG1Ky78GHcchNu+x9s2bD/mbApaEwf7fi4Mnif5gb6SQkcgIZ1kGg82/vlqVx0qFOcn/l1A0lyXk6/RKpSiAuTl6OXkId/boSSZSMUEkbJa75cAaQzG3ZTlGzCx18IJEpuQa8fjeTEfaiiZHXJ6sVfy2iTby2sBFc1tkVFoveef5VMyhKVYVbkJ8ewR0Q+HS3lkig8YB+npQe9vPRAslUOMXMVEAnGb20DoE0haYNtfBhQ6P31Vj8= rpakishore@ubuntu-server
# S10-Termux
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDbWdpWunhSq6J5HO6jobjrPXG6rWxrc7+p7bkhFATz9sEa+L5p4V3L0bybHtClwsUjMIHvf0BJWLi3n1UYVuuJrpGyl1IT5pj+N74am0VmzuEWum6Z2KgP50UrXbEswb3PtFi1+eYvlO4ou49MnVV9UpNKaBjahSdV51wsWbsWSpKswZ9t12kb1EDog6fYuf3hS7yZfliuGy7nAH20r0yDfKtZjPD2WuZDnIGl227kT7Xa2b7STHaDLvd4om2tRhj/2kk5d5UFtgfo+ejD6Swuw1lMeCsX8ZSSi2ZpKuh+cMuLzpVs6Ss+kJLfRfSPEloPw1vJ+3OgE5+wH9uUHSk8Hf0Bkl2lGf3HbWX15HUxe+mqp89pHKyBr5Y335/sttAHgfJGZLqg6WprxYjjtSyXhB6xLHtp4+nZsB61tP8hq307YsQceTnPMfy0Mn7zPetVhOEPoMzd4Bw7PUtBJcv657ei9x4CMRapvPW8CEVWa43t45jzPEYJC5Jf+czluTRTCXSn7STPHQRyfmom6Pa+RHPYyGDLLTA0s5Wj4cPgP3BZUhqak9Er+cpQRcNHhBbj4UF4QtNcDLJExnQRo4MVnHdwqfoqj7sE9thPzQodmgS7U8fiE/RFK0oNTt5y7LwIBM8XIKq0CCxD4Yx8ic38qwDsOzJ28tmtxfkDWoGMiw== u0_a523@localhost
# Desktop - Windows
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDRUNQ61pDpW+fdyJqW9Kk+2iNLvmiEyluoafPVqDPXX5yJqTyjqwMwwn0g5hCKNzv8HIKDtreb5uxmZ7EIppepJkn56F6LpooCzDonZ97GFp2D6VkcScwlt7ETpU5BUWdMHIl6u66cWOdTeO1K7P54iRntii7h6BU9oy/tHIFePZLjhUsgNZXuLsqk8pMkkfdHDQuFqEm8EWsnrXKZapBx66TF+ZAGpo0+Jjg0YRj95Uj27t55KQ8nYJ3GAwr2zqpGErLyNq+nz2VieNoRwNIsW6agEWiPHgTQKZeiJJ6Znya+iAJmL754ormgu9KHNbIGAdAoX+arXLRGb9R7v5hkH0x8pyXLl3k0mnI7zeIC2JFhZRBMZ8+bJ0FGcfbLsZVSGZO926J2F/9XQdP9bFrQNjjxiQkf7NYlxZ2H0h/zuDLci+qvCAEiyNKgqVWv461PCseMwX6AWTXYztFE2oxlN799lXvWlPQffH5Fe9V3sJLrwhfmjkOXVb/Tr+yet48= rpakishore@DESKTOP-4KR460Q
# Ansible Semaphore
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDMvQa4k4oVeG8ULiZ4/TbMYe/+o9OM3q85KapAeOWrLGTZjo8detbC/Jq3pBq7b9HqAnIA0xy9t6lNpe4IV1ZAV1jyS3I9dSpfNaBd1ZZFRxewHBxwDIRpkGk21ed1AskD1GcpDzUmJ+pT9PydfMhtzLQZGXuPtee6ZhuFJ7berDVV1mCQ3E/w18+GlhnrrZu2oNnkZs/2q0tOVVeaoI+/kiYdmEBeU5jfW2OrjJSdVTsZekQDSQw7XYlS9rsEka/iZ2qiXaq+ZXpYVdVADA3LcTTrwpw8uEAkDfmCQPdwelD8f9rixYN9/ZxS/HmySvR/GYkTCKMTrmUtPiXJ8Z34guq28ZCHR6XddHdjlryrHx3PSBhPbfZZOowTGGTqE4OB5hkxax0fZmjF8/vmX0IQob6jRnLCx2Eq3n7l6giRSkXzcMHSkkDQke3KnwjpztDxNeMbsX8qvik4XrFh7lwhI/dPL9B/4AEtJV+79M12Jajfmse+CRb2yDwlKJSfvQk= rpakishore@DESKTOP-4KR460Q
EOF
echo "Copy new keys - OK"

chmod 600 ~/.ssh/*
echo "Set file permissions - OK"

sudo tee -a /etc/ssh/sshd_config << EOF
PasswordAuthentication no
AllowUsers $(whoami)
EOF

echo "Disable password Authentication - OK"
sudo service ssh reload
