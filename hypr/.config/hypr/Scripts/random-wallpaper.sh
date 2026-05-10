#!/bin/bash

WALL_DIR=~/Repos/MyArch/storage/wallpaper/

# Expand ~ safely
WALL_DIR="${WALL_DIR/#\~/$HOME}"

# Validate directory exists
if [[ ! -d "$WALL_DIR" ]]; then
    echo "ERROR: Wallpaper directory does not exist: $WALL_DIR" >&2
    exit 1
fi

LAST_FILE=~/.cache/last_wallpaper

mkdir -p ~/.cache

while [[ -z "$(hyprctl monitors 2>/dev/null)" ]]; do
    sleep 0.1
done

# If last wallpaper exists, exclude it
if [[ -f "$LAST_FILE" ]]; then
    LAST=$(cat "$LAST_FILE")

    # Build list excluding last
    WALLPAPER=$(find "$WALL_DIR" -type f -not -name "collection.db" | grep -vxF "$LAST" | shuf -n 1)

    # If exclusion leaves nothing (only 1 wallpaper exists), fallback
    if [[ -z "$WALLPAPER" ]]; then
        WALLPAPER=$(find "$WALL_DIR" -type f | shuf -n 1)
    fi
else
    WALLPAPER=$(find "$WALL_DIR" -type f | shuf -n 1)
fi

# Save current as last
echo "$WALLPAPER" > "$LAST_FILE"

# Generate Hyprpaper config
cat > ~/.config/hypr/hyprpaper.conf <<EOF
preload = $WALLPAPER
wallpaper = ,$WALLPAPER
EOF

mkdir -p ~/.cache/hyprlock
cp "$WALLPAPER" ~/.cache/hyprlock/current_wallpaper

# Restart hyprpaper
pkill hyprpaper
hyprpaper &

# Generate pywal colors
wal --cols16 lighten -i "$WALLPAPER"

killall waybar

# We check if the card* device is initialized in /dev/dri/
while [ ! -d /dev/dri ] || [ -z "$(ls /dev/dri/card* 2>/dev/null)" ]; do
    sleep 0.5
done

waybar &

killall swaync
exec swaync

