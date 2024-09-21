# Get OS Information
# Using Get-WmiObject to query the Win32_OperatingSystem class for OS details
$osInfo = Get-WmiObject -Class Win32_OperatingSystem

# Output the OS name and version to the console
Write-Host "Operating System: $($osInfo.Caption)"
Write-Host "Version: $($osInfo.Version)"

# Output the OS architecture (32-bit or 64-bit)
Write-Host "Architecture: $($osInfo.OSArchitecture)"

# Get Installed Software
# We're using Win32_Product class to list installed programs on the system
Write-Host "`nInstalled Software:"
Get-WmiObject -Class Win32_Product | Select-Object Name, Version | Sort-Object Name
# The Select-Object is used to only display the Name and Version of each installed program
# Sort-Object is used to alphabetically sort the software by name

# Get Network Configuration
# Using Win32_NetworkAdapterConfiguration to retrieve network adapter settings
Write-Host "`nNetwork Configuration:"
$networkAdapters = Get-WmiObject -Class Win32_NetworkAdapterConfiguration | Where-Object { $_.IPEnabled -eq "True" }
# Where-Object filters for only network adapters that are currently enabled and have an IP address

# Loop through each enabled network adapter and display its details
foreach ($adapter in $networkAdapters) {
    Write-Host "Adapter: $($adapter.Description)"       # The network adapter description (e.g., Ethernet or Wi-Fi adapter)
    Write-Host "IP Address: $($adapter.IPAddress)"      # The IP address assigned to the adapter
    Write-Host "MAC Address: $($adapter.MACAddress)"    # The MAC address of the adapter
    Write-Host "Subnet Mask: $($adapter.IPSubnet)"      # The subnet mask of the adapter
    Write-Host "Default Gateway: $($adapter.DefaultIPGateway)"  # The gateway address used by this adapter
    Write-Host "------------------------"              # Separator line for better readability
}

# Get System Uptime
# Uptime is calculated using the LastBootUpTime from Win32_OperatingSystem
$uptime = (Get-WmiObject -Class Win32_OperatingSystem).LastBootUpTime

# Convert LastBootUpTime to a proper DateTime object
$uptime = (Get-WmiObject -Class Win32_OperatingSystem).LastBootUpTime
$uptimeDate = [System.Management.ManagementDateTimeConverter]::ToDateTime($uptime)

# Calculate the system uptime by subtracting the boot time from the current date
$uptimeDifference = (Get-Date) - $uptimeDate

# Output the system uptime in days
Write-Host "`nSystem Uptime: $($uptimeDifference.Days) days"

# Get CPU Information
# Using Win32_Processor to retrieve CPU details
$cpu = Get-WmiObject -Class Win32_Processor

# Output the CPU name, which typically includes the model and brand (e.g., Intel Core i7)
Write-Host "`nCPU: $($cpu.Name)"

# Output the number of physical cores in the CPU
Write-Host "Cores: $($cpu.NumberOfCores)"

# Output the number of logical processors (including hyper-threading if applicable)
Write-Host "Logical Processors: $($cpu.NumberOfLogicalProcessors)"

# Get Disk Information
# Querying Win32_LogicalDisk to retrieve information about the logical disks (hard drives)
Write-Host "`nDisk Drives:"
Get-WmiObject -Class Win32_LogicalDisk | Where-Object { $_.DriveType -eq 3 } | ForEach-Object {
    # DriveType 3 represents local disks (e.g., C: or D: drives)

    # Output the drive letter (e.g., C:)
    Write-Host "Drive: $($_.DeviceID)"

    # Output the free space on the drive in gigabytes, rounded to two decimal places
    Write-Host "Free Space: $([math]::round($_.FreeSpace/1GB,2)) GB"

    # Output the total size of the drive in gigabytes, rounded to two decimal places
    Write-Host "Total Size: $([math]::round($_.Size/1GB,2)) GB"

    # Separator line for better readability
    Write-Host "------------------------"
}
