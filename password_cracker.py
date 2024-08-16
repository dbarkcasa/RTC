# Imports the crypt module, which provides functions for hashing passwords
import crypt

# Define a function named testPass that takes cryptPass (a hashed password) as an argument
def testPass(cryptPass):
    # Extracts the first two characters from the hashed password to get the salt value used in hashing
    salt = cryptPass[0:2]
    # Attempts to open the file dictionary.txt for reading. The try block handles potential errors like the file not being found
    try:
        dictFile = open('dictionary.txt', 'r')
        # Iterates over each line in the dictionary file. 
        for word in dictFile:
            # Removes any leading or trailing whitespace (including newline characters) from each line
            word = word.strip()
            # Uses the crypt.crypt() function to hash the current word with the salt extracted earlier
            cryptWord = crypt.crypt(word, salt)
           # Compares the hashed word with the given hashed password
            if cryptWord == cryptPass:
                print('[+] Found Password: ' + word + '\n')
                dictFile.close()
                return
        # Closes the dictionary file after processing all lines
        dictFile.close()
    # Catches a FileNotFoundError if the dictionary file is missing and prints an error message
    except FileNotFoundError:
        print('[-] Dictionary file not found.\n')
    # If no matching password is found, prints a message indicating this and exits the function
    print('[-] Password Not Found.\n')
    return

# Defines the main() function that will orchestrate the password cracking process
def main():
    try:
        # Attempts to open the file passwords.txt for reading.
        passFile = open('passwords.txt', 'r')
        # Iterates over each line in the passwords file
        for line in passFile:
            # Checks if a colon (:) is present, which indicates that the line contains a username and a hashed password
            if ':' in line:
                # Splits the line at the colon into user and cryptPass
                parts = line.split(':')
                user = parts[0]
                cryptPass = parts[1].strip()
                #  Prints a message indicating which user’s password is being cracked
                print('[*] Cracking Password For: ' + user)
                # Calls the testPass() function to attempt to crack the hashed password
                testPass(cryptPass)
        # Calls the testPass() function to attempt to crack the hashed password
        passFile.close()
    # Catches a FileNotFoundError if the passwords file is missing and prints an error message    
    except FileNotFoundError:
        print('[-] Passwords file not found.\n')
# Ensures that main() is called when the script is executed directly (not imported as a module in another script)
if __name__ == '__main__':
    main()
