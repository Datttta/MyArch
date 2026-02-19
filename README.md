# MyArch

## Requirements

Ensure you have the following installed on your system

### Update packages

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
sudo pacman -S git
```

### Stow

```
sudo pacman -S stow
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

On cd ~/dotfiles run install-apps.sh

```
./intall-apps.sh
```

in case of "push" failure, run the command bellow and then run ./install-apps.sh again

```
git pull origin main --rebase
```

then use GNU stow to create symlinks (If it doesn't work use "stow" for each file, e.g. stow hyprland kitty rofi...

```
Stow .
```

if it doesn't work try

```
Stow *
```

use sudo stow -t / slashconfs to add confs of /directorys e.g. /etc/, /usr/ ...

```
sudo stow -t / slashConfs
```

after that, run:

```
chmod o+rx /home/DROS
```

give permission to other users to access and read slashConfs:

```
chmod -R o+rx /home/DROS/dotfiles/slashConfs/*
```

you can use the comman bellow to everyfile if the command above didn't work:

```
chmod -R o+rx /home/DROS/dotfiles/slashConfs/usr/share/sddm/themes
```

youtube video about dotfiles:

https://www.youtube.com/watch?v=y6XCebnB9gs&list=PLsV9qvkB32_e0Zk2ma962O14yEpv8EuZX&index=1&t=293s
