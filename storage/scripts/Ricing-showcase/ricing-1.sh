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
kitty --class "cm_term" cmatrix -b &
wait_for_window "cm_term"

# Open Nvim
kitty --class "k_term" &
wait_for_window "k_term"

# bottom-left
hyprctl dispatch movefocus l
hyprctl dispatch movefocus d
kitty --class "t_term" tenki &
wait_for_window "t_term"

# Bottom-right
hyprctl dispatch movefocus r
kitty --class "b_term" btop &
wait_for_window "b_term"

# Extra bottom-left
hyprctl dispatch movefocus l
kitty --class "n_term" nvim ~/.cache/wal/colors-hyprland.conf &
wait_for_window "n_term"

# Extra top-right
hyprctl dispatch movefocus u
hyprctl dispatch movefocus r
kitty --class "c_term" cava &
wait_for_window "c_term"
