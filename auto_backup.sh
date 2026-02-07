#!/bin/bash
cd "$HOME/oga_web_showcase"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

if [[ -n $(git status -s) ]]; then
    echo "[$TIMESTAMP] Changes detected, backing up..."
    git add .
    git commit -m "Auto-backup: $TIMESTAMP"
    git push origin main
    echo "[$TIMESTAMP] Backup complete!"
else
    echo "[$TIMESTAMP] No changes to backup"
fi
