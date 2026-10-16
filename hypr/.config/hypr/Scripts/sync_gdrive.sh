#!/bin/bash

FILTER_FILE="/home/DROS/.rclone-ignore.txt"

DOCS_LOCAL="/home/DROS/Documents"
DOCS_REMOTE="gdrive:MyArch/Documents"

PICS_LOCAL="/home/DROS/Pictures"
PICS_REMOTE="gdrive:MyArch/Pictures"

DUETIME_LOCAL="/home/DROS/.config/duetime"
DUETIME_REMOTE="gdrive:MyArch/duetime"

echo "==> Starting initial full copies..."
rclone copy "$DOCS_LOCAL" "$DOCS_REMOTE" --filter-from "$FILTER_FILE" -vv
rclone copy "$PICS_LOCAL" "$PICS_REMOTE" --filter-from "$FILTER_FILE" -vv
rclone copy "$DUETIME_LOCAL" "$DUETIME_REMOTE" --filter-from "$FILTER_FILE" -vv

echo "==> Starting unified real-time watcher..."

# Watch both directories in a single inotifywait instance
inotifywait -m -r -e close_write,moved_to,moved_from,delete --format '%e %w%f' "$DOCS_LOCAL" "$PICS_LOCAL" "$DUETIME_LOCAL" | while read EVENT FILE_PATH; do
    
    # Dynamically determine whether the change is in Documents or Pictures
    if [[ "$FILE_PATH" == "$DOCS_LOCAL"* ]]; then
        LOCAL_DIR="$DOCS_LOCAL"
        REMOTE_DIR="$DOCS_REMOTE"
    elif [[ "$FILE_PATH" == "$PICS_LOCAL"* ]]; then
        LOCAL_DIR="$PICS_LOCAL"
        REMOTE_DIR="$PICS_REMOTE"
    elif [[ "$FILE_PATH" == "$DUETIME_LOCAL"* ]]; then
        LOCAL_DIR="$DUETIME_LOCAL"
        REMOTE_DIR="$DUETIME_REMOTE"
    else
        continue
    fi

    REL_PATH="${FILE_PATH#$LOCAL_DIR/}"
    
    # Skip if file matches ignore rules
    if grep -qxF "$REL_PATH" "$FILTER_FILE" 2>/dev/null; then
        continue
    fi

    if [[ "$EVENT" =~ "DELETE" ]] || [[ "$EVENT" =~ "MOVED_FROM" ]]; then
        echo "==> Removal detected: $REL_PATH. Removing from remote..."
        rclone deletefile "$REMOTE_DIR/$REL_PATH" -vv
    else
        echo "==> Change detected: $REL_PATH. Syncing file..."
        REL_DIR=$(dirname "$REL_PATH")
        FILENAME=$(basename "$FILE_PATH")
        
        if [ "$REL_DIR" = "." ]; then
            rclone copyto "$FILE_PATH" "$REMOTE_DIR/$FILENAME" -vv
        else
            rclone copyto "$FILE_PATH" "$REMOTE_DIR/$REL_DIR/$FILENAME" -vv
        fi
    fi
done

