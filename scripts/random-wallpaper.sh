#!/bin/bash

# Pick a random wallpaper
WALLPAPER=$(find ~/dotfiles/wallpaper -type f | shuf -n 1)

# Generate a new Hyprpaper config
cat > ~/.config/hypr/hyprpaper.conf <<EOF
preload = $WALLPAPER
wallpaper = eDP-1,$WALLPAPER
EOF

# generate pywal colors
wal -i $WALLPAPER

# Restart hyprpaper
pkill hyprpaper
hyprpaper &

killall waybar
waybar &

