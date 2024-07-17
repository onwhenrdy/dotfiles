# My dotfiles and setup files

![stability-mature](https://img.shields.io/badge/stability-mature-00800.svg) ![GitHub](https://img.shields.io/badge/dotfiles-blue)

**Oh no, not another dotfiles repo!**

## Requirements and Limitations

1. Does currently only work on Windows.
2. Requires `scoop` package manager for Windows.

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```

3. You need `python3`.

## Setup

### Setup SymLinks and Environment Variables

```bash
python3 setup_symlinks.py
```

1. Creates symlinks to the dotfiles
2. Adds the `scripts` folder to the `PATH` environment variable.
3. Sets the `DOTFILES` environment variable to the root of the dotfiles folder.
4. Sets the `R_LIBS_USER` environment variable.

### Install Fonts

```bash
python3 install_fonts.py
```

This will install fonts from the `fonts` folder for the current `user` (not system-wide).

### Install Apps

This will install software with `scoop`.

```powershell
install_apps.bat
```

### Scripts

#### `CreateProject.ps1`

- Powerscript to create a private Github repository and clone it to your local machine into a folder, than open in `code`.
- `gh` cli must be installed and configured (<https://cli.github.com/>).
- Must change `$rootDir` settings to your root project directory.
- Script folder should be in `PATH` (`setup_symlinks.ps1` will handle that).
- Usage: `CreateProject.ps1 <project-name>`
