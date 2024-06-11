#!/bin/sh

# Chaotic AUR PGP Key
CHAOTIC_KEY=3056513887B78AEB

# Refresh package database (Live environment)
pacman -Syy

# Install new archlinux keyring
pacman -S --noconfirm archlinux-keyring

# Initialize pacman-keyring
pacman-key --init
pacman-key --populate archlinux
pacman-key --lsign-key archlinux

# Create bootstrap enviornment
pacstrap $MOUNT_DIR base base-devel

# Add Chaotic AUR Key
arch-chroot $MOUNT_DIR pacman-key --recv-key ${CHAOTIC_KEY} --keyserver keyserver.ubuntu.com
arch-chroot $MOUNT_DIR pacman-key --lsign-key ${CHAOTIC_KEY}

# Add Chaotic AUR Repo
arch-chroot $MOUNT_DIR pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
arch-chroot $MOUNT_DIR pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

# Install pacman.conf
install -Dm644 $ABSOLUTE_PATH/configs/base/pacman.conf $MOUNT_DIR/etc/pacman.conf

# Refresh package database (Chroot)
arch-chroot $MOUNT_DIR pacman -Syy

# Initialize pacman-keyring (chroot)
arch-chroot $MOUNT_DIR pacman-key --init
arch-chroot $MOUNT_DIR pacman-key --populate archlinux chaotic
arch-chroot $MOUNT_DIR pacman-key --lsign-key archlinux
arch-chroot $MOUNT_DIR pacman-key --lsign-key chaotic
