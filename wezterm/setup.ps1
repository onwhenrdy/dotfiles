# Setup.ps1 - This script creates or overwrites a file named .wezterm.lua in the user's home directory

# Get the directory of the current setup script
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path

# Define the full path to the .wezterm.lua file in the home directory
$homePath = [System.Environment]::GetFolderPath('UserProfile')
$wezTermFilePath = Join-Path -Path $homePath -ChildPath ".wezterm.lua"

# Define the full path to the wezterm.lua file in the script directory, replace backslashes with double backslashes for Lua escaping
$wezTermLuaPath = Join-Path -Path $scriptPath -ChildPath "wezterm.lua"
$wezTermLuaPath = $wezTermLuaPath -replace '\\', '/'

# Define the content to write into the .wezterm.lua file
# Modify this content as needed for your configuration
$fileContent = @"
-- WezTerm configuration
dofile("$wezTermLuaPath")
"@

# Write the content to the .wezterm.lua file, overwriting it if it already exists
Set-Content -Path $wezTermFilePath -Value $fileContent -Force

# Output to confirm the action
Write-Host "The file .wezterm.lua has been created/updated successfully in your home directory at $wezTermFilePath"
Read-Host -Prompt "Press Enter to exit"