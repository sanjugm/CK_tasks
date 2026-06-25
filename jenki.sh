#!/bin/bash

JENKINS_URL="http://localhost:8085"

branches=("main" "dev" "qa")

for branch in "${branches[@]}"
do
    echo "Checking $branch branch..."

    curl -s "$JENKINS_URL/job/MyJob/job/$branch/lastBuild/api/json" | grep result

done
