#!/bin/bash

option=$(printf "Configs\nWaybar\nTeste" | wofi --dmenu --normal-window)

case "$option" in

    "Teste") bash "$HOME/test.sh" ;;

    "Waybar")
        DIR="$HOME/.config/waybar/themes"
        THEME=$(ls "$DIR" | wofi --dmenu --normal-window --sort-order=alphabetical "Waybar theme:")

        if [ -n "$THEME" ]; then
            ~/.config/waybar/scripts/waybar-switcher.sh "$THEME"
        fi ;;

    "Configs") 
        option=$(printf ".config/\nTime-manager/\nConfig-manager.sh\nmy_hyprland.sh\n.zshrc" | wofi --dmenu --normal-window)
        case "$option" in
            ".config/") choosen="$HOME/.config" ;;
            "Time-manager/") choosen="$HOME/Repos/Time_manager" ;;

            ".zshrc") kitty nvim .zshrc ;;
            "Config-manager.sh") kitty --directory "~/.config/hypr/Scripts" nvim waybar-selector.sh ;;
            "my_hyprland.sh") kitty --directory "~/Repos/MyArch/storage/scripts/" nvim my_hyprland.sh ;;
        esac 
esac

if [ -v choosen ]; then

    CURRENT_DIR="$choosen"

    while true; do
        list=$(ls -1AFL "$CURRENT_DIR" | grep -v '^\./$' | sed 's/\*$//')
        
        selection=$(printf "../\n$list" | wofi --dmenu --normal-window --prompt "${CURRENT_DIR#$HOME/}")

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
            
            kitty --directory "$CURRENT_DIR" nvim "$FULL_PATH"
            break
        fi
    done
fi
