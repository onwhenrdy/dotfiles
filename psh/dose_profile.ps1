# Aliases
Set-Alias tt tree
Set-Alias vim nvim
Set-Alias vi nvim
Set-Alias ll ls

# OMP
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$ompPath = "$scriptPath\..\omp\dose.omp.json"
$ompPath = Resolve-Path $ompPath
oh-my-posh init pwsh --config "$ompPath" | Invoke-Expression