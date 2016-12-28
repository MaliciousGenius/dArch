#!/bin/bash
# Copyright (c) 2016 Malicious Genius
#

echo " >> Prepare..."

# Установаю имя хоста
configure_hostname(){
    echo mothership > /etc/hostname
}

# Задаю часовой пояс
configure_timezone(){
    ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
}

# Настройка локали
configure_locale(){
    cp /etc/locale.gen /etc/locale.gen_bak
    sed 's/#en_US.UTF-8/en_US.UTF-8/g' /etc/locale.gen_bak > /etc/locale.gen
    cp /etc/locale.gen /etc/locale.gen_bak
    sed 's/#ru_RU.UTF-8/ru_RU.UTF-8/g' /etc/locale.gen_bak > /etc/locale.gen
    rm /etc/locale.gen_bak

    # Генерация локали
    locale-gen

    echo 'LANG="ru_RU.UTF-8"' >> /etc/locale.conf
}

# Настройка русской клавиатуры и шрифта
select_keymap(){
    echo 'KEYMAP=ru' >> /etc/vconsole.conf
    echo 'FONT=cyr-sun16' >> /etc/vconsole.conf
}

# Создаём новый ramdisk
configure_mkinitcpio(){
    mkinitcpio -p linux
}

# Добавляю загрузчик
configure_bootloader(){
    grub-mkconfig -o /boot/grub/grub.cfg
    grub-install --recheck /dev/sda
}

# Влючить загрузку dhcpcd
enable_dhcp(){
    systemctl enable dhcpcd
}

# Создаю пользователя admin
create_admin_user(){
    groupadd users
    useradd -m -g users -G wheel -s /bin/bash admin
}

# Создаю пользователя system
create_system_user(){
    groupadd system
    useradd -m -g system -G wheel -s /bin/bash system
}

# Настраиваю sudo
configure_sudo(){
    cp /etc/sudoers /etc/sudoers.gen_bak
    sed '/%wheel ALL=(ALL) NOPASSWD: ALL/s/^#//' /etc/sudoers.gen_bak > /etc/sudoers
    rm /etc/sudoers.gen_bak
}

# Настраиваю git
configure_git(){
    git config --global user.email "maliciousgenius@gmail.com"
    git config --global user.name "maliciousgenius"
}

# Загрузка репозитория dArch
get_repo_microarch(){
    cd /opt
    git clone https://github.com/MaliciousGenius/dArch.git
}

configure_hostname
configure_timezone
configure_locale
select_keymap
configure_mkinitcpio
configure_bootloader
enable_dhcp
create_admin_user
create_system_user
configure_sudo
configure_git
get_repo_microarch

# Установка пароля для пользователя root
echo 'Enter "root" user password'
passwd

# Установка пароля для пользователя admin
echo 'Enter "admin" user password'
passwd admin

# Установка пароля для пользователя system
echo 'Enter "system" user password'
passwd system

pacman -Syu

exit 0
