# MyArch

## Requirements

Ensure you have the following installed on your system

## Update packages

```
sudo pacman -Syu
```

### yay

```
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

### Git

```
pacman -S git
```

### Stow

```
pacman -S stow
```
### Flatpak

```
sudo pacman -S flatpak
```

## Instalation

First, check out the dotfiles repo in your $HOME directory using git

```
cd
git clone git@github.com:Datttta/MyArch.git
cd dotfiles
```

then use GNU stow to create symlinks (If it doesn't work use "stow" for each file, e.g. stow hyprland kitty rofi...

```
Stow *
```
still on cd ~/dotfiles run install-apps.sh

```
./intall-apps.sh
```
in case of "push" failure, run

```
git pull origin main --rebase
```
and then run ./install-apps.sh again
youtube video about dotfiles: 

https://www.youtube.com/watch?v=y6XCebnB9gs&list=PLsV9qvkB32_e0Zk2ma962O14yEpv8EuZX&index=1&t=293s

