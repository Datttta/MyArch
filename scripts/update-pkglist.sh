#!/bin/bash
echo "Updating package lists..."

cd ~/dotfiles

pacman -Qqen > pkglist.txt
pacman -Qqem > aurlist.txt
flatpak list --app --columns=application > flatpaklist.txt

git add .
git commit -m "General update"
git push

echo "Done and added to git repository."
