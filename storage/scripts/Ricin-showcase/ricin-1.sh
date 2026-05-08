#!/bin/bash

# Function to wait for a window of a specific class to appear
wait_for_window() {
    local target_class=$1
    # Max attempts to prevent infinite loops (approx 5 seconds)
    local attempts=50 
    while [ $attempts -gt 0 ]; do
        if hyprctl clients -j | jq -e ".[] | select(.class == \"$target_class\")" > /dev/null; then
            return 0
        fi
        sleep 0.1
        ((attempts--))
    done
    return 1
}

hyprctl dispatch movecursor 0 0

# Open Yazi
kitty --class "yazi_term" yazi &
wait_for_window "yazi_term"

# Open Nvim
kitty --class "nvim_term" nvim ~/.config/hypr/hyprland.conf &
wait_for_window "nvim_term"

# Move focus and open Cmatrix
hyprctl dispatch movefocus l
hyprctl dispatch movefocus d
kitty --class "cmatrix_term" cmatrix &
wait_for_window "cmatrix_term"

# Bottom-right
hyprctl dispatch movefocus r
kitty --class "standard_term" &
wait_for_window "standard_term"

# Extra bottom-left
hyprctl dispatch movefocus l
kitty --class "btop_term" btop &
wait_for_window "btop_term"

# Extra top-right
hyprctl dispatch movefocus u
hyprctl dispatch movefocus r
kitty --class "fish_term" asciiquarium &
wait_for_window "fish_term"
