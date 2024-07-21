# Define the calories burned per minute
calories_per_minute = 4.2

# Define the time intervals in minutes
time_intervals = [10, 15, 20, 25, 30]

# Loop to roll through each time interval and calculate the calories burned
for minutes in time_intervals:
    calories_burned = calories_per_minute * minutes
    print(f"Calories burned after {minutes} minutes: {calories_burned:.2f}")
