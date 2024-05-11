# Get the directory of the current setup script
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path

# Define the path to the PowerShell profile for the current user
$DOC = [Environment]::GetFolderPath([Environment+SpecialFolder]::MyDocuments)
$profilePath = "$DOC\PowerShell\Microsoft.PowerShell_profile.ps1"  # For PowerShell Core

# Create the profile directory if it doesn't exist
$profileDir = Split-Path -Path $profilePath
if (-not (Test-Path -Path $profileDir)) {
    New-Item -Path $profileDir -ItemType Directory
}

# Create or overwrite the PowerShell profile
"`n# Auto-generated profile script
# Load all PowerShell scripts from the setup script directory
. '$scriptPath\dose_profile.ps1'
" | Set-Content -Path $profilePath

# Output to confirm action
Write-Host "PowerShell profile has been created/updated successfully."
Write-Host "Profile Path: $profilePath"

# Pause at the end
Read-Host "Press Enter to exit"
