#!/bin/bash

SERVICES=("tomcat10" "nginx")

for SERVICE in "${SERVICES[@]}"
do
    if systemctl is-active --quiet "$SERVICE"
    then
        echo "$SERVICE is running"
    else
        echo "$SERVICE is stopped. Restarting..."
        sudo systemctl restart "$SERVICE"
    fi
done
