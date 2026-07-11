#!/bin/bash
echo "get $1" >&2

case "$1" in
    "yay")
        # run yay
        hyprctl dispatch "hl.dsp.exec_cmd(\"kitty -e bash -lc 'yay; kill -SIGRTMIN+2 $(pidof waybar)'\")"
        ;;
    "flatpak")
        # run flatpak update
        hyprctl dispatch "hl.dsp.exec_cmd(\"kitty -e bash -lc 'flatpak update; kill -SIGRTMIN+2 $(pidof waybar)'\")"
        ;;
    "network")
        # open network app
        hyprctl dispatch "hl.dsp.exec_cmd('kitty -e nmtui')"
        ;;
    "get_yay_numbers")
        ### Change this to a continous loop, only stops when network is back
        for i in {1..10}; do
            /usr/bin/checkupdates &>/dev/null
            exit_code=$?
            
            # If it returns 0 or 2, it successfully reached the Arch mirrors.
            if [[ $exit_code -eq 0 || $exit_code -eq 2 ]]; then
                break
            fi
            sleep 1
        done

        YAY_UPDATES=$(( $(/usr/bin/checkupdates | wc -l) + $(/usr/bin/yay -Qua | wc -l) ))
        echo $YAY_UPDATES
        
        echo "yay updates from get_yay_numbers: $YAY_UPDATES" >&2
        ;;

    "get_flatpak_numbers")
        ### Change this to a continous loop, only stops when network is back
        for i in {1..10}; do
            /usr/bin/checkupdates &>/dev/null
            exit_code=$?
            
            # If it returns 0 or 2, it successfully reached the Arch mirrors.
            if [[ $exit_code -eq 0 || $exit_code -eq 2 ]]; then
                break
            fi
            sleep 1
        done
        
        FLATPAK_UPDATES=$(/usr/bin/flatpak remote-ls --updates | wc -l)
        echo $FLATPAK_UPDATES

        echo "flatpak updaets from get_flatpak_numbers: $FLATPAK_UPDATES" >&2
        ;;

# add case get_flatpak_numbers

    "update")
        # check updates
        # Wait up to 10 seconds for both internet AND DNS to be fully ready
        ### Change this to a continouss loop, only stops when network is back
        for i in {1..10}; do
            /usr/bin/checkupdates &>/dev/null
            exit_code=$?
            
            # If it returns 0 or 2, it successfully reached the Arch mirrors.
            if [[ $exit_code -eq 0 || $exit_code -eq 2 ]]; then
                break
            fi
            sleep 1
        done

        YAY_UPDATES=$(( $(/usr/bin/checkupdates | wc -l) + $(/usr/bin/yay -Qua | wc -l) ))
        FLATPAK_UPDATES=$(/usr/bin/flatpak remote-ls --updates | wc -l)

        EXPAND_ICON=" <span size='150%'>󰃘</span> "
        ALERT_ICON=" <span size='150%'>󰃘</span> !"

        echo "Yay updates: $YAY_UPDATES" >&2
        echo "flatpak: $FLATPAK_UPDATES" >&2

        if [[ "$YAY_UPDATES" != 0 || "$FLATPAK_UPDATES" != 0 ]]; then
            echo "you have updates" >&2
            echo "${ALERT_ICON}"
        else
            echo "up to date" >&2
            echo "${EXPAND_ICON}"
        fi
        ;;
esac
