def feet_to_inches(feet):
    return feet * 12

def main():
    feet = float(input("Enter the number of feet: "))
    inches = feet_to_inches(feet)
    print(f"{feet} feet is {inches} inches.")

if __name__ == "__main__":
    main()