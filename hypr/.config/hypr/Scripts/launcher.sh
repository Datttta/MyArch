#!/bin/bash

### Copyq ###
if [[ $1 == "copyq" ]]; then
    hyprctl dispatch 'hl.dsp.exec_cmd("copyq toggle")'

#this exists because copyq would always open on the workspace 1 the first time you run it
elif [[ $1 == "start-copyq" ]]; then
    hyprctl dispatch 'hl.dsp.exec_cmd("copyq --start-server")'
    sleep 1
    hyprctl dispatch 'hl.dsp.exec_cmd("copyq toggle")' && hyprctl dispatch 'hl.dsp.exec_cmd("copyq toggle")'
fi
