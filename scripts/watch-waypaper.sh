#!/bin/bash

CONFIG="$HOME/.config/waypaper/config.ini"

inotifywait -m -e close_write "$CONFIG" |
while read -r directory events filename; do
    bash ~/dotfiles/scripts/waybarRestart.sh
done

