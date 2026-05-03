cd ~/Repos/MyArch/packages/

echo "Installing flatpak packages..."
flatpak install --noninteractive flathub $(<flatpaklist.txt)

echo "Installing official packages..."
sudo pacman -S --needed - <pkglist.txt

echo "Installing AUR packages..."
yay -S --needed --noconfirm $(<aurlist.txt)

echo "Apps installed."
