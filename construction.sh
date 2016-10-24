#!/bin/bash
# Copyright (c) 2016 Malicious Genius
#

pacman --noconfirm -S base-devel
pacman --noconfirm -S docker

systemctl start docker
systemctl enable docker

git clone https://aur.archlinux.org/package-query.git
cd package-query
makepkg -si
cd ..

git clone https://aur.archlinux.org/yaourt.git
cd yaourt
makepkg -si
cd ..

git https://aur.archlinux.org/cockpit-git.git
cd cockpit-git
makepkg -si
cd ..