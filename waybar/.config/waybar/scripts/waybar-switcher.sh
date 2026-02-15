#!/bin/bash

THEME="$1"
BASE="$HOME/.config/waybar"
THEME_DIR="$BASE/themes/$THEME"

# Remove old links
rm -f "$BASE/config.jsonc"
rm -f "$BASE/style.css"

# Create new symlinks
ln -s "$THEME_DIR/config.jsonc" "$BASE/config.jsonc"
ln -s "$THEME_DIR/style.css" "$BASE/style.css"

killall waybar
waybar & disown
