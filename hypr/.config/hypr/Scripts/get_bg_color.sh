#!/bin/bash
log_path="/tmp/mylogs/current_wallpaper"
echo "============== get_bg_color.sh log file ==============" > $log_path

# Extract the current wallpaper path from Waypaper config or from hyprlock
if [[ $1 == "startup" ]]; then
    WALLPAPER="$2"
    echo "startup" >> $log_path
    echo "wallpaper: '$(basename "$WALLPAPER")'" >> $log_path

    # wait for hyprpaper
    while ! hyprctl hyprpaper listactive >/dev/null 2>&1; do
        sleep 0.5
    done

else
    WALLPAPER=$(grep '^wallpaper =' ~/.config/waypaper/config.ini | cut -d'=' -f2- | xargs)
    echo "wallpaper: "$WALLPAPER >> $log_path
fi

# expand ~ if needed
WALLPAPER="${WALLPAPER/#\~/$HOME}"

# copy image to a folder so hyprlock can use it
mkdir -p ~/.cache/hyprlock
cp "$WALLPAPER" ~/.cache/hyprlock/current_wallpaper

# Run pywal
if [[ $(basename "$WALLPAPER") == "retro wave.png" ||
    $(basename "$WALLPAPER") == "Atmosphere.jpg" || 
    $(basename "$WALLPAPER") == "japan city.png" ]]; then

    #wal --cols16 --backend haishoku -i "$WALLPAPER"
    #wal --cols16 lighten -i "$WALLPAPER"
    echo "colorthief" >> $log_path
    wal --cols16 --backend colorthief -i "$WALLPAPER"

    #file="$HOME/.cache/wal/rgba-colors.lua"

    #color1=$(grep "color1 =" "$file" | cut -d'"' -f2)
    #color14=$(grep "color14 =" "$file" | cut -d'"' -f2)

    #sed -i "s|color1 = \".*\"|color1 = \"$color14\"|" "$file"
    #sed -i "s|color14 = \".*\"|color14 = \"$color1\"|" "$file"
else
    echo "haishoku" >> $log_path
    wal --cols16 --backend haishoku -i "$WALLPAPER"
fi

# Reolad hyprland
hyprctl reload

# Reload swaync
killall swaync &
swaync

# Reload kitty
pgrep -x kitty | xargs -r kill -sigusr1
