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
echo "Setting sddm permissions..."
sudo setfacl -m u:sddm:x /home/DROS
sudo setfacl -R -m u:sddm:rX,m::rX /home/DROS/MyArch/slashConfs/
