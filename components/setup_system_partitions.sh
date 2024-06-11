#!/bin/sh

# Create A BTRFS root partition
mkfs.btrfs -f $SYSTEM_ROOT

# Label BTRFS root partition
btrfs filesystem label $SYSTEM_ROOT "$OS_NAME"

# Make system mountpoint directory
mkdir -p $MOUNT_DIR

# Mount root filesystem
mount -t btrfs $SYSTEM_ROOT $MOUNT_DIR

# Create BTRFS subvolumes
btrfs subvolume create $MOUNT_DIR/@
btrfs subvolume create $MOUNT_DIR/@cache
btrfs subvolume create $MOUNT_DIR/@home
btrfs subvolume create $MOUNT_DIR/@log
btrfs subvolume create $MOUNT_DIR/@opt
btrfs subvolume create $MOUNT_DIR/@root
btrfs subvolume create $MOUNT_DIR/@srv
btrfs subvolume create $MOUNT_DIR/@tmp

# Unmount root filesystem
umount $MOUNT_DIR

# Mount BTRFS root @ subvolume
mount -t btrfs -o rw,compress=zstd:6,noatime,subvol=@ $SYSTEM_ROOT $MOUNT_DIR

# Make system directories
mkdir -p $MOUNT_DIR/home
mkdir -p $MOUNT_DIR/opt
mkdir -p $MOUNT_DIR/root
mkdir -p $MOUNT_DIR/srv
mkdir -p $MOUNT_DIR/tmp
mkdir -p $MOUNT_DIR/var/cache
mkdir -p $MOUNT_DIR/var/log

# Mount BTRFS subvolumes
mount -t btrfs -o rw,compress=zstd:6,noatime,subvol=@cache $SYSTEM_ROOT $MOUNT_DIR/var/cache
mount -t btrfs -o rw,compress=zstd:6,noatime,subvol=@home $SYSTEM_ROOT $MOUNT_DIR/home
mount -t btrfs -o rw,compress=zstd:6,noatime,subvol=@log $SYSTEM_ROOT $MOUNT_DIR/var/log
mount -t btrfs -o rw,compress=zstd:6,noatime,subvol=@opt $SYSTEM_ROOT $MOUNT_DIR/opt
mount -t btrfs -o rw,compress=zstd:6,noatime,subvol=@root $SYSTEM_ROOT $MOUNT_DIR/root
mount -t btrfs -o rw,compress=zstd:6,noatime,subvol=@srv $SYSTEM_ROOT $MOUNT_DIR/srv
mount -t btrfs -o rw,compress=zstd:6,noatime,subvol=@tmp $SYSTEM_ROOT $MOUNT_DIR/tmp

# Create A UEFI Boot Partition
mkfs.vfat -F32 $SYSTEM_BOOT

# Label Boot Partition
fatlabel $SYSTEM_BOOT ESP

# Make /boot directory
mkdir -p $MOUNT_DIR/boot

# Mount the efi partition
mount $SYSTEM_BOOT $MOUNT_DIR/boot
