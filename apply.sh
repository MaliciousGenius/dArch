#!/bin/bash
# Copyright (c) 2016 Malicious Genius
#


#ln -s '/opt/microarch-custom/mothership-startup.service' '/etc/systemd/system/mothership-startup.service'
#systemctl daemon-reload
#systemctl enable mothership-startup.service

echo 'mothership ansible_connection=local' > /etc/ansible/hosts

ansible-playbook ./germination.yml
cd /opt/microarch-custom & git pull
cd /opt/microarch-custom
ansible-playbook ./mothership.yml
sleep 1m
systemctl reboot
