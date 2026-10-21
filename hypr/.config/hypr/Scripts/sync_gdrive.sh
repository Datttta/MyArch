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

# Function to check if REL_PATH matches any exclude rule in the ignore file
should_ignore() {
    local path="$1"
    local filter_file="$2"
    
    while IFS= read -r line; do
        # Trim whitespace
        line="$(echo "$line" | xargs)"
        # Skip empty lines or comments
        [[ -z "$line" || "$line" =~ ^# ]] && continue
        
        # Only process exclude rules starting with '-'
        if [[ "$line" == -* ]]; then
            local pattern="${line#-}"
            pattern="$(echo "$pattern" | xargs)" # trim whitespace
            
            # Strip leading '**/ ' or '**/' for flexible path matching
            local clean_pattern="${pattern#**/}"
            
            # Check exact match, glob match (*.tmp), or path match
            if [[ "$path" == $pattern ]] || [[ "$path" == $clean_pattern ]] || [[ "$path" == */$clean_pattern ]]; then
                return 0 # Ignored
            fi
        fi
    done < "$filter_file"
    return 1 # Not ignored
}

# Watch directories in a single inotifywait instance
inotifywait -m -r -e close_write,moved_to,moved_from,delete --format '%e %w%f' "$DOCS_LOCAL" "$PICS_LOCAL" "$DUETIME_LOCAL" | while read EVENT FILE_PATH; do
    
    # Dynamically determine the root directory
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
    if should_ignore "$REL_PATH" "$FILTER_FILE"; then
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
