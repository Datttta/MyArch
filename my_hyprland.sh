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
    yay -S --noconfirm vivaldi stow hyprland
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
yay -S --noconfirm flatpak libreoffice kvantum copyq yazi fastfetch gamemode zsh wofi waybar swappy rofi pavucontrol kitty python-pywal16 wlogout swaync waypaper neovim anki pear-desktop discord bluez bluez-utils lutris corectrl firefox steam gnome-clocks piper stremio osu timeshift timeshift-autosnap btop cmatrix cpupower deepin-calculator downgrade fd fzf gnome-calendar grub haruna

echo "Installing fonts..."
yay -S --noconfirm ttf-dejavu ttf-fira-code ttf-jetbrains-mono-nerd ttf-liberation ttf-ubuntu-font-family woff2-font-awesome noto-fonts-cjk noto-fonts noto-fonts-extra noto-fonts-emoji otf-font-awesome ttf-radio-canada
