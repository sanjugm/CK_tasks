#!/bin/bash

service="cron.service"

if ! systemctl is-active --quiet $service
then
    echo "service is stopped"
    sudo systemctl restart $service
else
    echo "service is running"
fi
