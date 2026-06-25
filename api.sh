#!/bin/bash

JENKINS_URL="http://localhost:8085"
JOB_NAME="Amazon-Jenkins"

USERNAME="admin"
PASSWORD="admin"
branches=("main" "dev" "qa" "uat")

for branch in "${branches[@]}"
do
    echo "Checking $branch branch..."

    STATUS=$(curl -s -u "$USERNAME:$API_TOKEN" \
    "$JENKINS_URL/job/$JOB_NAME/job/$branch/lastBuild/api/json" \
    | grep '"result"' | cut -d':' -f2 | tr -d '",')

    BUILDING=$(curl -s -u "$USERNAME:$API_TOKEN" \
    "$JENKINS_URL/job/$JOB_NAME/job/$branch/lastBuild/api/json" \
    | grep '"building"' | cut -d':' -f2 | tr -d ',')

    if [ "$BUILDING" = "true" ]
    then
        echo "$branch : BUILDING"
    else
        echo "$branch : $STATUS"
    fi

    echo "-------------------------"
done
