# Environment Variables
$env:EDITOR = "code --wait"

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

function ccd { claude --dangerously-skip-permissions $args }

# remove default `r` alias (Invoke-History) so it can launch R/radian
Remove-Item alias:\r -ErrorAction SilentlyContinue

function sudowez { Start-Process wezterm -Verb runas }

# for python virtual environments
function venv {
    if (Test-Path .\.venv\Scripts\Activate.ps1) {
        . .\.venv\Scripts\Activate.ps1
    } else {
        Write-Host "No .venv in current directory" -ForegroundColor Yellow
    }
}

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

function wez { wezterm start --cwd "." & }

function d2u { Get-ChildItem -Recurse -File | ForEach-Object { dos2unix $_.FullName -e -q } }

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

# Starship — cache `init` output so we don't spawn the exe every shell start.
# Rebuilds when starship.exe is newer than the cache (i.e. after an upgrade).
$starshipCache = "$env:LOCALAPPDATA\starship\init.ps1"
$starshipExe = (Get-Command starship -ErrorAction SilentlyContinue).Source
if ($starshipExe -and (-not (Test-Path $starshipCache) -or (Get-Item $starshipExe).LastWriteTime -gt (Get-Item $starshipCache).LastWriteTime)) {
    New-Item -ItemType Directory -Force -Path (Split-Path $starshipCache) | Out-Null
    starship init powershell --print-full-init | Out-File $starshipCache -Encoding utf8
}
if (Test-Path $starshipCache) { . $starshipCache }

# Zoxide — same caching pattern
$zoxideCache = "$env:LOCALAPPDATA\zoxide\init.ps1"
$zoxideExe = (Get-Command zoxide -ErrorAction SilentlyContinue).Source
if ($zoxideExe -and (-not (Test-Path $zoxideCache) -or (Get-Item $zoxideExe).LastWriteTime -gt (Get-Item $zoxideCache).LastWriteTime)) {
    New-Item -ItemType Directory -Force -Path (Split-Path $zoxideCache) | Out-Null
    zoxide init --cmd cd powershell | Out-File $zoxideCache -Encoding utf8
}
if (Test-Path $zoxideCache) { . $zoxideCache }

# Predictions — only when running interactively in a real terminal
if (-not [Console]::IsOutputRedirected -and $Host.Name -eq 'ConsoleHost') {
    Set-PSReadLineOption -PredictionViewStyle ListView
    Set-PSReadLineOption -PredictionSource History
}

# PSFzf — Ctrl-T file search, Ctrl-R history search (requires `Install-Module PSFzf`)
if (Get-Module -ListAvailable -Name PSFzf) {
    Import-Module PSFzf
    Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
}

