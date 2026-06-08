#!/bin/bash
echo "get $1" >&2

# update
if [[ $1 == "yay" ]]; then
    hyprctl dispatch "hl.dsp.exec_cmd(\"kitty -e bash -lc 'yay; sleep 1; kill -SIGRTMIN+2 $(pidof waybar)'\")"
elif [[ $1 == "flatpak" ]]; then
    kitty -e bash -lc 'flatpak update; sleep 1; kill -SIGRTMIN+2 $(pidof waybar)'
fi

# check updates
sleep 6
PACMAN_UPDATES=$(checkupdates | wc -l)
AUR_UPDATES=$(yay -Qua | wc -l)
FLATPAK_UPDATES=$(flatpak remote-ls --updates | wc -l)

EXPAND_ICON=" <span size='150%'>󰃘</span> "
ALERT_ICON=" <span size='150%'>󰃘</span> !"

pkill -SIGRTMIN+1 waybar

if [ "$PACMAN_UPDATES" -gt 0 ] || [ "$AUR_UPDATES" -gt 0 ] || [ "$FLATPAK_UPDATES" -gt 0 ]; then
    pkill -SIGRTMIN+1 waybar
    echo "${ALERT_ICON}"
else
    echo "${EXPAND_ICON}"
fi
