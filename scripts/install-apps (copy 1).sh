cd ~/dotfiles/packages/

echo "Installing flatpak packages..."
flatpak install --noninteractive flathub $(<flatpaklist.txt)

echo "Installing official packages..."
sudo pacman -S --needed - <pkglist.txt

echo "Installing AUR packages..."
yay -S --needed --noconfirm $(<aurlist.txt)

echo "Apps installed."

cd ~/dotfiles/sddm/

echo "copying sddm-astronaut-theme to /usr/share/sddm/themes/"
sudo cp sddm-astronaut-theme /usr/share/sddm/themes/

echo "Copying sddm.conf to /etc/"
sudo cp sddm.conf /etc/

echo "sddm copied."
