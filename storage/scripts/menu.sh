#!/bin/bash

WOFI_CONFIG="$HOME/.config/wofi/menu/menu_initial.conf"
WOFI_STYLE="$HOME/.config/wofi/selector.css"

option=$(printf "Configs\nWaybar\nRicing" | wofi --dmenu --normal-window -c "$WOFI_CONFIG" \
    -s "$WOFI_STYLE")

case "$option" in

    "Ricing")
        WOFI_CONFIG="$HOME/.config/wofi/menu/ricing_sh.conf"
        WALL_DIR="$HOME/Repos/MyArch/storage/wallpaper/"
        SCRIPT_DIR="$HOME/Repos/MyArch/storage/scripts/Ricing-showcase"

        LIST=""

        for img in "$WALL_DIR"/*.{png,jpg,jpeg,webp}; do
            [ -f "$img" ] || continue

            name=$(basename "$img")
            script="${name%.*}.sh"

            LIST+="img:$img:text:$script\n"
        done

        selected=$(
            echo -e "$LIST" | wofi --dmenu --normal-window -c "$WOFI_CONFIG" --prompt "Select Rice")

        [ -z "$selected" ] && exit

        bash "$SCRIPT_DIR/$selected"
    ;;

    "Waybar")
        DIR="$HOME/.config/waybar/themes"
        THEME=$(ls "$DIR" | wofi --dmenu --normal-window --sort-order=alphabetical -s "$WOFI_STYLE" "Waybar theme:")

        if [ -n "$THEME" ]; then
            ~/.config/waybar/scripts/waybar-switcher.sh "$THEME"
        fi ;;

    "Configs") 
        option=$(printf ".config/\n/usr/share/applications\n.local/share/applications\nTime-manager/\nmenu.sh\nmy_hyprland.sh\n.zshrc" | wofi --dmenu --normal-window -s "$WOFI_STYLE")
        case "$option" in
            ".config/") choosen="$HOME/.config" ;;
            "/usr/share/applications") choosen="/usr/share/applications" ;;
            ".local/share/applications") choosen="$HOME/.local/share/applications" ;;
            "Time-manager/") choosen="$HOME/Repos/Time_manager" ;;

            ".zshrc") kitty nvim .zshrc ;;
            "menu.sh") kitty --directory "~/Repos/MyArch/storage/scripts/" nvim menu.sh ;;
            "my_hyprland.sh") kitty --directory "~/Repos/MyArch/storage/scripts/" nvim my_hyprland.sh ;;
        esac 
esac

if [ -v choosen ]; then

    CURRENT_DIR="$choosen"

    while true; do
        list=$(ls -1AFL "$CURRENT_DIR" | grep -v '^\./$' | sed 's/\*$//')
        
        selection=$(printf "../\n$list" | wofi --dmenu --normal-window -s "$WOFI_STYLE" --prompt "${CURRENT_DIR#$HOME/}")

        [ -z "$selection" ] && break

        if [ "$selection" = "../" ]; then
            # Go up a level
            if [ "$CURRENT_DIR" != "$HOME" ]; then
                CURRENT_DIR=$(dirname "$CURRENT_DIR")
            fi
        elif [[ "$selection" == */ ]]; then
            # If it ends in /, it's a directory. 
            # We strip the / and update the current path.
            CURRENT_DIR="${CURRENT_DIR}/${selection%/}"
        else
            # It's a file. Open it!
            FULL_PATH="$CURRENT_DIR/$selection"

            if [[ "$CURRENT_DIR" == /usr* ]]; then
                kitty --directory "$CURRENT_DIR" sudoedit "$FULL_PATH"
            else
                kitty --directory "$CURRENT_DIR" nvim "$FULL_PATH"
            fi

            break
        fi
    done
fi
