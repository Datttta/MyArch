#!/bin/bash
echo "Updating package lists..."

cd ~/dotfiles

pacman -Qqen > pkglist.txt
pacman -Qqem > aurlist.txt
flatpak list --app --columns=application > flatpaklist.txt

git add pkglist.txt aurlist.txt
git commit -m "Updating package list"
git push

echo "Done."
