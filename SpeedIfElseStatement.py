# User inputs speed
try:
    speed = float(input("Enter the speed: "))

    # Check if speed is in range 24 to 56
    if 24 <= speed <= 56:
        print("Speed is normal")
    else:
        print("Speed is abnormal")
except ValueError:
    print("Please enter a valid number for the speed.")