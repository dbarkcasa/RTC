#!/bin/bash

while true; do
    echo "Menu:"
    echo "1. List users who are logged in"
    echo "2. List system information"
    echo "3. List the five largest files in the current directory"
    echo "4. List basic CPU information"
    echo "5. Display system time"
    echo "6. Exit the program"
    echo -n "Enter your choice: "
    read choice

    case $choice in
        1)
            echo "Listing users who are logged in:"
            who
            ;;
        2)
            echo "Listing system information:"
            uname -v
            ;;
        3)
            echo "Listing the five largest files in the current directory:"
            ls -lS | head -n 6
            ;;
        4)
            echo "Listing basic CPU information:"
            lscpu | head
            ;;
        5)
            echo "Displaying system time:"
            date
            ;;
        6)
            echo "Exiting the program. Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid option. Please try again."
            ;;
    esac

    echo # Print a blank line for better readability
done
