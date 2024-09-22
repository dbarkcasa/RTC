# Define the time frame to check for account lockout events (last 24 hours)
$timeFrame = (Get-Date).AddDays(-1)

# Retrieve account lockout events from the Security event log
# Event ID 4740 corresponds to account lockout events
$lockoutEvents = Get-WinEvent -FilterHashtable @{
    LogName = 'Security';            # Specify the Security log
    ID = 4740;                       # Event ID for account lockout
    StartTime = $timeFrame           # Filter for events in the last 24 hours
}

# Check if there are any lockout events
if ($lockoutEvents.Count -eq 0) {
    Write-Host "No account lockout events found in the last 24 hours."
} else {
    Write-Host "Account Lockout Events in the Last 24 Hours:`n"
    
    # Loop through each lockout event and display details
    foreach ($event in $lockoutEvents) {
        # Extract relevant details from the event
        $timeCreated = $event.TimeCreated           # Time the event was created
        $message = $event.Message                   # The full message of the event
        
        # Output the event time and message
        Write-Host "Time: $timeCreated"
        Write-Host "Details: $message"
        Write-Host "------------------------"           # Separator for readability
    }
}
