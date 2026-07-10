#!/bin/bash
echo "get $1" >&2

# run yay
if [[ $1 == "yay" ]]; then
    hyprctl dispatch "hl.dsp.exec_cmd(\"kitty -e bash -lc 'yay; kill -SIGRTMIN+2 $(pidof waybar)'\")"

# run flatpak update
elif [[ $1 == "flatpak" ]]; then
    hyprctl dispatch "hl.dsp.exec_cmd(\"kitty -e bash -lc 'flatpak update; kill -SIGRTMIN+2 $(pidof waybar)'\")"

# open network app
elif [[ $1 == "network" ]]; then
    hyprctl dispatch "hl.dsp.exec_cmd('kitty -e nmtui')"

# check updates
elif [[ $1 == "update" ]]; then

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
fi

