# Master Setup.ps1 - Executes all setup.ps1 scripts found in subdirectories

# Get the directory of the current script
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path

# Find all setup.ps1 files in subdirectories
$setupFiles = Get-ChildItem -Path $scriptPath -Filter "setup.ps1" -Recurse

# Execute each setup.ps1 script found
foreach ($file in $setupFiles) {
    Write-Host "Running setup script: $($file.FullName)"
    & $file.FullName
}

# Output to confirm completion
Write-Host "All setup scripts have been executed."
