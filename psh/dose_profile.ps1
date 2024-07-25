# Aliases
Set-Alias tt broot
Set-Alias tree broot

Set-Alias vim nvim
Set-Alias vi nvim

Set-Alias ll lsd
Set-Alias ls lsd

Set-Alias lg lazygit

Set-Alias top ntop
Set-Alias htop ntop

Set-Alias nano micro


function yy {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath $cwd
    }
    Remove-Item -Path $tmp
}

function IV-bat-as-cat { bat -pp ${args} }
Set-Alias cat IV-bat-as-cat

function wt { wezterm start --cwd "." & }

function usec { conda "shell.powershell" "hook" | Out-String | Invoke-Expression }
function killc { conda deactivate }

# directory information provider for wezterm
function Invoke-Starship-PreCommand {
    $current_location = $executionContext.SessionState.Path.CurrentLocation
    if ($current_location.Provider.Name -eq "FileSystem") {
        $ansi_escape = [char]27
        $provider_path = $current_location.ProviderPath -replace "\\", "/"
        $prompt = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}$ansi_escape\"
    }
    $host.ui.Write($prompt)
}

Invoke-Expression (&starship init powershell)

# Zoxide
Invoke-Expression (& { (zoxide init --cmd cd powershell | Out-String) })

# Predictions
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -PredictionSource HistoryAndPlugin  