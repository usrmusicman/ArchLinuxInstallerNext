#!/bin/sh

if [[ $CHROOT_ENV == "yes" ]]; then
    # Enter chroot environment
    arch-chroot $MOUNT_DIR

    # Unmount Environment
    unmount -lf $MOUNT_DIR
elif [[ $CHROOT_ENV == "no" ]]; then
    # Unmount Environment
    unmount -lf $MOUNT_DIR
fi
