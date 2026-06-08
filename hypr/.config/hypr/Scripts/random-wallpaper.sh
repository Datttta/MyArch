#!/bin/bash
echo " ======================= random-wallpaper.sh log file  ======================="

WALL_DIR="$HOME/Repos/MyArch/storage/wallpaper"
PLAYLIST="$HOME/.cache/wallpaper_playlist"
WALL_HASH_FILE="$HOME/.cache/wallpaper_hash"

current_hash() {
    find "$WALL_DIR" -type f \
        ! -name "collection.db" \
        ! -name ".*" \
        | sort | sha256sum | cut -d' ' -f1
}

generate_playlist() {
    find "$WALL_DIR" -type f \
        ! -name "collection.db" \
        ! -name ".*" \
        | shuf > "$PLAYLIST"
}

CURRENT_HASH=$(current_hash)

if [[ ! -f "$WALL_HASH_FILE" ]]; then
    echo "$CURRENT_HASH" > "$WALL_HASH_FILE"
    generate_playlist
else
    SAVED_HASH=$(cat "$WALL_HASH_FILE")

    if [[ "$CURRENT_HASH" != "$SAVED_HASH" ]]; then
        echo "Wallpaper collection changed, regenerating playlist..."
        echo "$CURRENT_HASH" > "$WALL_HASH_FILE"
        generate_playlist
    fi
fi

# Get first wallpaper
WALLPAPER=$(head -n 1 "$PLAYLIST")

# Remove first line from playlist
tail -n +2 "$PLAYLIST" > "${PLAYLIST}.tmp"
mv "${PLAYLIST}.tmp" "$PLAYLIST"

# If playlist became empty, prepare next cycle
if [[ ! -s "$PLAYLIST" ]]; then
    generate_playlist
fi

# Generate pywal colors
echo " ====== wallpaper: $WALLPAPER ======"
bash ~/.config/hypr/Scripts/get_bg_color.sh startup "$WALLPAPER"
