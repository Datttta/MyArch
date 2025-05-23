#!/bin/bash

# Extract the current wallpaper path from Waypaper config
WALLPAPER=$(grep '^wallpaper =' ~/.config/waypaper/config.ini | cut -d'=' -f2- | xargs)

# Expand ~ to full path if needed
WALLPAPER="${WALLPAPER/#\~/$HOME}"

# Run pywal
wal -i "$WALLPAPER"

# Restart Waybar
killall waybar
waybar & 
