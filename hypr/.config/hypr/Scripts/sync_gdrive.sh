#!/bin/bash
LOCAL_DIR="/home/DROS/Documents"
REMOTE_DIR="gdrive:MyArch/Documents"
FILTER_FILE="/home/DROS/.rclone-ignore.txt"

echo "==> Starting initial full copy..."
rclone copy "$LOCAL_DIR" "$REMOTE_DIR" --filter-from "$FILTER_FILE" -vv

echo "==> Watching for real-time changes..."
inotifywait -m -r -e close_write,moved_to,moved_from,delete --format '%e %w%f' "$LOCAL_DIR" | while read EVENT FILE_PATH; do
    REL_PATH="${FILE_PATH#$LOCAL_DIR/}"
    
    # Skip if file matches ignore rules
    if grep -qxF "$REL_PATH" "$FILTER_FILE" 2>/dev/null; then
        continue
    fi

    if [[ "$EVENT" =~ "DELETE" ]] || [[ "$EVENT" =~ "MOVED_FROM" ]]; then
        echo "==> Removal/Move-out detected: $REL_PATH. Removing from Google Drive..."
        rclone deletefile "$REMOTE_DIR/$REL_PATH" -vv
    else
        echo "==> Change/Move-in detected: $REL_PATH. Syncing file..."
        REL_DIR=$(dirname "$REL_PATH")
        FILENAME=$(basename "$FILE_PATH")
        
        if [ "$REL_DIR" = "." ]; then
            rclone copyto "$FILE_PATH" "$REMOTE_DIR/$FILENAME" -vv
        else
            rclone copyto "$FILE_PATH" "$REMOTE_DIR/$REL_DIR/$FILENAME" -vv
        fi
    fi
done
