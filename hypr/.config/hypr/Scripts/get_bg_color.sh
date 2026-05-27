#!/bin/bash

# Extract the current wallpaper path from Waypaper config
WALLPAPER=$(grep '^wallpaper =' ~/.config/waypaper/config.ini | cut -d'=' -f2- | xargs)

# Expand ~ to full path if needed
WALLPAPER="${WALLPAPER/#\~/$HOME}"

# copy image to a folder so hyprlock can use it
mkdir -p ~/.cache/hyprlock
cp "$WALLPAPER" ~/.cache/hyprlock/current_wallpaper

# Run pywal
wal --cols16 lighten -i "$WALLPAPER"

#Reload kitty
pgrep -x kitty | xargs -r kill -SIGUSR1

#Reolad hyprland
hyprctl reload

killall swaync
exec swaync
