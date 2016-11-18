#!/bin/bash
# Copyright (c) 2016 Malicious Genius
#


cd /opt/microarch-custom & git pull
echo 'mothership ansible_connection=local' > /etc/ansible/hosts
#ln -s '/opt/microarch-custom/mothership-startup.service' '/etc/systemd/system/mothership-startup.service'
#systemctl daemon-reload
#systemctl enable mothership-startup.service
ansible-playbook ./mothership.yml
sleep 3m
systemctl reboot
