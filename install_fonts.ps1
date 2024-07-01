# Get the location of the script
$scriptLocation = Split-Path -Path $MyInvocation.MyCommand.Definition
Write-Output "Script is running in: $scriptLocation"

# Get all font files recursively from the fonts folder
$fontsFolder = Join-Path -Path $scriptLocation -ChildPath "fonts"
$fontFiles = Get-ChildItem -Path $fontsFolder -Filter "*.ttf" -Recurse

# Process the font files
foreach ($fontFile in $fontFiles) {
    
    # Install each font file for the local user
    $fontDestination = Join-Path -Path $env:USERPROFILE -ChildPath "AppData\Local\Microsoft\Windows\Fonts"
    $existingFont = Get-ChildItem -Path $fontDestination -Filter $fontFile.Name -ErrorAction SilentlyContinue
    
    # Copy the font file only if it doesn't already exist
    if ($null -eq $existingFont) {
        Copy-Item -Path $fontFile.FullName -Destination $fontDestination
        Write-Output "Installed font file: $($fontFile.FullName)"
    }
    else {
        Write-Output "Font file already exists: $($fontFile.FullName)"
    }
}
