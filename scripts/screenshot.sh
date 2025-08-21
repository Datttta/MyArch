#!/bin/bash

# Take a screenshot first using grim and slurp.
# The screenshot is saved to a temporary file.
TMP_FILE="$(mktemp --suffix=.png)"
grim -g "$(slurp)" "$TMP_FILE" || { rm "$TMP_FILE"; exit 1; }

# Ask for the save location and filename after the screenshot is taken.
# The default filename is now based on the current date and time.
DEFAULT_FILENAME="screenshot-$(date '+%Y-%m-%d-%H%M%S').png"
FILE="$(zenity --file-selection --save --confirm-overwrite --filename=$HOME/Pictures/$DEFAULT_FILENAME)" || { rm "$TMP_FILE"; exit 1; }

# If the user cancels the save dialog, clean up the temporary file and exit.
if [[ -z "$FILE" ]]; then
    rm "$TMP_FILE"
    exit 1
fi

# Copy the screenshot from the temporary file to the user-selected location.
mv "$TMP_FILE" "$FILE"

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

# (Optional) Open the saved screenshot in swappy.
swappy -f "$FILE"
