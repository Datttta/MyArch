#!/bin/bash
yay_update_count=/tmp/yay_update_count
flatpak_update_count=/tmp/flatpak_update_count

touch $flatpak_update_count $yay_update_count

wait_for_network() {
    while true; do
        /usr/bin/checkupdates &>/dev/null
        exit_code=$?
        
        # 0: updates available | 2: no updates
        if [[ $exit_code -eq 0 || $exit_code -eq 2 ]]; then
            echo "connection working: $exit_code" >&2
            break
        fi
        echo "no connection: $exit_code" >&2
        sleep 1
    done
}

yay_updates() {
    echo $(( $(/usr/bin/checkupdates | wc -l) + $(/usr/bin/yay -Qua | wc -l) )) > $yay_update_count
}

flatpak_updates() {
    echo $(/usr/bin/flatpak remote-ls --updates | wc -l) > $flatpak_update_count
}

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
        wait_for_network
        yay_updates

        YAY_UPDATES=$(cat $yay_update_count)
        echo $YAY_UPDATES
        
        echo "yay updates from get_yay_numbers: $YAY_UPDATES" >&2
        kill -SIGRTMIN+1 $(pidof waybar)
        ;;

    "get_flatpak_numbers")
        wait_for_network
        flatpak_updates

        FLATPAK_UPDATES=$(cat $flatpak_update_count)
        echo $FLATPAK_UPDATES

        echo "flatpak updates from get_flatpak_numbers: $FLATPAK_UPDATES" >&2
        kill -SIGRTMIN+1 $(pidof waybar)
        ;;

    "update")
        EXPAND_ICON=" <span size='150%'>󰃘</span> "
        ALERT_ICON=" <span size='150%'>󰃘</span> !"

        YAY_UPDATES=$(cat $yay_update_count)
        FLATPAK_UPDATES=$(cat $flatpak_update_count)

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
