# MyArch

## Requirements

Ensure you have the following installed on your system

## Update packages

```
sudo pacman -Syu
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
git clone git@github.com:Datttta/MyArch.git
cd dotfiles
```

then use GNU stow to create symlinks

```
Stow *
```
youtube video about dotfiles: 

https://www.youtube.com/watch?v=y6XCebnB9gs&list=PLsV9qvkB32_e0Zk2ma962O14yEpv8EuZX&index=1&t=293s

