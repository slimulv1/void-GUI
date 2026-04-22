#!/bin/bash
# Automount script without vfat or ntfs partitions; only partitions with a file system that is not vfat or ntfs will be mounted.
echo "Start the automount script..."

# Determine all partitions with a file system (check only 'part' and 'fstype')
for dev in $(lsblk -lnpo NAME,FSTYPE,TYPE | awk '$2 && $3 == "part" {print $1}'); do
    echo "Check device: $dev"

    # Check if the file system is vfat or ntfs
    fstype=$(lsblk -no FSTYPE "$dev")
    
    # Skip vfat and ntfs partitions
    if [[ "$fstype" == "vfat" || "$fstype" == "ntfs" ]]; then
        echo "Skip partition with $fstype: $dev"
        continue
    fi

    # Check if the partition is already mounted
    if ! mount | grep -q "$dev"; then
        echo "Mounting $dev..."
        udisksctl mount -b "$dev" || echo "Error mounting $dev"
    else
        echo "$dev is already integrated."
    fi
done

echo "Automount script terminated."
