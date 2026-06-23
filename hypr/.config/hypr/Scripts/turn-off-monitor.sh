#!/bin/bash

switch=/tmp/toggle_turn-off-monitor
touch $switch

toggle=$(cat $switch)

if [[ $toggle == "OFF" || -z $toggle ]]; then
    sleep 0.5
    hyprctl dispatch 'hl.dsp.dpms({ action = "disable" })'
    echo "ON" > $switch
else
    sleep 0.5
    hyprctl dispatch 'hl.dsp.dpms({ action = "enable" })'
    echo "OFF" > $switch
fi 
