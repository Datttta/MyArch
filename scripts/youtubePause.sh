#!/bin/bash

echo "=== Simple YouTube Music Gap Creator ==="

# Find player
PLAYER_NAME=$(playerctl -l | grep -iE "youtube|music|chromium|firefox" | head -1)
if [[ -z "$PLAYER_NAME" ]]; then
    echo "Error: No compatible player found."
    playerctl -l
    exit 1
fi

echo "Monitoring player: $PLAYER_NAME"

while true; do
    # Get current position and track length
    current_position=$(playerctl -p "$PLAYER_NAME" position 2>/dev/null)
    track_length=$(playerctl -p "$PLAYER_NAME" metadata mpris:length 2>/dev/null)
    track_length=$(echo "scale=2; $track_length/1000000" | bc) # Convert microseconds to seconds

    # Print current position information
    printf "\rCurrent position: %0.1f/%0.1f [%d%%]" \
        "$current_position" \
        "$track_length" \
        $(echo "scale=0; 100*$current_position/$track_length" | bc)

    # Check if we're at the last second of the track using bc
    if [[ $(echo "$current_position > $track_length - 1" | bc) -eq 1 ]]; then
        echo -e "\nEnd of track detected - adding gap..."
        playerctl -p "$PLAYER_NAME" pause
        sleep 5
        playerctl -p "$PLAYER_NAME" next
        playerctl -p "$PLAYER_NAME" play
        
    fi

done
