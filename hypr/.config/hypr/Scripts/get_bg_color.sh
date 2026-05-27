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

# change order of the colors based on wallpaper
echo "wallpaper: $(basename "$WALLPAPER")"

if [[ $(basename "$WALLPAPER") == "arc.jpg" ]]; then

    echo "changing background" > /tmp/get_bg_color.log
    
    current_color=$(grep "background" ~/.cache/wal/colors-kitty.conf | awk '{print $2}')
    new_color=$(convert xc:"$current_color" -modulate 45 -format "%[hex:u]" info:)

    # Apply the new color
    sed -i "s/^background.*/background #$new_color/" ~/.cache/wal/colors-kitty.conf

    #file="$HOME/.cache/wal/rgba-colors.lua"

    #color1=$(grep "color1 =" "$file" | cut -d'"' -f2)
    #color14=$(grep "color14 =" "$file" | cut -d'"' -f2)

    #sed -i "s|color1 = \".*\"|color1 = \"$color14\"|" "$file"
    #sed -i "s|color14 = \".*\"|color14 = \"$color1\"|" "$file"

    #Reload kitty
    for sock in /tmp/mykitty-*; do
        kitty @ --to "unix:$sock" set-colors -a ~/.cache/wal/colors-kitty.conf
    done

fi


#Reolad hyprland
hyprctl reload

killall swaync
exec swaync

