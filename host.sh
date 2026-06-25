#!/bin/bash



JENKINS_URL="http://localhost:8085"

USER="admin"

TOKEN="11a8f342bf6651dc12cdb1f6184c4aeb0d"



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
