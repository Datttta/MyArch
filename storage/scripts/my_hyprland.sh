#!/bin/bash
shopt -s extglob
set -euo pipefail

echo "............Starting installation..........."

# ===========================
cd
mkdir -p ~/Repos
cd Repos

if [ ! -d "Vimwiki" ]; then 
    echo "Cloning Vimwiki repo!"
    git clone git@github.com:Datttta/Vimwiki.git
fi

if [ ! -d "MyArch" ]; then 
    echo "Cloning MyArch repo!"
    git clone git@github.com:Datttta/MyArch.git
fi

cd MyArch

yay -S --noconfirm --needed stow

echo "Stowing files..."
stow -t ~ !(sl-*|storage)
sudo stow -t / sl-*

# ============================
echo "Installing your apps..."
yay -S --noconfirm --needed flatpak libreoffice kvantum copyq yazi fastfetch gamemode zsh bat wofi waybar swappy rofi pavucontrol kitty python-pywal16 wlogout swaync waypaper anki pear-desktop discord  lutris firefox steam gnome-clocks piper osu timeshift timeshift-autosnap btop deepin-calculator downgrade fd fzf gnome-calendar grub haruna gthumb calibre kalarm zenity grimblast syncthing trash-cli qbittorrent zsh-autosuggestions zsh-completions zsh-syntax-highlighting wl-copy sddm nwg-look hyprlock hyprpaper neovim tty-clock cmatrix cliphist wl-clipboard ripgrep z-library-bin vim imv Clockify-desktop kolourpaint tenki cava pipes.sh gimp sklauncher-bin uwsm zoxide

npm install -g aicommits

echo "Installing system apps & drivers..."
yay -S --noconfirm --needed xorg-xwayland glib2 thunar exfatprogs ntfs-3g aria2 jdk-openjdk intel-ucode linux-lts linux-lts-headers preload linux-zen linux-zen-headers xdg-utils playerctl pacman-contrib brightnessctl python-gobject jq xdg-desktop-portal-hyprland xdg-desktop-portal-gtk polkit-gnome auto-cpufreq bluez blueman bluez-utils corectrl kvantum-qt5 ufw pipewire-pulse pipewire wireplumber libnotify bluez-hid2hci os-prober qt5-wayland qt6-wayland xdg-user-dirs tree unzip zip unrar tar rsync gvfs gvfs-mtp udisks2 npm plymouth plymouth-theme-monoarch-refined tela-circle-icon-theme-standard openssh man-db python-colorthief python-haishoku hyprpolkitagent tumbler ffmpegthumbnailer 

echo "Installing fonts & themes..."
yay -S --noconfirm --needed ttf-dejavu ttf-fira-code ttf-jetbrains-mono-nerd ttf-liberation ttf-ubuntu-font-family woff2-font-awesome noto-fonts-cjk noto-fonts noto-fonts-extra noto-fonts-emoji otf-font-awesome ttf-radio-canada lora-font-git ttf-playfair-variable ttf-vista-fonts

echo "Installing flatpak apps"
flatpak install --noninteractive flathub org.vinegarhq.Sober com.stremio.Stremio

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

# Set up sddm
sudo systemctl enable sddm
sudo setfacl -m u:sddm:x ~/
sudo setfacl -R -m u:sddm:rX,m::rX ~/MyArch/sl-sddm

# set up ufw
sudo ufw --force enable
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22000/tcp
sudo ufw allow 21027/udp

# set up preload
sudo systemctl enable preload
sudo systemctl start preload

# bluetooth
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service

#enable syncthing
systemctl --user enable --now syncthing

# set up autotrash timer
systemctl --user daemon-reload
systemctl --user enable --now trash-clean.timer

# set up auto-cpufreq
sudo systemctl enable --now auto-cpufreq

# set up networkmanager
sudo systemctl enable --now NetworkManager

# set up user groups
for group in wheel video render input storage gamemode; do
    if ! id -nG "$USER" | grep -qw "$group"; then
        sudo usermod -aG "$group" "$USER"
    fi
done
# set up keyboard
sudo localectl set-keymap br-abnt2
sudo localectl set-x11-keymap br abnt2

# set up grub
if grep -q "^GRUB_DISABLE_OS_PROBER=" /etc/default/grub; then
    sudo sed -i 's/^GRUB_DISABLE_OS_PROBER=.*/GRUB_DISABLE_OS_PROBER=false/' /etc/default/grub
else
    echo "GRUB_DISABLE_OS_PROBER=false" | sudo tee -a /etc/default/grub
fi

sudo grub-mkconfig -o /boot/grub/grub.cfg

# set up zsh
chsh -s /bin/zsh "$USER"

# Set up theme
## Intall gtk theme
cd
git clone https://github.com/vinceliuice/Colloid-gtk-theme

cd Colloid-gtk-theme
./install.sh -d ~/.themes -t grey -c dark -l --tweaks black

cd
rm -r Colloid-gtk-theme

## Install icon theme
git clone https://github.com/vinceliuice/Tela-circle-icon-theme

cd Tela-circle-icon-theme
./install.sh

cd 
rm -r Tela-circle-icon-theme

## apply theme
gsettings set org.gnome.desktop.interface icon-theme "Tela-circle"
gsettings set org.gnome.desktop.interface gtk-theme 'Colloid-Grey-Dark'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

echo "-Restart your pc to apply all changes-"
echo "You still have to set up plymouth and aicommits (run aicommits setup (currently using groq for provider))"
