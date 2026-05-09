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

check_class() {
    local target_class=$1
    while hyprctl clients -j | jq -e --arg class "$target_class" '.[] | select(.class == $class)' > /dev/null; do
        echo "class already exists: $target_class" >&2
        echo "changing name..." >&2
        if [[ $target_class =~ ([0-9]+)$ ]]; then
            number="${BASH_REMATCH[1]}"
            prefix="${target_class%$number}"

            target_class="${prefix}$((number + 1))"
            echo "currect class name: $target_class" >&2
        else
            target_class="${target_class}1"
        fi
    done

    echo "$target_class"
}

hyprctl dispatch movecursor 0 0

# Open Yazi
app=$(check_class "cava_term")
echo "final class name: $app" >&2
kitty --class "$app" cava &
wait_for_window "$app"
exit

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
kitty --class "cm_term" cmatrix -b &
wait_for_window "cm_term"
