#!/bin/bash

watch_file() {
    local file="$1"

    while inotifywait -e close_write "$file"; do
        sleep 0.1
        notify-send "Screenshot saved" "$file"
    done
}

# Take a screenshot first using grimblast.
# The screenshot is saved to a temporary file.
TMP_FILE="$(mktemp --suffix=.png)"
grimblast --freeze save area "$TMP_FILE" || { rm "$TMP_FILE"; exit 1; }

# Ask for the save location and filename after the screenshot is taken.
# The default filename is now based on the current date and time.
DEFAULT_FILENAME="Screenshot-$(date '+%Y-%m-%d-%H%M%S').png"
FILE="$(zenity --file-selection --save --confirm-overwrite --filename=$HOME/Pictures/$DEFAULT_FILENAME)" 

# If the user cancels the save dialog, clean up the temporary file and exit.
if [[ -z "$FILE" ]]; then
    swappy -f "$TMP_FILE"
    rm "$TMP_FILE"
    exit 0
fi

# Copy the screenshot from the temporary file to the user-selected location.
mv "$TMP_FILE" "$FILE"

watch_file "$FILE" &

# Extract directory and filename from the final save location.
DIR="$(dirname "$FILE")"
NAME="$(basename "$FILE")"

# Update swappy config to use the new save directory and filename.
cat >~/.config/swappy/config <<EOF
[Default]
save_dir=$DIR
save_filename_format=$NAME
show_panel=false
line_size=5
text_size=20
text_font=sans-serif
paint_mode=brush
early_exit=false
fill_shape=false
EOF

swappy -f "$FILE"

killall inotifywait
killall screenshot.sh
