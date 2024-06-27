#!/bin/sh

# BASE SYSTEM PACKAGE LIST
BASE_SYSTEM="alsa-utils avahi bash-completion btrfs-progs dosfstools efibootmgr exfatprogs fastfetch ffmpeg firewalld git gnu-free-fonts i2c-tools ${KERNEL} linux-firmware ${KERNEL}-headers man-db man-pages mkinitcpio mkinitcpio-firmware mtools multilib-devel net-tools networkmanager pipewire-alsa pipewire-audio pipewire-ffado pipewire-jack pipewire-pulse pipewire-session-manager pipewire-v4l2 plymouth pocl power-profiles-daemon pulse-native-provider realtime-privileges sshfs sudo udisks2 udisks2-btrfs vim vim-runtime wget wireless-regdb wireplumber zram-generator"

# Install Base System
arch-chroot $MOUNT_DIR pacman -S --noconfirm $BASE_SYSTEM

# Set hostname
echo "$HOSTNAME" > $MOUNT_DIR/etc/hostname

# Create the new non-root user
arch-chroot $MOUNT_DIR useradd -m $USERNAME

# Set password for the new user
echo "$USERNAME:$PASSWORD" | arch-chroot $MOUNT_DIR chpasswd

# Enable the wheel group root privileges
sed -i -e 's/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' $MOUNT_DIR/etc/sudoers

# Add user to groups
arch-chroot $MOUNT_DIR gpasswd -a $USERNAME audio
arch-chroot $MOUNT_DIR gpasswd -a $USERNAME realtime
arch-chroot $MOUNT_DIR gpasswd -a $USERNAME video
arch-chroot $MOUNT_DIR gpasswd -a $USERNAME wheel

# Set system language
sed -i -e "s/#${LOCALE}/${LOCALE}/" $MOUNT_DIR/etc/locale.gen
arch-chroot $MOUNT_DIR locale-gen
echo "LANGUAGE=${LOCALE}:${LOCALE/_*/}" > $MOUNT_DIR/etc/locale.conf
echo "LC_ALL=C" >> $MOUNT_DIR/etc/locale.conf
echo "LANG=${LOCALE}.UTF-8" >> $MOUNT_DIR/etc/locale.conf

# Set timezone and correct time
arch-chroot $MOUNT_DIR ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime

# Install global enviornment variable configuration
install -Dm644 $ABSOLUTE_PATH/configs/base/environment $MOUNT_DIR/etc/environment

# Install mkinitcpio.conf
install -Dm644 $ABSOLUTE_PATH/configs/base/mkinitcpio.conf $MOUNT_DIR/etc/mkinitcpio.conf

# Intall i2c dev tools for some OpenRGB lighting to work
install -Dm644 $ABSOLUTE_PATH/configs/base/i2c-dev.conf $MOUNT_DIR/etc/modules-load.d/i2c-dev.conf

# Install ZRAM configuration
install -Dm644 $ABSOLUTE_PATH/configs/base/zram-generator.conf $MOUNT_DIR/etc/systemd/zram-generator.conf

# Install archlinux default icon
install -Dm644 $ABSOLUTE_PATH/components/distributor-logo-archlinux.svg $MOUNT_DIR/usr/share/icons/distributor-logo-archlinux.svg

# Generate filesystem mounts
genfstab -U $MOUNT_DIR > $MOUNT_DIR/etc/fstab

# Enable system services
arch-chroot $MOUNT_DIR systemctl enable avahi-daemon.service
arch-chroot $MOUNT_DIR systemctl enable avahi-dnsconfd.service
arch-chroot $MOUNT_DIR systemctl enable fstrim.timer
arch-chroot $MOUNT_DIR systemctl enable NetworkManager.service

# Install bash config files
install -Dm644 $ABSOLUTE_PATH/skel/.bash_logout $MOUNT_DIR/etc/skel/.bash_logout
install -Dm644 $ABSOLUTE_PATH/skel/.bash_profile $MOUNT_DIR/etc/skel/.bash_profile
install -Dm644 $ABSOLUTE_PATH/skel/.bashrc $MOUNT_DIR/etc/skel/.bashrc
