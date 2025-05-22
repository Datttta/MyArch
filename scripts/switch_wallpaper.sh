#!/bin/bash

# Array of wallpapers
WALLPAPERS=(
    "$HOME/Pictures/wallpaper/theMage.jpg"
    "$HOME/Pictures/wallpaper/sun.jpg"
    "$HOME/Pictures/wallpaper/wallhaven-yx6e9l.jpg"
    "$HOME/Pictures/wallpaper/hyprforest.jpg"
    "$HOME/Pictures/wallpaper/Hypr-chan.png"
)

# File to store index
INDEX_FILE="$HOME/.config/hypr/.wallpaper_index"

# Read index
if [[ -f "$INDEX_FILE" ]]; then
    index=$(cat "$INDEX_FILE")
else
    index=0
fi
# Next index
next_index=$(( (index + 1) % ${#WALLPAPERS[@]} ))

# Apply wallpaper
hyprctl hyprpaper wallpaper "eDP-1,${WALLPAPERS[$next_index]}"

# Generate pywal colors
wal -i ${WALLPAPERS[$next_index]}

# Save new index
echo "$next_index" > "$INDEX_FILE"

