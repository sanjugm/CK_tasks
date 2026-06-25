#!/bin/bash

# Log File
LOG_FILE="/var/log/syslog"

# Backup Directory
ARCHIVE_DIR="$HOME/backup"

# Azure Storage Details
STORAGE_ACCOUNT="lin12"
CONTAINER_NAME="logs"

# Delete backups older than 7 days
RETENTION_DAYS=7

# Timestamp
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# File Names
LOG_NAME=$(basename "$LOG_FILE")
ROTATED_LOG="$ARCHIVE_DIR/${LOG_NAME}_${TIMESTAMP}"
COMPRESSED_FILE="${ROTATED_LOG}.gz"

# Create Backup Directory
mkdir -p "$ARCHIVE_DIR"

# Check whether log file exists
if [ ! -f "$LOG_FILE" ]
then
    echo "Log file not found."
    exit 1
fi

echo "Copying Log File..."

sudo cp "$LOG_FILE" "$ROTATED_LOG"

if [ $? -ne 0 ]
then
    echo "Failed to copy log file."
    exit 1
fi

echo "Log Copied Successfully."

echo "Compressing Log..."

gzip "$ROTATED_LOG"

if [ $? -ne 0 ]
then
    echo "Compression Failed."
    exit 1
fi

echo "Compression Successful."

echo "Uploading to Azure Blob..."

ACCOUNT_KEY=$(az storage account keys list \
--resource-group sanju \
--account-name lin12 \
--query "[0].value" -o tsv)

az storage blob upload \
    --account-name "$STORAGE_ACCOUNT" \
    --account-key "$ACCOUNT_KEY" \
    --container-name "$CONTAINER_NAME" \
    --file "$COMPRESSED_FILE" \
    --name "$(basename "$COMPRESSED_FILE")"
if [ $? -eq 0 ]
then
    echo "Upload Successful."
else
    echo "Upload Failed."
    exit 1
fi

echo "Deleting Archives Older Than $RETENTION_DAYS Days..."

find "$ARCHIVE_DIR" -type f -name "*.gz" -mtime +$RETENTION_DAYS -delete

echo "Old Archives Deleted."

echo "====================================="
echo "Task Completed Successfully"
echo "====================================="
