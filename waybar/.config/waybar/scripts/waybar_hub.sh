#!/bin/bash
echo "get $1" >&2

if [[ $1 == "yay" ]]; then
    hyprctl dispatch "hl.dsp.exec_cmd(\"kitty -e bash -lc 'yay; sleep 1; kill -SIGRTMIN+2 $(pidof waybar)'\")"

elif [[ $1 == "flatpak" ]]; then
    hyprctl dispatch "hl.dsp.exec_cmd(\"kitty -e bash -lc 'flatpak update; sleep 1; kill -SIGRTMIN+2 $(pidof waybar)'\")"

elif [[ $1 == "network" ]]; then
    hyprctl dispatch "hl.dsp.exec_cmd('kitty -e nmtui')"

elif [[ $1 == "update" ]]; then
    # check updates
    echo "sleeping" >&2
    sleep 6
    echo "awake" >&2

    YAY_UPDATES=$(yay -Qua | wc -l)
    FLATPAK_UPDATES=$(flatpak remote-ls --updates | wc -l)

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

