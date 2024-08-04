#!/bin/sh

# System root partition UUID
BOOTENTRY_UUID=`lsblk $SYSTEM_ROOT -o UUID | tr "\n" " " | cut -d " " -f 2`

# Boot commandline options
BOOT_OPTIONS="preempt=full root=UUID=$BOOTENTRY_UUID resume=UUID=$BOOTENTRY_UUID threadirqs quiet splash"

if [[ "${_CPU}" == "amd" ]]; then
    # Create EFIStub boot entry
    arch-chroot $MOUNT_DIR efibootmgr --create --disk ${SYSTEM_DRIVE} --part 1 --label "$UEFI_NAME" --loader /vmlinuz-${KERNEL} --unicode "rootflags=subvol=@,noatime,rw rootfstype=btrfs ${BOOT_OPTIONS} initrd=\amd-ucode.img initrd=\initramfs-${KERNEL}.img" --verbose
elif [[ "${_CPU}" == "intel" ]]; then
    # Create EFIStub boot entry
    arch-chroot $MOUNT_DIR efibootmgr --create --disk ${SYSTEM_DRIVE} --part 1 --label "$UEFI_NAME" --loader /vmlinuz-${KERNEL} --unicode "rootflags=subvol=@,noatime,rw rootfstype=btrfs ${BOOT_OPTIONS} initrd=\intel-ucode.img initrd=\initramfs-${KERNEL}.img" --verbose
else
    # Create EFIStub boot entry
    arch-chroot $MOUNT_DIR efibootmgr --create --disk ${SYSTEM_DRIVE} --part 1 --label "$UEFI_NAME" --loader /vmlinuz-${KERNEL} --unicode "rootflags=subvol=@,noatime,rw rootfstype=btrfs ${BOOT_OPTIONS} initrd=\initramfs-${KERNEL}.img" --verbose
fi
