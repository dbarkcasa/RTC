#!/bin/bash

# Check if input is an integer
is_integer() {
    if [[ $1 =~ ^-?[0-9]+$ ]]; then
        return 0  # True, input is an integer
    else
        return 1  # False, input is not an integer
    fi
}

while true; do
    echo -n "Please enter an integer (positive or negative): "
    read input

    # Validate input
    if is_integer "$input"; then
        echo "Thank you! You entered a valid integer: $input"
        break
    else
        echo "Invalid input. Please enter a whole number (integer)."
    fi
done