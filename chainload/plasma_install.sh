#!/bin/sh

# Setup Partitions
clear
source $ABSOLUTE_PATH/components/setup_system_partitions.sh
echo "Partitions mounted successfully..."
sleep 5

# Setup Bootstrap Environment
clear
source $ABSOLUTE_PATH/components/bootstrap_environment.sh
echo "Bootstrap environment setup successfully..."
sleep 5

# Setup System Drivers
clear
source $ABSOLUTE_PATH/components/drivers.sh
echo "Drivers installed successfully..."
sleep 5

# Setup CLI Base System
clear
source $ABSOLUTE_PATH/components/base_system.sh
echo "Base system installed successfully..."
sleep 5

# Setup Bootloader Entry
clear
source $ABSOLUTE_PATH/components/efistub_bootloader_config.sh
echo "Bootloader entry setup successfully..."
sleep 5

# Setup Plasma desktop
clear
source $ABSOLUTE_PATH/components/plasma_desktop.sh
echo "Install Plasma desktop environment successfully..."
sleep 5

# Enter Chroot Environment/Unmount System
clear
source $ABSOLUTE_PATH/components/unmount.sh
echo "Unmounted system successfully..."
sleep 5
