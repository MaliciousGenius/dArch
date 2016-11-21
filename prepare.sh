#!/bin/bash
# Copyright (c) 2016 Malicious Genius
#

echo 'mothership ansible_connection=local' > /etc/ansible/hosts
cd /opt/microarch-custom & git pull
ansible-playbook ./roles/vmguest/tasks/main.yml

