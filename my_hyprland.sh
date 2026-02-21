#!/bin/bash

echo "Starting installation ((change this))(:"

if ! pacman -Q "git" > /dev/null; then 
    echo "Installing git..."
    sudo pacman -S git
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
    sudo pacman -S flatpak
fi

if ! pacman -Q "stow" > /dev/null; then
    echo "Installing gnu-stow..."
    sudo pacman -S stow
fi

if ! pacman -Q "browsh" > /dev/null; then
    echo "Installing browsh browser..."
    yay -S browsh
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
