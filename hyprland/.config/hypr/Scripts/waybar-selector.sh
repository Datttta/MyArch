#!/bin/bash

DIR="$HOME/.config/waybar/themes"
THEME=$(ls "$DIR" | wofi --dmenu --normal-window --sort-order=alphabetical "Waybar theme:")

if [ -n "$THEME" ]; then
    ~/.config/waybar/scripts/waybar-switcher.sh "$THEME"
fi

