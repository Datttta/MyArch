#!/usr/bin/env sh

# Safely catch instance signature for external execution scripts
[ -z "$HYPRLAND_INSTANCE_SIGNATURE" ] && export HYPRLAND_INSTANCE_SIGNATURE=$(ls -1t $XDG_RUNTIME_DIR/hypr /tmp/hypr 2>/dev/null | grep '_' | head -n 1)

ACTION=$1
HYPR="/usr/bin/hyprctl"

if [ "$ACTION" = "start" ]; then
    # Fix: Call hl.config as a function, passing the target tables safely
    $HYPR eval "hl.config({
        animations = { enabled = false },
        decoration = { blur = { enabled = false }, shadow = { enabled = false }, rounding = 0 },
        general = { gaps_in = 0, gaps_out = 0, border_size = 0 }
    })"
    pkill waybar

elif [ "$ACTION" = "end" ]; then
    sleep 0.5
    $HYPR reload
    pkill waybar
    
    $HYPR eval "hl.dispatch(hl.dsp.exec_cmd('waybar'))"
fi

