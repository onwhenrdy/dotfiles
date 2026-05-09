# My dotfiles and setup files

![stability-mature](https://img.shields.io/badge/stability-mature-00800.svg) ![GitHub](https://img.shields.io/badge/dotfiles-blue)

## What's configured

Configs in this repo are symlinked into their expected locations on the host:

| Tool       | Source                  |
|------------|-------------------------|
| Wezterm    | `wezterm/.wezterm.lua`  |
| Tabby      | `tabby/config.yaml`     |
| Starship   | `starship/starship.toml`|
| PowerShell | `psh/dose_profile.ps1`  |
| Git        | `git/.gitconfig`        |
| Neovim     | `nvim/init.lua`         |
| Micro      | `micro/settings.json`   |
| Lazygit    | `lazygit/config.yml`    |
| Bat        | `bat/config`            |
| Radian     | `radian/.radian_profile`|
| R          | `R/.Rprofile`           |
| LintR      | `linter/.lintr`         |

The list of apps to install lives in `scoop/Scoopfile.json`; bundled fonts (FiraCode, JetBrains Mono, Hack Nerd Font) live in `fonts/`.

## Requirements

1. Windows only.
2. [`scoop`](https://scoop.sh) package manager:

   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
   ```

3. Bootstrap dependencies (so `just bootstrap` can run):

   ```powershell
   scoop install git python just
   ```

4. **Symlink creation requires admin privileges *or* Developer Mode** (Settings → Privacy & security → For developers → Developer Mode).

## Setup

```powershell
just bootstrap
```

Runs symlinks → fonts → scoop apps → PowerShell modules in order. Or run individual recipes:

```powershell
just symlinks       # symlink all dotfiles into their target locations
just fonts          # install bundled fonts for current user
just apps           # scoop import scoop/Scoopfile.json
just psmodules      # Install-Module PSFzf (and any future modules)
just scoop-export   # refresh scoop/Scoopfile.json from current scoop state
```

After `just psmodules` runs once, PSFzf adds two shortcuts in PowerShell:

- **Ctrl-T** — fuzzy file search at the cursor
- **Ctrl-R** — fuzzy command-history search

`setup_symlinks.py` also:

- Adds the `scripts` folder to `PATH`
- Sets `DOTFILES` env var to the repo root
- Sets `R_LIBS_USER`
- Sets `YAZI_FILE_ONE`

If a real config file already exists at a target location, it's renamed to `<file>.bak.<timestamp>` before being replaced by a symlink.
