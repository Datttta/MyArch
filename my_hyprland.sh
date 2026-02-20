#!/bin/bash

echo "Starting installation ((change this))(:"

echo "Installing git..."
sudo pacman -S git

echo "Installing yay..."
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
rm -rf ~/yay

echo "Installing flatpak"
sudo pacman -S flatpak

echo "Installing gnu-stow"
sudo pacman -S stow

# ===========================
echo "Stowing files!"
cd
git clone git@github.com:Datttta/MyArch.git
cd MyArch
stow *

# ===========================
echo "Setting sddm"
echo "/home/DROS/MyArch/sddm/themes/my-theme /usr/share/sddm/themes/my-theme none bind 0 0" | sudo tee -a /etc/fstab
sudo mount -a

