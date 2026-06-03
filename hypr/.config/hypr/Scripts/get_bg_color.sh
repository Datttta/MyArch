#!/bin/bash
echo "============== get_bg_color.sh log file ==============" > /tmp/current_wallpaper

# Extract the current wallpaper path from Waypaper config or from hyprlock
if [[ $1 == "startup" ]]; then
    WALLPAPER="$2"
    echo "startup" >> /tmp/current_wallpaper
    echo "wallpaper: '$(basename "$WALLPAPER")'" >> /tmp/current_wallpaper
else
    WALLPAPER=$(grep '^wallpaper =' ~/.config/waypaper/config.ini | cut -d'=' -f2- | xargs)
    echo "wallpaper: "$WALLPAPER >> /tmp/current_wallpaper
fi

# expand ~ if needed
WALLPAPER="${WALLPAPER/#\~/$HOME}"

# copy image to a folder so hyprlock can use it
mkdir -p ~/.cache/hyprlock
cp "$WALLPAPER" ~/.cache/hyprlock/current_wallpaper

# Run pywal

#if [[ $(basename "$WALLPAPER") == "hyprforest.jpg" ||
#      $(basename "$WALLPAPER") == "tokyo cyberpunk car.png"]]; then

if [[ $(basename "$WALLPAPER") == "retro wave.png" ]]; then

    #wal --cols16 --backend haishoku -i "$WALLPAPER"
    #wal --cols16 lighten -i "$WALLPAPER"
    echo "colorthief" >> /tmp/current_wallpaper
    wal --cols16 --backend colorthief -i "$WALLPAPER"

    #file="$HOME/.cache/wal/rgba-colors.lua"

    #color1=$(grep "color1 =" "$file" | cut -d'"' -f2)
    #color14=$(grep "color14 =" "$file" | cut -d'"' -f2)

    #sed -i "s|color1 = \".*\"|color1 = \"$color14\"|" "$file"
    #sed -i "s|color14 = \".*\"|color14 = \"$color1\"|" "$file"
else
    echo "haishoku" >> /tmp/current_wallpaper
    wal --cols16 --backend haishoku -i "$WALLPAPER"
fi

# Reolad hyprland
hyprctl reload

# Reload kitty
pgrep -x kitty | xargs -r kill -sigusr1
