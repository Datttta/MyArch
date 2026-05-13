#!/bin/bash

option=$(printf "Configs\nWaybar\nRicing" | wofi --dmenu --normal-window)

case "$option" in

    "Ricing") 
        option=$(printf "ricing-1.sh\nricing-2.sh\nricing-3.sh\nricing-4.sh\nricing-4_blur.sh\nricing-5.sh\nricing-6_blur.sh\nricing-7.sh\nricing-8_blur.sh\nricing-9.sh\nricing-9_blur.sh\nricing-10.sh\nricing-11.sh\nricing-12.sh\nricing-13_blur.sh\nricing-14.sh\nricing-7_blur.sh\nricing-15.sh\nricing-16.sh\nricing-16_blur.sh\nricing-17.sh\nricing-18.sh\nricing-19.sh" | wofi --dmenu --normal-window)
        case "$option" in
            "ricing-1.sh") bash "$HOME/Repos/MyArch/storage/scripts/Ricing-showcase/ricing-1.sh" ;;
            "ricing-2.sh") bash "$HOME/Repos/MyArch/storage/scripts/Ricing-showcase/ricing-2.sh" ;;
            "ricing-3.sh") bash "$HOME/Repos/MyArch/storage/scripts/Ricing-showcase/ricing-3.sh" ;;
            "ricing-4.sh") bash "$HOME/Repos/MyArch/storage/scripts/Ricing-showcase/ricing-4.sh" ;;
            "ricing-4_blur.sh") bash "$HOME/Repos/MyArch/storage/scripts/Ricing-showcase/ricing-4_blur.sh" ;;
            "ricing-5.sh") bash "$HOME/Repos/MyArch/storage/scripts/Ricing-showcase/ricing-5.sh" ;;
            "ricing-6_blur.sh") bash "$HOME/Repos/MyArch/storage/scripts/Ricing-showcase/ricing-6_blur.sh" ;;
            "ricing-7.sh") bash "$HOME/Repos/MyArch/storage/scripts/Ricing-showcase/ricing-7.sh" ;;
            "ricing-8_blur.sh") bash "$HOME/Repos/MyArch/storage/scripts/Ricing-showcase/ricing-8_blur.sh" ;;
            "ricing-9.sh") bash "$HOME/Repos/MyArch/storage/scripts/Ricing-showcase/ricing-9.sh" ;;
            "ricing-9_blur.sh") bash "$HOME/Repos/MyArch/storage/scripts/Ricing-showcase/ricing-9_blur.sh" ;;
            "ricing-10.sh") bash "$HOME/Repos/MyArch/storage/scripts/Ricing-showcase/ricing-10.sh" ;;
            "ricing-11.sh") bash "$HOME/Repos/MyArch/storage/scripts/Ricing-showcase/ricing-11.sh" ;;
            "ricing-12.sh") bash "$HOME/Repos/MyArch/storage/scripts/Ricing-showcase/ricing-12.sh" ;;
            "ricing-13_blur.sh") bash "$HOME/Repos/MyArch/storage/scripts/Ricing-showcase/ricing-13_blur.sh" ;;
            "ricing-14.sh") bash "$HOME/Repos/MyArch/storage/scripts/Ricing-showcase/ricing-14.sh" ;;
            "ricing-7_blur.sh") bash "$HOME/Repos/MyArch/storage/scripts/Ricing-showcase/ricing-7_blur.sh" ;;
            "ricing-15.sh") bash "$HOME/Repos/MyArch/storage/scripts/Ricing-showcase/ricing-15.sh" ;;
            "ricing-16.sh") bash "$HOME/Repos/MyArch/storage/scripts/Ricing-showcase/ricing-16.sh" ;;
            "ricing-16_blur.sh") bash "$HOME/Repos/MyArch/storage/scripts/Ricing-showcase/ricing-16_blur.sh" ;;
            "ricing-17.sh") bash "$HOME/Repos/MyArch/storage/scripts/Ricing-showcase/ricing-17.sh" ;;
            "ricing-18.sh") bash "$HOME/Repos/MyArch/storage/scripts/Ricing-showcase/ricing-18.sh" ;;
            "ricing-19.sh") bash "$HOME/Repos/MyArch/storage/scripts/Ricing-showcase/ricing-19.sh" ;;
        esac ;;

    "Waybar")
        DIR="$HOME/.config/waybar/themes"
        THEME=$(ls "$DIR" | wofi --dmenu --normal-window --sort-order=alphabetical "Waybar theme:")

        if [ -n "$THEME" ]; then
            ~/.config/waybar/scripts/waybar-switcher.sh "$THEME"
        fi ;;

    "Configs") 
        option=$(printf ".config/\n/usr/share/applications\n.local/share/applications\nTime-manager/\nmenu.sh\nmy_hyprland.sh\n.zshrc" | wofi --dmenu --normal-window)
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

            if [[ "$CURRENT_DIR" == /usr* ]]; then
                kitty --directory "$CURRENT_DIR" sudoedit "$FULL_PATH"
            else
                kitty --directory "$CURRENT_DIR" nvim "$FULL_PATH"
            fi

            break
        fi
    done
fi
