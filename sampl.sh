
#!/bin/bash
echo "1. Users with sudo access"
getent group sudo

echo "2. Users with empty passwords"

EMPTY_USERS=$(sudo awk -F: '($2==""){print $1}' /etc/shadow)

if [ -z "$EMPTY_USERS" ]
then
    echo "No users with empty passwords found."
else
    echo "Users with empty passwords:"
    echo "$EMPTY_USERS"
fi

