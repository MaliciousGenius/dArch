#!/bin/bash
# Copyright (c) 2016 Malicious Genius
#

cd /opt/microarch-custom
echo 'mothership ansible_connection=local' > /etc/ansible/hosts
ansible-playbook ./playbook/parallels.yml

