# Display a title

print("\t \t \t Miles per Gallon Program!")
print()

# Get input from users
miles_driven = float(input("Enter miles driven: \t \t"))
gallons_used = float(input("Enter gallons used: \t"))

# Arithmetic Operation (Division)
miles_per_gallon = miles_driven / gallons_used
miles_per_gallon = round(miles_per_gallon, 2)

# Display miles per gallon
print()
print(f"Miles Per Gallon: \t\t {miles_per_gallon}")

print()
print("Thank You!!!")