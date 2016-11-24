#!/bin/bash
# Copyright (c) 2016 Malicious Genius
#

#ln -s '/opt/microarch-custom/mothership-startup.service' '/etc/systemd/system/mothership-startup.service'
#systemctl daemon-reload
#systemctl enable mothership-startup.service

echo 'mothership ansible_connection=local' > /etc/ansible/hosts
cd /opt/dArch & git pull
ansible-playbook ./current.yml
