#!/bin/bash
sleep 3
PACMAN_UPDATES=$(checkupdates | wc -l)
AUR_UPDATES=$(yay -Qua | wc -l)
FLATPAK_UPDATES=$(flatpak remote-ls --updates | wc -l)

EXPAND_ICON=" <span size='150%'>󰃘</span> "
ALERT_ICON=" <span size='150%'>󰃘</span> !"

if [ "$PACMAN_UPDATES" -gt 0 ] || [ "$AUR_UPDATES" -gt 0 ] || [ "$FLATPAK_UPDATES" -gt 0 ]; then
    pkill -SIGRTMIN+1 waybar
    echo "${ALERT_ICON}"
else
    echo "${EXPAND_ICON}"
fi
