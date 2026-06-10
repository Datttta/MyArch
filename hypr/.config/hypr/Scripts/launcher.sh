#!/bin/bash

### Copyq ###
if [[ $1 == "copyq" ]]; then
    hyprctl dispatch 'hl.dsp.exec_cmd("copyq toggle")'

#this exists because copyq would always open on the workspace 1 the first time you run it
elif [[ $1 == "start-copyq" ]]; then
    copyq --start-server

    until copyq eval '1' >/dev/null 2>&1; do
        sleep 0.5
    done

    copyq toggle
    copyq toggle
fi
