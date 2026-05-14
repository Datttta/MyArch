#!/bin/bash

WOFI_CONFIG="$HOME/.config/wofi/menu/menu_initial.conf"
WOFI_STYLE="$HOME/.config/wofi/selector.css"

option=$(printf "Configs\nWaybar\nRicing" | wofi --dmenu --normal-window -c "$WOFI_CONFIG" \
    -s "$WOFI_STYLE")

case "$option" in

    "Ricing")
        WOFI_CONFIG="$HOME/.config/wofi/menu/ricing_sh.conf"
        WOFI_STYLE="$HOME/.config/wofi/menu/ricing_sh.css"
        RICING_DIR="$HOME/Repos/MyArch/storage/scripts/Ricing-showcase"
        PREVIEW_DIR="$RICING_DIR/preview"
        
        # 1. Generate the list with images
        # We loop through scripts and format them for wofi
        list_items=""
        for script in "$RICING_DIR"/*.sh; do
            filename=$(basename "$script")
            # Assume image has the same name as the script but with .png
            # e.g., ricing-1.sh -> preview/ricing-1.png
            img_path="$PREVIEW_DIR/${filename%.sh}.png"
            
            if [ -f "$img_path" ]; then
                # Format for wofi with images
                list_items+="img:$img_path\n"
            else
                # Fallback if no image exists
                list_items+="$filename\n"
            fi
        done

        # 2. Show wofi
        selection=$(echo -e "$list_items" | wofi --dmenu --normal-window -c "$WOFI_CONFIG" --prompt "Select script")

        # 3. execute
        [ -z "$selection" ] && exit

        # 1. Remove the "img:" prefix if it exists and Get just the filename
        clean_name=$(basename "${selection#img:}")

        # 3. Change the extension from .* to .sh
        script_name="${clean_name%.*}.sh"

        bash "$RICING_DIR/$script_name" ;;

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
