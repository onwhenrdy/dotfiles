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
    },
    @{
        Source      = Join-Path -Path $scriptLocation -ChildPath "r/.Rprofile"
        Destination = Join-Path -Path $Home -ChildPath ".Rprofile"
    },
    @{
        Source      = Join-Path -Path $scriptLocation -ChildPath "psh/dose_profile.ps1"
        Destination = Join-Path -Path (Join-Path -Path $([environment]::GetFolderPath("MyDocuments")) -ChildPath "PowerShell") -ChildPath "Microsoft.PowerShell_profile.ps1"
    },
    @{
        Source      = Join-Path -Path $scriptLocation -ChildPath "omp/dose.omp.json"
        Destination = Join-Path -Path $HOME -ChildPath "dose.omp.json"
    },
    @{
        Source      = Join-Path -Path $scriptLocation -ChildPath "git/.gitconfig"
        Destination = Join-Path -Path $HOME -ChildPath ".gitconfig"
    },
    @{
        Source      = Join-Path -Path $scriptLocation -ChildPath "linter/.lintr"
        Destination = Join-Path -Path $HOME -ChildPath ".lintr"
    },
    @{
        Source      = Join-Path -Path $scriptLocation -ChildPath "nvim/init.lua"
        Destination = Join-Path -Path "$env:LOCALAPPDATA\nvim" -ChildPath "init.lua"
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

# add scripts to path if not already there
$scriptsPath = Join-Path -Path $scriptLocation -ChildPath "scripts"
$pathArray = $env:Path -split ';'

if ($pathArray -notcontains $scriptsPath) {
    $newPath = "$env:Path;$scriptsPath"
    [System.Environment]::SetEnvironmentVariable('Path', $newPath, [System.EnvironmentVariableTarget]::User)
    Write-Output "Added '$scriptsPath' to PATH permanently for the current user."
}
else {
    Write-Output "'$scriptsPath' is already in PATH"
}