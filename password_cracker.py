#!/usr/bin/python3
# -*- coding: utf-8 -*-
import zipfile  # For handling ZIP files
import time  # For timing the progress updates

def testPassword(zip_file_path, dictionary_file_path):
    """Try each password from the dictionary on the ZIP file."""
    attempt = 0  # Initialize attempt counter
    total_passwords = 0  # Total number of passwords
    start_time = time.time()  # Record the start time
    update_interval = 6  # Interval for progress updates in seconds

    # First pass: count total number of passwords
    with open(dictionary_file_path, 'r', encoding='utf-8') as dictFile:
        total_passwords = sum(1 for _ in dictFile)  # Count lines in the dictionary file
        print(f'Total passwords to try: {total_passwords}')

    # Second pass: attempt to crack the password
    with open(dictionary_file_path, 'r', encoding='utf-8') as dictFile:
        for line in dictFile:
            attempt += 1  # Increment attempt counter
            password = line.strip()  # Remove extra spaces
            try:
                # Try to open ZIP file with this password
                with zipfile.ZipFile(zip_file_path, 'r') as zipFile:
                    zipFile.extractall(pwd=password.encode())  # Need to encode password
                    print(f'[+] Found Password: {password}\n')  # Print if it worked
                    return  # Stop if found
            except RuntimeError:
                # Password didn’t work, move to next
                pass

            # Print progress message every 6 seconds
            elapsed_time = time.time() - start_time
            if elapsed_time > update_interval:
                progress_percentage = (attempt / total_passwords) * 100
                print(f'[-] Attempt {attempt}/{total_passwords} ({progress_percentage:.2f}% completed)')
                start_time = time.time()  # Reset the start time for the next interval

    print('[-] Password Not Found.\n')  # No password found

def main():
    zip_file_path = r'C:\Users\darry\OneDrive\Desktop\Password Cracker\New Compressed (zipped) Folder.zip'  # ZIP file to crack
    dictionary_file_path = r'C:\Users\darry\OneDrive\Desktop\Password Cracker\rockyou_1.txt'  # Dictionary with passwords
    testPassword(zip_file_path, dictionary_file_path)  # Run the test

if __name__ == '__main__':
    main()  # Run main function if script is executed
