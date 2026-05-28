#!/bin/bash

# Extract the current wallpaper path from Waypaper config
WALLPAPER=$(grep '^wallpaper =' ~/.config/waypaper/config.ini | cut -d'=' -f2- | xargs)

# Expand ~ to full path if needed
WALLPAPER="${WALLPAPER/#\~/$HOME}"

# copy image to a folder so hyprlock can use it
mkdir -p ~/.cache/hyprlock
cp "$WALLPAPER" ~/.cache/hyprlock/current_wallpaper

# Run pywal
wal --cols16 --backend haishoku -i "$WALLPAPER"

#if [[ $(basename "$WALLPAPER") == "sky city.jpg" ]]; then
#
#    #wal --cols16 --backend haishoku -i "$WALLPAPER"
#    #wal --cols16 lighten -i "$WALLPAPER"
#    #wal --cols16 --backend colorthief -i "$WALLPAPER"
#
#    #file="$HOME/.cache/wal/rgba-colors.lua"
#
#    #color1=$(grep "color1 =" "$file" | cut -d'"' -f2)
#    #color14=$(grep "color14 =" "$file" | cut -d'"' -f2)
#
#    #sed -i "s|color1 = \".*\"|color1 = \"$color14\"|" "$file"
#    #sed -i "s|color14 = \".*\"|color14 = \"$color1\"|" "$file"
#else
#    wal --cols16 --backend haishoku -i "$WALLPAPER"
#fi

# change order of the colors based on wallpaper
echo "wallpaper: $(basename "$WALLPAPER")"

# Reolad hyprland
hyprctl reload

# Reload kitty
pgrep -x kitty | xargs -r kill -sigusr1

killall swaync
exec swaync

