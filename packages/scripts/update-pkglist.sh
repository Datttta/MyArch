#!/bin/bash
echo "Updating package lists..."

cd ~/dotfiles

pacman -Qqen > packages/pkglist.txt
pacman -Qqem > packages/aurlist.txt
flatpak list --app --columns=application > packages/flatpaklist.txt

git add .
git commit -m "General update"
git push

echo "Done and added to git repository."
