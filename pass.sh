#!/bin/bash 


THRESHOLD=70
LOG_PATH="/var/log/myapp"

USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

if [ "$USAGE" -gt "$THRESHOLD" ]
then
    echo "ALERT: Disk usage is critical: $USAGE%"
    echo "Cleaning old logs..."

    find $LOG_PATH -type f -name "*.log" -mtime +7 -delete

    echo "Old logs deleted successfully."
else
    echo "Disk usage normal: $USAGE%"
fi

