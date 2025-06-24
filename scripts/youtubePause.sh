#!/bin/bash

echo "=== Smart YouTube Music Gap Creator ==="

# Find player
PLAYER_NAME=$(playerctl -l | grep -iE "youtube|music|chromium|firefox" | head -1)
if [[ -z "$PLAYER_NAME" ]]; then
    echo "Error: No compatible player found."
    playerctl -l
    exit 1
fi

echo "Monitoring player: $PLAYER_NAME"

# Initialize
last_song=""
current_position=0
track_length=0
gap_added=false

while true; do
    # Get player state
    current_status=$(playerctl -p "$PLAYER_NAME" status 2>/dev/null)
    current_song=$(playerctl -p "$PLAYER_NAME" metadata --format "{{artist}} - {{title}}" 2>/dev/null)
    current_position=$(playerctl -p "$PLAYER_NAME" position 2>/dev/null | cut -d'.' -f1)
    track_length=$(playerctl -p "$PLAYER_NAME" metadata mpris:length 2>/dev/null)
    track_length=$((track_length/1000000)) # Convert microseconds to seconds

    # Only proceed if we have valid data
    if [[ -z "$current_song" || -z "$track_length" ]]; then
        sleep 0.5
        continue
    fi

    # Detect new track
    if [[ "$current_song" != "$last_song" ]]; then
        echo "[$(date +%T)] New track: $current_song"
        last_song="$current_song"
        gap_added=false
    fi

    # Calculate time remaining
    time_remaining=$((track_length - current_position))
    
    # When we're at the last 0.5 seconds of a track
    if [[ "$current_status" == "Playing" && $time_remaining -lt 1 && "$gap_added" == false ]]; then
        echo "[$(date +%T)] Track ending detected - adding gap..."
        playerctl -p "$PLAYER_NAME" pause
        sleep 5
        playerctl -p "$PLAYER_NAME" play
        gap_added=true
    fi

    sleep 0.1
done
