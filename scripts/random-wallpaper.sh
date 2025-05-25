#!/bin/bash

# Pick a random wallpaper
WALLPAPER=$(find ~/dotfiles/wallpaper -type f | shuf -n 1)

# Generate a new Hyprpaper config
cat > ~/.config/hypr/hyprpaper.conf <<EOF
preload = $WALLPAPER
wallpaper = eDP-1,$WALLPAPER
EOF



# Restart hyprpaper
pkill hyprpaper
hyprpaper &

# generate pywal colors
wal --cols16 lighten -i $WALLPAPER

killall waybar
waybar &

