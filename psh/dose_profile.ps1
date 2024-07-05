# Aliases
Set-Alias tt tree
Set-Alias vim nvim
Set-Alias vi nvim
Set-Alias ll ls
function wt { wezterm start --cwd "." & }

function usec { conda "shell.powershell" "hook" | Out-String | Invoke-Expression }
function killc { conda deactivate }

# Starship
Invoke-Expression (&starship init powershell)