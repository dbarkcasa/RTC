# Import the requests library to make HTTP requests to the server
import requests

# Function to perform directory brute-forcing
def dir_bruteforce(base_url, wordlist):
    # Loop through each word in the wordlist (potential directory names)
    for word in wordlist:
        # Construct the full URL by appending the word to the base_url
        # strip() removes any leading/trailing whitespace from the word
        url = f"{base_url}/{word.strip()}"
        
        # Send a GET request to the constructed URL
        response = requests.get(url)
        
        # If the server responds with a 200 OK status, it means the directory exists
        if response.status_code == 200:
            # Print the discovered directory URL
            print(f"[+] Discovered: {url}")

# The base URL of the target web application
base_url = "http://example.com"

# A list of common directory names that the script will test
wordlist = ["admin", "login", "backup", "config"]

# Call the directory brute-force function, passing in the base_url and wordlist
dir_bruteforce(base_url, wordlist)
