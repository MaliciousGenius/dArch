#!/bin/bash
# Copyright (c) 2016 Malicious Genius
#

pacman -S --needed base-devel

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