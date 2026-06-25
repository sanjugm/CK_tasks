#!/bin/bash



JENKINS_URL="http://localhost:8085"

USER="admin"

TOKEN="<REPLACE_WITH_YOUR_TOKEN>"



JOB="MyProject"



branches=("main" "dev" "qa")



for branch in "${branches[@]}"

do

    echo "Checking $branch branch..."



    curl -s -u "$USER:$TOKEN" \

    "$JENKINS_URL/job/$JOB/job/$branch/lastBuild/api/json" \

    | grep '"result"'



    echo "----------------------------"

done
