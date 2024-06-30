# Get the location of the script
$scriptLocation = Split-Path -Path $MyInvocation.MyCommand.Definition
Write-Output "Script is running in: $scriptLocation"

$files = @(
    @{
        Source      = Join-Path -Path $scriptLocation -ChildPath "wezterm/.wezterm.lua"
        Destination = Join-Path -Path $Home -ChildPath ".wezterm.lua"
    },
    @{
        Source      = Join-Path -Path $scriptLocation -ChildPath "radian/.radian_profile"
        Destination = Join-Path -Path $Home -ChildPath ".radian_profile"
    }
    # Add more file pairs here
)

foreach ($file in $files) {
    $sourcePath = $file.Source
    $destinationPath = $file.Destination

    try {
        # Check if the destination file exists and remove it if it does
        if (Test-Path -Path $destinationPath) {
            Remove-Item -Path $destinationPath -Force
        }

        New-Item -ItemType SymbolicLink -Path $destinationPath -Target $sourcePath > $null

        Write-Output "Symbolic link created from '$sourcePath' to '$destinationPath'"
    }
    catch {
        Write-Output "Failed to create symbolic link from '$sourcePath' to '$destinationPath'. Error: $_"
    }
}