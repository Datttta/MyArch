#!/bin/bash

case $1 in
    ### Copyq ###
    "copyq")
        hyprctl dispatch 'hl.dsp.exec_cmd("copyq toggle")'
        ;;
    #this exists because copyq would always open on the workspace 1 the first time you run it
    "start-copyq")
        copyq --start-server

        until copyq eval '1' >/dev/null 2>&1; do
            sleep 0.5
        done

        copyq toggle
        copyq toggle
        ;;
    ### Vimwiki ###
    "vimwiki")
        hyprctl dispatch 'hl.dsp.exec_cmd("kitty -e nvim ~/Repos/vimwiki/index.md ~/Repos/vimwiki/\"New words.md\"", { workspace = "2 silent" })'
        ;;
    ### Duetime ###
    "Duetime")
        hyprctl dispatch 'hl.dsp.exec_cmd("kitty Duetime", { workspace = "2 silent" })'
        ;;
    ### Sticky notes ###
    "sticky")
        sticky &
        sleep 1.5
        hyprctl clients -j | jq -r '.[] | select(.initialTitle == "Notes") | .address' | while read -r addr; do
            hyprctl dispatch "hl.dsp.window.close({ window = \"address:$addr\" })"
        done

        hyprctl dispatch "hl.dsp.window.move({ workspace = 2, window = \"class:Sticky.py\", follow = false })"
        ;;
esac
