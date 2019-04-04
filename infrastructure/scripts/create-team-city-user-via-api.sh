#!/bin/bash

curlUsername=root
curlPassword=root
username=test
TC_BASE_URL=localhost

createProject()
{
    curl -X POST -u root:root --header "text/plain" --data playgroundApp http://localhost:8091/app/rest/projects
}
createUserPostData()
{
    cat <<EOF 
    {
        "username": "$username$i",
        "password": "$username$i",
        "groups": {
            "group": [
                {
                    "key": "playgroundUsers",
                    "name": "playgroundUsers"
                }
            ]
        }
    }
EOF
}
createGroupPostData()
{
    cat <<EOF
    {
        "key": "playgroundUsers", "name": "playgroundUsers", "roles": "Project developer"
    }
EOF
}
#change to port 80 on the day
for url in "${TC_BASE_URL[@]}"
do
    createProject
    curl -X POST -u "$curlUsername:$curlPassword" --header "Content-Type: application/json" \
        --data "$(createGroupPostData)" \
        http://${TC_BASE_URL}:8091/app/rest/userGroups
    i=0
    while [[ $i -ne 10 ]]
    do
        i=$((i+1))
        curl -X POST -u "$curlUsername:$curlPassword" --header "Content-Type: application/json" \
        --data "$(createUserPostData)" \
        http://${TC_BASE_URL}:8091/app/rest/users
    done
done