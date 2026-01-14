#!/usr/bin/env sh

ACTION=$1
LOG="/tmp/gamemode_debug.log"

# 1. Direct path to the socket (Newer Hyprland uses XDG_RUNTIME_DIR)
if [ -z "$HYPRLAND_INSTANCE_SIGNATURE" ]; then
    # Search in both possible locations
    SIGNATURE=$(ls -1t $XDG_RUNTIME_DIR/hypr 2>/dev/null | grep '_' | head -n 1)
    if [ -z "$SIGNATURE" ]; then
        SIGNATURE=$(ls -1t /tmp/hypr 2>/dev/null | grep '_' | head -n 1)
    fi
    export HYPRLAND_INSTANCE_SIGNATURE=$SIGNATURE
fi

echo "Action: $ACTION | Signature: $HYPRLAND_INSTANCE_SIGNATURE" >> $LOG

# 2. Use the full path and the -i (instance) flag to be 100% sure
HYPR_CMD="/usr/bin/hyprctl"

if [ "$ACTION" = "start" ]; then
    $HYPR_CMD --batch "\
        keyword animations:enabled 0;\
        keyword decoration:drop_shadow 0;\
        keyword decoration:blur:enabled 0;\
        keyword general:gaps_in 0;\
        keyword general:gaps_out 0;\
        keyword general:border_size 1;\
        keyword monitor eDP-1,1280x720@60,0x0,1" >> $LOG 2>&1
    
    pkill waybar
    
elif [ "$ACTION" = "end" ]; then
    # 1. Restore Resolution
    $HYPR_CMD keyword monitor eDP-1,1920x1080@60,0x0,1 >> $LOG 2>&1
    
    # 2. Restore Decorations/Animations
    $HYPR_CMD reload >> $LOG 2>&1
    
    # 3. Restore Waybar with the correct environment
    # We find the Wayland display (usually wayland-0)
    export WAYLAND_DISPLAY=$(ls $XDG_RUNTIME_DIR/wayland-* | head -n 1 | xargs basename)
    export XDG_RUNTIME_DIR="/run/user/$(id -u)"
    
    # Run waybar in the background and detach it
    /usr/bin/waybar & >> $LOG 2>&1
fi
