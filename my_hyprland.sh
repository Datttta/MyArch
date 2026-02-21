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

if ! pacman -Q "vivaldi" >/dev/null; then
    echo "Installing basic apps..."
    sudo pacman -S --noconfirm vivaldi stow hyprland
    echo "Now you must get the ssh keys for your remote repo"
    exit 1
fi

# ===========================
echo "Cloning Vimwiki repo!"
git clone git@github.com:Datttta/Vimwiki.git

echo "Cloning MyArch repo!"
git clone git@github.com:Datttta/MyArch.git
cd MyArch

echo "Stowing files..."
stow --ignore='^sl-.*' *
sudo stow -t / sl-*/

# ============================
echo "Setting sddm permissions..."
sudo setfacl -m u:sddm:x ~/
sudo setfacl -R -m u:sddm:rX,m::rX ~/MyArch/sl-sddm

# ============================
echo "Installing apps..."
sudo pacman -S --noconfirm flatpak libreoffice kvantum copyq yazi fastfetch gamemode zsh wofi waybar swappy rofi pavucontrol kitty
yay -S --noconfirm python-pywal16 wlogout swaync-git waypaper neovim-git



