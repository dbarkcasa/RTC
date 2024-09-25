# Define the directory to monitor
$directoryPath = "C:\Users\darry\Documents"  # Change this to the directory you want to monitor

# Define the path to the baseline file that stores original checksums
$baselineFilePath = "C:\Users\darry\Documents\checksums.txt"  # Change this to where you want to store the baseline

# Function to calculate the SHA-256 checksum of a file
function Get-FileChecksum {
    param ($filePath)
    
    # Open the file and create a SHA256 hash object
    $stream = [System.IO.File]::OpenRead($filePath)
    $sha256 = [System.Security.Cryptography.SHA256]::Create()
    
    # Compute the hash and convert it to a hexadecimal string
    $hashBytes = $sha256.ComputeHash($stream)
    $stream.Close()
    
    $hashString = -join ($hashBytes | ForEach-Object { "{0:x2}" -f $_ })
    return $hashString
}

# Function to create a baseline of checksums for the directory
function Create-Baseline {
    param ($directoryPath, $baselineFilePath)
    
    Write-Host "Creating baseline checksums for directory: $directoryPath"
    
    # Get a list of all files in the directory and subdirectories
    $files = Get-ChildItem -Path $directoryPath -File -Recurse
    
    # Calculate the checksum for each file and save to the baseline file
    $checksums = @()
    foreach ($file in $files) {
        $checksum = Get-FileChecksum -filePath $file.FullName
        $checksums += "$($file.FullName)=$checksum"
    }
    
    # Save checksums to the baseline file
    $checksums | Out-File -FilePath $baselineFilePath -Encoding utf8
    Write-Host "Baseline checksums saved to: $baselineFilePath"
}

# Function to check for file integrity against the baseline
function Check-FileIntegrity {
    param ($directoryPath, $baselineFilePath)
    
    Write-Host "Checking file integrity for directory: $directoryPath"
    
    # Load baseline checksums
    $baselineChecksums = Get-Content -Path $baselineFilePath
    
    # Convert baseline data to a hashtable for easy lookup
    $baselineHashTable = @{}
    foreach ($entry in $baselineChecksums) {
        $filePath, $checksum = $entry -split '='
        $baselineHashTable[$filePath] = $checksum
    }
    
    # Get a list of all files in the directory and subdirectories
    $currentFiles = Get-ChildItem -Path $directoryPath -File -Recurse
    
    # Check each file against the baseline
    foreach ($file in $currentFiles) {
        $currentChecksum = Get-FileChecksum -filePath $file.FullName
        
        # If the file is not in the baseline, it's a new file
        if (-not $baselineHashTable.ContainsKey($file.FullName)) {
            Write-Host "New file detected: $($file.FullName)"
        }
        # If the file's checksum doesn't match the baseline, it has been modified
        elseif ($baselineHashTable[$file.FullName] -ne $currentChecksum) {
            Write-Host "File modified: $($file.FullName)"
        }
    }
    
    # Check for deleted files by comparing the baseline against the current file list
    $currentFilePaths = $currentFiles.FullName
    foreach ($filePath in $baselineHashTable.Keys) {
        if (-not $currentFilePaths -contains $filePath) {
            Write-Host "File deleted: $filePath"
        }
    }
}

# Check if the baseline file exists
if (-not (Test-Path -Path $baselineFilePath)) {
    # If the baseline file doesn't exist, create it
    Write-Host "Baseline file not found. Creating a new baseline..."
    Create-Baseline -directoryPath $directoryPath -baselineFilePath $baselineFilePath
} else {
    # If the baseline file exists, check file integrity
    Check-FileIntegrity -directoryPath $directoryPath -baselineFilePath $baselineFilePath
}