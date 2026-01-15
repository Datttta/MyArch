#!/usr/bin/env sh

[ -z "$HYPRLAND_INSTANCE_SIGNATURE" ] && export HYPRLAND_INSTANCE_SIGNATURE=$(ls -1t $XDG_RUNTIME_DIR/hypr /tmp/hypr 2>/dev/null | grep '_' | head -n 1)
ACTION=$1
HYPR="/usr/bin/hyprctl"

if [ "$ACTION" = "start" ]; then
    $HYPR --batch "\
        keyword animations:enabled 0; \
        keyword decoration:blur:enabled 0; \
        keyword decoration:shadow:enabled 0; \
        keyword decoration:rounding 0; \
        keyword general:gaps_in 0; \
        keyword general:gaps_out 0; \
        keyword monitor eDP-1,1280x720@60,0x0,1"
    pkill waybar

elif [ "$ACTION" = "end" ]; then
    $HYPR keyword monitor eDP-1,1920x1080@60,0x0,1
    sleep 0.5
    $HYPR reload
    pkill waybar
    $HYPR dispatch exec waybar
fi
