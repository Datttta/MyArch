#!/bin/bash

case $1 in
    ### Copyq ###
    "copyq")
        hyprctl dispatch 'hl.dsp.exec_cmd("copyq toggle")'
        ;;
    #this exists because copyq would always open on the workspace 1 the first time you run it
    "start-copyq")
        copyq --start-server
        
        echo "Waiting for copyq..."
       
        until copyq eval '1' >/dev/null 2>&1; do
            sleep 0.5
        done
       
        echo "Copyq detected."

        copyq toggle
        copyq toggle
        ;;
    ### Vimwiki ###
    "vimwiki")
        hyprctl dispatch 'hl.dsp.exec_cmd("kitty -e nvim ~/Repos/vimwiki/index.md ~/Repos/vimwiki/\"New words.md\"", { workspace = "2 silent" })'

        echo "Waiting for Vimwiki..."

        while ! hyprctl clients -j | jq -e '.[] | select(.title == "nvim")' > /dev/null; do
            sleep 0.1
        done

        echo "Vimwiki detected."
        ;;
    ### Duetime ###
    "Duetime")
        echo "Open duetime"
        
        hyprctl dispatch 'hl.dsp.exec_cmd("kitty Duetime", { workspace = "2 silent" })'
        
        echo "Duetime opened"
        ;;
    ### Sticky notes ###
    "sticky")
        sticky &

        echo "Waiting for Notes"

        while [[ $(hyprctl clients -j | jq '[.[] | select(.initialTitle == "Notes")] | length') -lt 2 ]]; do
            sleep 0.1
        done
        
        echo "Waiting for Sticky.py"
        
        while ! hyprctl clients -j | jq -e '.[] | select(.class == "Sticky.py")' > /dev/null; do
            sleep 0.1
        done

        echo "Closing Notes window"

        hyprctl clients -j | jq -r '.[] | select(.initialTitle == "Notes") | .address' | while read -r addr; do
            hyprctl dispatch "hl.dsp.window.close({ window = \"address:$addr\" })"
        done

        hyprctl dispatch "hl.dsp.window.move({ workspace = 2, window = \"class:Sticky.py\", follow = false })"

        echo "Sticky-notes moved"
        ;;
esac
