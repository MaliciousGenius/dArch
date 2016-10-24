#!/bin/bash
# Copyright (c) 2016 Malicious Genius
#

sudo pacman --noconfirm -S ansible

cd /opt
git clone https://github.com/MaliciousGenius/microarch-custom.git
cd microarch-custom
ansible-playbook --connection=local --ask-sudo-pass ./site.yml