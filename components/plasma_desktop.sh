#!/bin/sh

# PLASMA DESKTOP PACKAGE LIST
PLASMA_DESKTOP="7-zip appmenu-gtk-module archlinux-appstream-data argyllcms ark bluez bluez-hid2hci bluez-mesh bluez-obex bluez-qt bluez-qt5 bluez-utils breeze5 chmlib dolphin dolphin-plugins ebook-tools ffmpegthumbs firefox flatpak flatpak-xdg-utils fwupd gamemode gst-libav gst-plugin-libcamera gst-plugin-pipewire gst-plugins-bad gst-plugins-base gst-plugins-espeak gst-plugins-good gst-plugins-ugly gst-plugin-va gstreamer-vaapi gwenview hunspell-en_au hunspell-en_ca hunspell-en_gb hunspell-en_us ifuse kaccounts-integration kaccounts-providers kamera kate kcalc kdeconnect kdegraphics-mobipocket kdegraphics-thumbnailers kdenetwork-filesharing kdialog keditbookmarks kimageformats kimageformats5 kio-admin kio-extras kio-gdrive kio-zeroconf konsole kwalletmanager kwayland-integration lib32-fluidsynth lib32-gamemode lib32-gst-plugins-base lib32-gst-plugins-good lib32-libavtp lib32-libdbusmenu-gtk2 lib32-libdbusmenu-gtk3 lib32-libsamplerate lib32-mangohud lib32-pipewire-jack lib32-pipewire-v4l2 lib32-sdl2 lib32-speexdsp libappimage libdbusmenu-glib libdbusmenu-gtk2 libdbusmenu-gtk3 libdbusmenu-qt5 libdvdcss libgpod libportal libportal-gtk3 libportal-gtk4 libportal-qt5 maliit-keyboard mangohud noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra okular orca p7zip partitionmanager phonon-qt5-gstreamer phonon-qt5-vlc phonon-qt6-vlc plasma plasma-applet-window-buttons plasma-framework5 plasma-wayland-protocols plasma5-integration power-profiles-daemon qpwgraph qt6-imageformats qt6-multimedia-ffmpeg qt6-multimedia-gstreamer qt6-virtualkeyboard quota-tools spectacle steam steam-native-runtime switcheroo-control thunderbird unarchiver usbguard vlc xdg-desktop-portal-gtk xdg-user-dirs xdg-user-dirs-gtk yt-dlp"

# Install Plasma Desktop
arch-chroot $MOUNT_DIR pacman -S --noconfirm $PLASMA_DESKTOP

# Install SDDM configurations
install -Dm644 $ABSOLUTE_PATH/configs/plasma/kde_settings.conf $MOUNT_DIR/etc/sddm.conf.d/kde_settings.conf
install -Dm644 $ABSOLUTE_PATH/configs/plasma/virtualkbd.conf $MOUNT_DIR/etc/sddm.conf.d/virtualkbd.conf

# Enable system services
arch-chroot $MOUNT_DIR systemctl enable bluetooth.service
arch-chroot $MOUNT_DIR systemctl enable power-profiles-daemon.service
arch-chroot $MOUNT_DIR systemctl enable sddm.service

# Add user to groups
arch-chroot $MOUNT_DIR gpasswd -a $USERNAME flatpak
arch-chroot $MOUNT_DIR gpasswd -a $USERNAME gamemode
arch-chroot $MOUNT_DIR gpasswd -a $USERNAME games

# Install bash config files
install -Dm644 $ABSOLUTE_PATH/skel/Desktop/flathub-setup-user-mode.sh $MOUNT_DIR/etc/skel/Desktop/flathub-setup-user-mode.sh
