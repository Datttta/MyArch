#!/usr/bin/env sh

switch=/tmp/toggle_gamemode
touch $switch

state=$(cat $switch)

if [[ $state == "OFF" || -z $state ]]; then
    hyprctl eval 'hl.config({
        animations = { enabled = false },
        decoration = { blur = { enabled = false }, shadow = { enabled = false }, rounding = 0 },
        general = { gaps_in = 0, gaps_out = 0, border_size = 0 }
    })'
    pkill waybar
    
    echo "ON" > $switch
else
    hyprctl reload
    waybar &
    disown
    echo "OFF" > $switch
fi    
