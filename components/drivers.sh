#!/bin/sh

# AMD DRIVERS
AMD_GPU_DRV="lib32-libva-mesa-driver lib32-opencl-rusticl-mesa lib32-vulkan-radeon libva-mesa-driver libva-utils opencl-rusticl-mesa rocm-hip-runtime rocm-language-runtime rocm-opencl-runtime rocminfo vulkan-radeon vulkan-mesa-layers"

# INTEL DRIVERS
INTEL_GPU_DRV="gst-plugin-qsv intel-compute-runtime intel-media-driver intel-media-sdk lib32-libva-intel-driver lib32-libva-mesa-driver lib32-vulkan-intel lib32-vulkan-mesa-layers libva-intel-driver libva-mesa-driver libva-utils onevpl-intel-gpu vulkan-intel vulkan-mesa-layers"

# NVIDIA DRIVERS
NVIDIA_GPU_DRV="lib32-nvidia-utils lib32-opencl-nvidia libva-nvidia-driver libva-utils nvidia-dkms nvidia-utils opencl-nvidia"

# OTHER DRIVERS
OTHER_GPU_DRV="lib32-mesa lib32-libva-mesa-driver libva-mesa-driver libva-utils mesa"

# OTHER DRIVERS
VIRTUALBOX_GPU_DRV="lib32-mesa lib32-libva-mesa-driver libva-mesa-driver libva-utils mesa virtualbox-guest-iso virtualbox-guest-utils"

# Install the display drivers
if [[ "${_GPU}" == "amd" ]]; then
    # Install AMD GPU drivers
    arch-chroot $MOUNT_DIR pacman -S --noconfirm $AMD_GPU_DRV
elif [[ "${_GPU}" == "intel" ]]; then
    # Install Intel GPU drivers
    arch-chroot $MOUNT_DIR pacman -S --noconfirm $INTEL_GPU_DRV
elif [[ "${_GPU}" == "nvidia" ]]; then
    # Install Nvidia GPU drivers
    arch-chroot $MOUNT_DIR pacman -S --noconfirm $NVIDIA_GPU_DRV

    # Enable Nvidia related services
    arch-chroot $MOUNT_DIR systemctl enable nvidia-hibernate
    arch-chroot $MOUNT_DIR systemctl enable nvidia-persistenced
    arch-chroot $MOUNT_DIR systemctl enable nvidia-powerd.service
    arch-chroot $MOUNT_DIR systemctl enable nvidia-resume
    arch-chroot $MOUNT_DIR systemctl enable nvidia-suspend
elif [[ "${_GPU}" == "other" ]]; then
    # Install Intel GPU drivers
    arch-chroot $MOUNT_DIR pacman -S --noconfirm $OTHER_GPU_DRV
elif [[ "${_GPU}" == "virtualbox" ]]; then
    # Install Virualbox Utilities
    arch-chroot $MOUNT_DIR pacman -S --noconfirm $VIRTUALBOX_GPU_DRV
fi

# Install CPU Microcode
if [[ "${_CPU}" == "amd" ]]; then
    # Install AMD CPU Firmware
    arch-chroot $MOUNT_DIR pacman -S --noconfirm amd-ucode
elif [[ "${_CPU}" == "intel" ]]; then
    # Install Intel CPU Firmware
    arch-chroot $MOUNT_DIR pacman -S --noconfirm intel-ucode
elif [[ "${_CPU}" == "other" ]]; then
    echo "No microcode needed..."
    sleep 3
fi
