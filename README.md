# My dotfiles and setup files

![stability-mature](https://img.shields.io/badge/stability-mature-00800.svg) ![GitHub](https://img.shields.io/badge/dotfiles-blue)

__Oh no, not another dotfiles repo!__

## Setup Scripts

- Setup for the creation of symlinks: `setup_symlinks.ps1`
  - __Caution:__ This script will delete existing symlinks/files that already exist.
  - Adds `scripts` folder to `PATH`.

- Font installation: `install_fonts.ps1`
  - Installs fonts from the `Fonts` folder for the current user (not system wide).
  - Does not overwrite existing fonts.

## Install Software

```powershell
winget install -e --id GitHub.cli
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
- Must be placed in `~`.

### linter

- My linter settings.
- Must be placed in `~`.

### nvim

- My neovim settings (single file `init.lua`).
- Has keybindings for the noevim vscode plugin as well.
- Must be placed in `~\AppData\Local\nvim`.

### psh (PowerShell)

- `dose_profile.ps1`: Powershell profile settings
- Must be placed as `~\..\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`.

### omp

- `dose.omp.json`: Oh my posh settings

### radian

- `.radian_profile`: Radian settings
- Must be placed as `~/.radian_profile`.

### wezterm

- `wezterm.lua`: WezTerm settings
- Must be placed as `~/wezterm.lua`.

### r

- `.Rprofile`: R settings
- Must be placed as `~/.Rprofile`.
- Set env __`R_LIBS_USER = C:/Users/XXX/R/%v`__ to have a seprate library for each version!!

### fonts

- `JetBrainsMono`: JetBrains Mono ([Link](https://www.jetbrains.com/lp/mono/))
- `FiraCode`: Fira Code ([Link](https://github.com/tonsky/FiraCode/))
- `HackNerdFont`: Hack Nerd Font ([Link](https://www.nerdfonts.com/font-downloads/))

### scripts

#### `CreateProject.ps1`

- Powerscript to create a private Github repository and clone it to your local machine into a folder, than open in `code`.
- `gh` cli must be installed and configured (<https://cli.github.com/>).
- Must change `$rootDir` settings to your root project directory.
- Script folder should be in `PATH` (`setup_symlinks.ps1` will handle that).
- Usage: `CreateProject.ps1 <project-name>`

### vscode

This is just a backup of my vscode settings, keybindings and extensions.
