# Aliases
Set-Alias tt tree
Set-Alias vim nvim
Set-Alias vi nvim
Set-Alias ll ls
Set-Alias lg lazygit

function wt { wezterm start --cwd "." & }

function usec { conda "shell.powershell" "hook" | Out-String | Invoke-Expression }
function killc { conda deactivate }


# Starship
#function Invoke-Starship-TransientFunction {
#    &starship module character
#}
Invoke-Expression (&starship init powershell)
#Enable-TransientPrompt

# Zoxide
Invoke-Expression (& { (zoxide init --cmd cd powershell | Out-String) })

# Predictions
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -PredictionSource HistoryAndPlugin  