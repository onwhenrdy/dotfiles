# My dotfiles and setup instructions

![stability-wip](https://img.shields.io/badge/stability-wip-lightgrey.svg) ![GitHub](https://img.shields.io/badge/dotfiles-blue)

__Oh no, not another dotfiles repo!__

## Setup SymLinks

Setup for the creation of symlinks: `setup.ps1` (powershell; __not finised yet__).

## Install Software

For `R` install required version.

```powershell
winget install -e --id Git.Git
winget install Neovim.Neovim
winget install JanDeDobbeleer.OhMyPosh -s winget
winget install wez.wezterm
winget install -e --id Microsoft.VisualStudioCode
winget install -e --id RProject.R -v "4.3.1"
winget install -e --id RProject.Rtools -v "4.3.5958"
pip install radian
```

## Update Software

Be careful with `R` updates. Check the version first.

```powershell
winget upgrade 
winget upgrade APPNAME
pip install radian --upgrade
```

## Folders

### art

Just pics.

### git

- My `.gitconfig` file.
- Must be placed as `~/.gitconfig`.
- Install `git` via `winget install -e --id Git.Git` (powershell).
- Update `git` via `winget upgrade Git.Git` (powershell).

### linter

- My linter settings.
- Must be placed in `~`.

### nvim

- My neovim settings (single file `init.lua`).
- Has keybindings for the noevim vscode plugin as well.
- Must be placed in `~\AppData\Local\nvim`.
- Website: <https://neovim.io/>.
- Install via `winget install Neovim.Neovim` (powershell).
- Update via `winget upgrade Neovim.Neovim` (powershell).

### psh

- `dose_profile.ps1`: Powershell profile settings
- Must be places as `~\..\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`.
- `...` if `OneDrive` is used.

### omp

- `omp`: Oh my posh settings
- Install via `winget install JanDeDobbeleer.OhMyPosh -s winget` (powershell)
- Update `winget upgrade JanDeDobbeleer.OhMyPosh -s winget`
- Website: <https://ohmyposh.dev/>

### radian

- `.radian_profile`: Radian settings
- Must be placed as `~/.radian_profile`.
- Install via `pip install radian`.
- Update via `pip install radian --upgrade`.

### WezTerm

- `wezterm.lua`: WezTerm settings
- Must be placed as `~/wezterm.lua`.
- Download WezTerm from <https://wezfurlong.org/wezterm/>.
- Install via `winget install wez.wezterm`.
- Update via `winget upgrade wez.wezterm`.

### R

- `.Rprofile`: R settings
- Must be placed as `~/.Rprofile`.

### Fonts

- `JetBrainsMono`: JetBrains Mono font (see <https://www.jetbrains.com/lp/mono/>).
- `FiraCode`: Fira Code font (see <https://github.com/tonsky/FiraCode>).
- `HackNerdFont`: Hack Nerd Font (see <https://www.nerdfonts.com/font-downloads>).

### scripts

- `CreateProject.ps1`: Powerscript to create a private Github repository and clone it to your local machine into a folder, than open in `code`.
-`gh` cli must be installed and configured (<https://cli.github.com/>).
- Must change `$rootDir` settings to your root project directory.
- Script folder should be in `PATH`
- Usage: `CreateProject.ps1 <project-name>`

### vscode

This is just a backup of my vscode settings, keybindings and extensions.
