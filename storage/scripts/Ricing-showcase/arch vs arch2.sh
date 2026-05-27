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

# Right 
app=$(check_class "arch_term")
kitty --class $app &
wait_for_window $app

# Left 
app=$(check_class "arch2_term")
kitty --class $app env FASTFETCH_LOGO=arch2 zsh &
wait_for_window $app

# right again
hyprctl dispatch 'hl.dsp.focus({ direction = "r" })'
exit
hyprctl killactive && kill -9 $(hyprctl activewindow -j | jq -r '.pid')
app=$(check_class "arch_term")
kitty --class $app &
wait_for_window $app

# Bottom-right 
hyprctl dispatch movecursor 1450 700
app=$(check_class "arch_term")
kitty --class $app &
wait_for_window $app

# bottom-left 
hyprctl dispatch movefocus l
hyprctl dispatch movecursor 450 700
app=$(check_class "arch2_term")
kitty --class $app env FASTFETCH_LOGO=arch2 zsh &
wait_for_window $app
