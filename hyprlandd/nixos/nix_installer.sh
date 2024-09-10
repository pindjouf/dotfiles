#!/usr/bin/env bash

set -e

if [[ $EUID -ne 0 ]]; then
   printf "Run the script as root\n" 
   exit 1
fi

ram_size=$(free -m | awk '/^Mem:/{print $2}')

if [[ $ram_size -lt 4096 ]]; then
    swap_size=$(($ram_size * 2))
else
    swap_size=$ram_size
fi

function confirm() {
    read -r -p "${1:-Are you sure?} [y/N] " response
    case "$response" in
        [yY][eE][sS]|[yY]) 
            true
            ;;
        *)
            false
            ;;
    esac
}

function diskDetector() {
    echo "Available disks:"
    lsblk -d -n -p -o NAME,SIZE,MODEL
    read -r -p "Enter the full path of the disk to use (e.g., /dev/sda): " disk
    if [ ! -b "$disk" ]; then
        echo "Error: $disk is not a valid block device."
        exit 1
    fi
    confirm "Are you sure you want to use $disk? This will erase all data on the disk." || exit 1
}

# Main
printf "Welcome to the NixOS installer script\n"

diskDetector

# Detect boot mode
if [[ -d "/sys/firmware/efi" ]]; then
    boot_mode="uefi"
else
    boot_mode="bios"
    printf "This script doesn't currently support legacy bios sorry :(\n"
    exit 0
fi

printf "\n"
printf "Detected boot mode: $boot_mode\n"

# UEFI (GPT) partition scheme
printf "\n"
printf "Partitioning your nix system...\n"
printf "\n"
parted "$disk" -- mklabel gpt
parted "$disk" -- mkpart root ext4 512MB -8GB
parted "$disk" -- mkpart swap linux-swap -${swap_size}MB 100%
parted "$disk" -- mkpart ESP fat32 1MB 512MB
parted "$disk" -- set 3 esp on

# Formatting
printf "\n"
printf "Formatting your nix system...\n"
printf "\n"
mkfs.ext4 -L nixos "$disk"1
mkswap -L swap "$disk"2
mkfs.fat -F 32 -n boot "$disk"3

# Install System
printf "\n"
printf "Installing the base system...\n"
printf "\n"
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount -o umask=077 /dev/disk/by-label/boot /mnt/boot
swapon "$disk"2
nixos-generate-config --root /mnt

# Get My Config From GitHub
printf "\n"
printf "Getting your configuration.nix file from GitHub...\n"
printf "\n"
nix-env -iA nixpkgs.git
git clone https://github.com/pindjouf/dotfiles.git
mv dotfiles/hyprlandd/nixos/configuration.nix /mnt/etc/nixos/configuration.nix
rm -r dotfiles
nixos-install

printf "\n"
printf "NixOS installation complete!\n"
printf "\n"

confirm "Do you want to reboot now?" && reboot || printf "You can reboot manually when ready.\n"
