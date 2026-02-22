#!/bin/bash

echo "Starting installation ((change this))(:"

if ! pacman -Q "git" > /dev/null; then 
    echo "Installing git..."
    sudo pacman -Syu --noconfirm base-devel git 
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
    yay -S --noconfirm vivaldi stow hyprland neovim
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
yay -S --noconfirm flatpak libreoffice kvantum copyq yazi fastfetch gamemode zsh wofi waybar swappy rofi pavucontrol kitty python-pywal16 wlogout swaync waypaper anki pear-desktop discord bluez blueman bluez-utils lutris corectrl firefox steam gnome-clocks piper stremio osu timeshift timeshift-autosnap btop cmatrix cpupower deepin-calculator downgrade fd fzf gnome-calendar grub haruna gthumb calibre kalarm kvantum-qt5 zenity grimblast syncthing trash-cli tree unrar tar rsync qbittorrent ufw zsh-autosuggestions zsh-completions zsh-syntax-highlighting wl-copy xorg-xwayland gvfs glib2 thunar exfatprogs ntfs-3g aria2 jdk-openjdk intel-ucode linux-lts linux-lts-headers preload linux-zen linux-zen-headers xdg-utils playerctl networkmanager

echo "Installing fonts..."
yay -S --noconfirm ttf-dejavu ttf-fira-code ttf-jetbrains-mono-nerd ttf-liberation ttf-ubuntu-font-family woff2-font-awesome noto-fonts-cjk noto-fonts noto-fonts-extra noto-fonts-emoji otf-font-awesome ttf-radio-canada

# ==========================
echo "Setting default apps..."

# --- Multimedia  ---
xdg-mime default org.kde.haruna.desktop video/vnd.avi
xdg-mime default org.kde.haruna.desktop video/x-msvideo
xdg-mime default org.kde.haruna.desktop video/x-matroska
xdg-mime default org.kde.haruna.desktop video/mp4

xdg-mime default org.gnome.gThumb.desktop image/png
xdg-mime default org.gnome.gThumb.desktop image/jpeg

# --- Text & Documents ---
xdg-mime default nvim.desktop text/plain
xdg-mime default nvim.desktop application/x-desktop

xdg-mime default calibre-gui.desktop application/epub+zip
xdg-mime default calibre-gui.desktop application/x-mobipocket-ebook

xdg-mime default libreoffice-writer.desktop application/vnd.openxmlformats-officedocument.wordprocessingml.document

# ==========================
echo "Setting up your hyprland....."

# activate timer to delete files older than 30 days from trash bin
systemctl --user daemon-reload
systemctl --user enable trash-clean.timer
systemctl --user start trash-clean.timer

# set up ufw
sudo systemctl enable ufw
sudo systemctl start ufw

# set up preload
sudo systemctl enable preload
sudo systemctl start preload

# bluetooth
sudo systemctl enable bluetooth
sudo systemctl start bluetooth

# set up networkmanager
sudo systemctl enable --now NetworkManager

# reload grub
sudo grub-mkconfig -o /boot/grub/grub.cfg
