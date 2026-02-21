#!/bin/bash

echo "Starting installation ((change this))(:"

if ! pacman -Q "git" > /dev/null; then 
    echo "Installing git..."
    sudo pacman -S --noconfirm git 
fi

if ! pacman -Q "yay" > /dev/null; then
    echo "Installing yay..."
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd
    rm -rf ~/yay
fi

if ! pacman -Q "flatpak" > /dev/null; then
    echo "Installing flatpak..."
    sudo pacman -S --noconfirm flatpak
fi

if ! pacman -Q "stow" > /dev/null; then
    echo "Installing gnu-stow..."
    sudo pacman -S --noconfirm stow
fi

if ! pacman -Q "hyprland" > /dev/null; then
    echo "Installing hyprland!!"
    yay -S --noconfirm hyprland
fi

if ! pacman -Q "vivaldi" >/dev/null; then
    echo "Installing vivaldi browser..."
    sudo pacman -S --noconfirm vivaldi
    echo "Now you must get the ssh keys for you remote repo"
    exit 1
fi

# ===========================
echo "Cloning repo!"
git clone git@github.com:Datttta/MyArch.git
cd MyArch

echo "Stowing files..."
stow --ignore='^sl-.*' *
sudo stow -t / sl-*/

# ===========================
echo "Setting sddm permissions..."
sudo setfacl -m u:sddm:x ~/
sudo setfacl -R -m u:sddm:rX,m::rX ~/MyArch/sl-sddm
