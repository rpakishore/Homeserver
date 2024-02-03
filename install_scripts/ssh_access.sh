#!/bin/bash
clear

echo "                                                                               "        
echo "==============================================================================="
echo "                                                                               "  
echo "Disable root ssh login"
echo "                                                                               "  
echo "==============================================================================="


sudo tee -a /etc/ssh/sshd_config << EOF
PermitRootLogin no
AllowUsers $(whoami)
EOF
