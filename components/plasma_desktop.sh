#!/bin/sh

# PLASMA DESKTOP PACKAGE LIST
PLASMA_DESKTOP="7-zip appmenu-gtk-module archlinux-appstream-data argyllcms ark bluedevil bluez bluez-hid2hci bluez-mesh bluez-obex bluez-qt bluez-qt5 bluez-utils breeze breeze5 breeze-gtk chmlib chromium dolphin dolphin-plugins ebook-tools ffmpegthumbs gamemode gst-libav gst-plugin-libcamera gst-plugin-pipewire gst-plugins-bad gst-plugins-base gst-plugins-espeak gst-plugins-good gst-plugins-ugly gst-plugin-va gstreamer-vaapi gwenview hunspell-en_au hunspell-en_ca hunspell-en_gb hunspell-en_us kaccounts-integration kaccounts-providers kactivitymanagerd kamera kate kcalc kde-cli-tools kde-gtk-config kdeconnect kdecoration kdegraphics-mobipocket kdegraphics-thumbnailers kdenetwork-filesharing kdialog keditbookmarks kgamma kglobalacceld kimageformats kimageformats5 kinfocenter kio-admin kio-extras kio-gdrive kio-zeroconf kmenuedit konsole kpipewire kscreen kscreenlocker ksshaskpass ksystemstats kwallet-pam kwalletmanager kwayland kwayland-integration kwin kwrited layer-shell-qt lib32-fluidsynth lib32-gamemode lib32-gst-plugins-base lib32-gst-plugins-good lib32-libavtp lib32-libdbusmenu-gtk2 lib32-libdbusmenu-gtk3 lib32-libsamplerate lib32-mangohud lib32-pipewire-jack lib32-pipewire-v4l2 lib32-sdl2 lib32-speexdsp libappimage libdbusmenu-glib libdbusmenu-gtk2 libdbusmenu-gtk3 libdbusmenu-qt5 libdvdcss libkscreen libksysguard libplasma maliit-keyboard mangohud milou noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra ocean-sound-theme okular orca p7zip partitionmanager phonon-qt5-gstreamer phonon-qt5-vlc phonon-qt6-vlc plasma-activities plasma-activities-stats plasma-applet-window-buttons plasma-browser-integration plasma-desktop plasma-disks plasma-firewall plasma-framework5 plasma-integration plasma-nm plasma-pa plasma-systemmonitor plasma-thunderbolt plasma-vault plasma-wayland-protocols plasma-workspace plasma5-integration plasma5support plymouth-kcm polkit-kde-agent powerdevil power-profiles-daemon qpwgraph qqc2-breeze-style qt6-imageformats qt6-multimedia-ffmpeg qt6-multimedia-gstreamer qt6-virtualkeyboard qt6-wayland quota-tools sddm-kcm spectacle steam steam-native-runtime switcheroo-control systemsettings unarchiver usbguard vlc wacomtablet xdg-desktop-portal-kde xdg-desktop-portal-gtk xdg-user-dirs xdg-user-dirs-gtk yt-dlp"

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
arch-chroot $MOUNT_DIR gpasswd -a $USERNAME gamemode
arch-chroot $MOUNT_DIR gpasswd -a $USERNAME games
