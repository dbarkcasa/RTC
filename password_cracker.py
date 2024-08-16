import zipfile  # For handling ZIP files

def testPassword(zip_file_path, dictionary_file_path):
    """Try each password from the dictionary on the ZIP file."""
    try:
        # Open dictionary file
        with open(dictionary_file_path, 'r') as dictFile:
            # Go through each password in the file
            for line in dictFile:
                password = line.strip()  # Remove extra spaces
                try:
                    # Try to open ZIP file with this password
                    with zipfile.ZipFile(zip_file_path, 'r') as zipFile:
                        zipFile.extractall(pwd=password.encode())  # Need to encode password
                        print(f'[+] Found Password: {password}\n')  # Print if it worked
                        return  # Stop if found
                except RuntimeError:
                    # Password didn’t work, move to next
                    continue
    except FileNotFoundError:
        # Dictionary file not found
        print('[-] Dictionary file not found.\n')
    print('[-] Password Not Found.\n')  # No password found

def main():
    """Main function to start cracking."""
    zip_file_path = 'protected.zip'  # ZIP file to crack
    dictionary_file_path = 'dictionary.txt'  # Dictionary with passwords
    testPassword(zip_file_path, dictionary_file_path)  # Run the test

if __name__ == '__main__':
    main()  # Run main function if script is executed

