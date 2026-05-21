#!/bin/bash

WOFI_CONFIG="$HOME/.config/wofi/menu/home_menu.conf"
WOFI_STYLE="$HOME/.config/wofi/menu/selector.css"

option=$(printf "Configs\nWaybar\nRicing" | wofi --dmenu --normal-window -c "$WOFI_CONFIG" \
    -s "$WOFI_STYLE")

case "$option" in

    "Ricing")
        WOFI_CONFIG="$HOME/.config/wofi/menu/ricing_showcase/ricing_sh.conf"
        WOFI_STYLE="$HOME/.config/wofi/menu/ricing_showcase/ricing_sh.css"

        RICING_DIR="$HOME/Repos/MyArch/storage/scripts/Ricing-showcase"
        PREVIEW_DIR="$RICING_DIR/preview"

        CACHE_DIR="$HOME/.cache/ricing-selector"
        THUMBNAIL_WIDTH="250"
        THUMBNAIL_HEIGHT="141"

        mkdir -p "$CACHE_DIR"

        # Shuffle thumbnail
        SHUFFLE_ICON="$CACHE_DIR/shuffle_thumbnail.png"

        magick -size "${THUMBNAIL_WIDTH}x${THUMBNAIL_HEIGHT}" xc:none \
            \( "$HOME/.config/wofi/menu/ricing_showcase/shuffle.png" -resize "100x90" \) \
            -gravity center -composite "$SHUFFLE_ICON"

        # Generate thumbnail function
        generate_thumbnail() {
            local input="$1"
            local output="$2"

            magick "$input" \
                -thumbnail "${THUMBNAIL_WIDTH}x${THUMBNAIL_HEIGHT}^" \
                -gravity center \
                -extent "${THUMBNAIL_WIDTH}x${THUMBNAIL_HEIGHT}" \
                "$output"
        }

        # Generate menu
        generate_menu() {
            # Shuffle option
            echo -en "img:$SHUFFLE_ICON\x00info:Shuffle\x1fRANDOM\n"

            # Scripts
            for script in "$RICING_DIR"/*.sh; do
                [[ -f "$script" ]] || continue

                filename=$(basename "$script")
                preview="$PREVIEW_DIR/${filename%.sh}.png"

                if [[ -f "$preview" ]]; then
                    thumbnail="$CACHE_DIR/${filename%.sh}.png"

                    # Regenerate if preview changed
                    if [[ ! -f "$thumbnail" ]] || [[ "$preview" -nt "$thumbnail" ]]; then
                        generate_thumbnail "$preview" "$thumbnail"
                    fi

                    echo -en "img:$thumbnail\x00info:$filename\x1f$script\n"
                else
                    echo -en "$filename\n"
                fi
            done
        }

        # Show wofi
        selection=$(generate_menu | wofi --dmenu --normal-window \
            -c "$WOFI_CONFIG" \
            -s "$WOFI_STYLE" \
            --prompt "Select script")

        [ -z "$selection" ] && exit

        # Remove img: prefix
        selected_path="${selection#img:}"

        # Shuffle
        if [[ "$selected_path" == "$SHUFFLE_ICON" ]]; then
            mapfile -t scripts < <(find "$RICING_DIR" -maxdepth 1 -name "*.sh")

            random_script="${scripts[RANDOM % ${#scripts[@]}]}"

            notify-send $(basename "${random_script%.*}.sh")

            bash "$random_script"
            exit
        fi

        # Convert thumbnail back to script name
        clean_name=$(basename "${selected_path%.*}")
        script_name="${clean_name}.sh"

        notify-send $script_name

        bash "$RICING_DIR/$script_name"
        ;;

    "Waybar")
        DIR="$HOME/.config/waybar/themes"
        PREVIEW_DIR="$HOME/.config/waybar/themes/preview"
        CACHE_DIR="$HOME/.cache/waybar_switcher"

        WOFI_CONFIG="$HOME/.config/wofi/menu/waybar_switcher/config"
        WOFI_STYLE="$HOME/.config/wofi/menu/waybar_switcher/style.css"

        # Generate thumbnail function
        generate_thumbnail() {
            local input="$1"
            local output="$2"

            magick "$input" \
                -gravity center \
                "$output"
        }

        mkdir -p "$CACHE_DIR"

        # Generate menu
        generate_menu() {

            # Themes
            for themes in "$DIR"/waybar*; do
                [[ -d "$themes" ]] || continue

                filename=$(basename "$themes")

                preview="$PREVIEW_DIR/${filename%}.png"

                if [[ -f "$preview" ]]; then
                    thumbnail="$CACHE_DIR/${filename%}.png"

                    # Regenerate if preview changed
                    if [[ ! -f "$thumbnail" ]] || [[ "$preview" -nt "$thumbnail" ]]; then
                        generate_thumbnail "$preview" "$thumbnail"
                    fi

                    echo -en "img:$thumbnail\x00info:$filename\x1f$themes\n"
                else
                    echo -en "$filename\n"
                fi
            done
        }

        selected=$(generate_menu | wofi --dmenu --normal-window \
        -c "$WOFI_CONFIG" \
        -s "$WOFI_STYLE" \
        --prompt "Select script")

        # remove "img:"
        selected_theme="${selected#img:}"

        # remove extension
        THEME=$(basename "${selected_theme%.*}")

        echo "theme: $THEME" >&2

        [ -z "$THEME" ] && exit

        if [ -n "$THEME" ]; then
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

        selection=$(printf "../\n$list" | wofi --dmenu --normal-window \
            -s "$WOFI_STYLE" \
            --prompt "${CURRENT_DIR#$HOME/}")

        [ -z "$selection" ] && break

        if [ "$selection" = "../" ]; then
            if [ "$CURRENT_DIR" != "$HOME" ]; then
                CURRENT_DIR=$(dirname "$CURRENT_DIR")
            fi

        elif [[ "$selection" == */ ]]; then
            CURRENT_DIR="${CURRENT_DIR}/${selection%/}"

        else
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

