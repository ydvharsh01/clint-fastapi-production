#!/bin/bash
set -e

BACKUP_DIR="/opt/backups/clint-fastapi"
PROJECT_DIR="/home/harsh/clint-fastapi"

DATE=$(date +%Y%m%d-%H%M%S)
BACKUP_FILE="$BACKUP_DIR/backup-$DATE.tar.gz"

mkdir -p "$BACKUP_DIR"

tar \
  --exclude='clint-fastapi/.venv*' \
  --exclude='clint-fastapi/__pycache__' \
  -czf "$BACKUP_FILE" \
  -C /home/harsh \
  clint-fastapi

# Keep only backups from the last 7 days
find "$BACKUP_DIR" \
  -name "backup-*.tar.gz" \
  -mtime +7 \
  -delete

echo "Backup completed: $BACKUP_FILE"
