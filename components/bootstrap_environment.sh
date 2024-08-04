#!/bin/sh

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

# Install pacman.conf
install -Dm644 $ABSOLUTE_PATH/configs/base/pacman.conf $MOUNT_DIR/etc/pacman.conf

# Refresh package database (Chroot)
arch-chroot $MOUNT_DIR pacman -Syy

# Initialize pacman-keyring (chroot)
arch-chroot $MOUNT_DIR pacman-key --init
arch-chroot $MOUNT_DIR pacman-key --populate archlinux
arch-chroot $MOUNT_DIR pacman-key --lsign-key archlinux
