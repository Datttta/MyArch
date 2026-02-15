#!/bin/bash

THEME="$1"
THEME_DIR="$HOME/.config/waybar/themes/$THEME"

cp "$THEME_DIR/config.jsonc" "$HOME/.config/waybar/config"
cp "$THEME_DIR/style.css" "$HOME/.config/waybar/style.css"

killall waybar
waybar & disown

echo "Switched to Waybar theme: $THEME"

