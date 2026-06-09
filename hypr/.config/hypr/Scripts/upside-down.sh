#!/bin/bash

switch=/tmp/toggle_upside-down
touch $switch

toggle=$(cat $switch)

if [[ $toggle == "OFF" || -z $toggle ]]; then
    hyprctl eval 'hl.monitor({ output = "eDP-1", mode = "preferred", transform = 2 })' 
    hyprctl eval 'hl.config({ input = {rotation = 180}, })'
    echo "ON" > $switch
else
    echo "OFF" > $switch
    hyprctl reload
fi
