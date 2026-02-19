echo "Starting installation ((change this))(:"

echo "Installing yay..."
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
rm -rf ~/yay

echo "Installing git..."
sudo pacman -S git

echo "Installing flatpak"
sudo pacman -S flatpak

echo "Installing gnu-stow"
sudo pacman -S stow

# ===========================
echo "Stowing files!"
cd
git clone git@github.com:Datttta/MyArch.git
cd dotfiles
stow *

