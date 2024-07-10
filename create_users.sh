#!/bin/bash

# Array of usernames
usernames=("user1" "user2" "user3" "user4" "user5")

# Array of passwords corresponding to each username
passwords=("password1" "SecurePassword2" "123456" "ComplexPassword!3" "password123")

# Create users and set passwords
for ((i=0; i<${#usernames[@]}; i++)); do
    username=${usernames[$i]}
    password=${passwords[$i]}
    
    # Create user
    sudo useradd -m $username
    
    # Set password for user
    echo -e "$password\n$password" | sudo passwd $username
done