#!/bin/bash
# Copyright (c) 2016 Malicious Genius
#

useradd -m -d /home/system -g sys -G wheel -s /bin/bash system
echo 'Enter "system" user password'
passwd system
cd /opt/microarch-custom
ansible-playbook ./playbook/parallels.yml

