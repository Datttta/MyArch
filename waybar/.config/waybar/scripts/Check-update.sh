#!/bin/bash

# Get the number of updates from pacman (signal 8) and aur (signal 9) modules.
# We are calling the same commands the modules use to get the raw numbers.

PACMAN_UPDATES=$(checkupdates | wc -l)
AUR_UPDATES=$(yay -Qua | wc -l)
FLATPAK_UPDATES=$(flatpak remote-ls --updates | wc -l)

EXPAND_ICON=" <span size='150%'>󰃘</span> "
ALERT_ICON=" <span size='150%'>󰃘</span> !"

if [ "$PACMAN_UPDATES" -gt 0 ] || [ "$AUR_UPDATES" -gt 0 ] || [ "$FLATPAK_UPDATES" -gt 0 ]; then
    echo "${ALERT_ICON}"
else
    echo "${EXPAND_ICON}"
fi
