# Define the time frame to monitor for failed login attempts (last 30 days)
$timeFrame = (Get-Date).AddDays(-30)

# Retrieve failed login attempts from the Security event log
# Event ID 4625 corresponds to failed login attempts (An account failed to log on)
$failedLogonEvents = Get-WinEvent -FilterHashtable @{
    LogName = 'Security';            # Specify the Security log
    ID = 4625;                       # Event ID for failed login attempts
    StartTime = $timeFrame           # Filter for events in the last 30 days
}

# Check if there are any failed login events
if ($failedLogonEvents.Count -eq 0) {
    Write-Host "No failed login attempts found in the last 30 days."
} else {
    Write-Host "Failed Login Attempts in the Last 30 Days:`n"
    
    # Initialize an empty list to store the offending IP addresses
    $offendingIPs = @()

    # Loop through each failed logon event and extract IP addresses
    foreach ($event in $failedLogonEvents) {
        $eventMessage = $event.Message                # The full event message
        
        # Use a regex pattern to extract the source IP address from the event message
        $ipRegex = [regex]'\d{1,3}(\.\d{1,3}){3}'     # Matches standard IPv4 addresses
        
        # Search for the IP address in the event message
        $ipAddress = $ipRegex.Match($eventMessage).Value
        
        # If an IP address is found, add it to the list
        if ($ipAddress) {
            Write-Host "Failed login attempt from IP: $ipAddress"
            $offendingIPs += $ipAddress
        }
    }

    # Remove duplicate IP addresses
    $uniqueIPs = $offendingIPs | Sort-Object -Unique

    # Add firewall rules to block each offending IP address
    foreach ($ip in $uniqueIPs) {
        # Check if a firewall rule for the IP already exists
        $existingRule = Get-NetFirewallRule -RemoteAddress $ip -ErrorAction SilentlyContinue
        
        if (-not $existingRule) {
            # If no existing rule is found, create a new firewall rule to block the IP
            New-NetFirewallRule -DisplayName "Block Brute Force IP $ip" -Direction Inbound -RemoteAddress $ip -Action Block
            Write-Host "Blocked IP address: $ip via Windows Firewall."
        } else {
            Write-Host "IP address $ip is already blocked."
        }
    }
}