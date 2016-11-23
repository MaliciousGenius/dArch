#!/bin/bash
# Copyright (c) 2016 Malicious Genius
#

# Разбиваю диск на разделы
partitioning_hd() {
    parted -s /dev/sda \
        mklabel msdos \
        mkpart primary ext2 1M 255M \
        mkpart primary linux-swap 256M 512M \
        mkpart primary ext2 513M 100% \
        set 1 boot on
}

# Форматирую раделы
format_partition() {
    mkfs.ext2 -F -L boot /dev/sda1
    mkfs.ext4 -F -L root /dev/sda3
    mkswap /dev/sda2
}

# Монтирую файловые ситемы
mount_partition() {
    mount /dev/sda3 /mnt
    mkdir -p /mnt/boot
    mount /dev/sda1 /mnt/boot
    swapon /dev/sda2
}

# Устанавливаю набор базовах патетов
install_packages() {
    pacstrap /mnt base base-devel grub git ansible
}

# Генерирую fstab
generation_fstab() {
    genfstab -U -p /mnt >> /mnt/etc/fstab
}

# Загружаю сктипт начальных настроек
get_preparatory_script() {
    wget https://raw.githubusercontent.com/MaliciousGenius/dArch/master/microinstaller-chroot.sh -O /mnt/root/microinstaller-chroot.sh
    chmod +x /mnt/root/microinstaller-chroot.sh
}

# Запускаю начальные настройки
initial_settings() {
    arch-chroot /mnt /root/microinstaller-chroot.sh
}

# Удаляю подготовительный сктипт
erase_preparatory_script() {
    rm /mnt/root/microinstaller-chroot.sh
}

echo " >> Installing..."

partitioning_hd
format_partition
mount_partition
install_packages
generation_fstab
get_preparatory_script
initial_settings
erase_preparatory_script

echo " >> Ok."

exit 0