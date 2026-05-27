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
        #check if there is a number at the end of the variable
        if [[ $target_class =~ ([0-9]+)$ ]]; then 
            number="${BASH_REMATCH[1]}"
            prefix="${target_class%$number}"

            target_class="${prefix}$((number + 1))"
            echo "currect class name: $target_class" >&2
        else
            target_class="${target_class}1"
        fi
    done

    echo "final class name: $target_class" >&2
    echo "$target_class"
}

hyprctl dispatch 'hl.dsp.cursor.move({ x = 0, y = 0 })'

# Right hyprland.conf
app=$(check_class "btop_term")
kitty --class $app btop &
wait_for_window $app

# Left Open kitty
app=$(check_class "kitty_term")
kitty --class $app &
wait_for_window $app

# bottom-left open btop
hyprctl dispatch 'hl.dsp.cursor.move({ x = 450, y = 700 })'
app=$(check_class "hpyrland-colors_term")
kitty --class $app nvim ~/.cache/wal/colors-hyprland.conf &
wait_for_window $app
