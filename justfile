set windows-shell := ["pwsh", "-NoLogo", "-Command"]

# List available recipes
default:
    @just --list

# Run all setup steps
bootstrap: symlinks fonts apps psmodules

# Create symlinks for dotfiles
symlinks:
    python setup_symlinks.py

# Install bundled fonts for current user
fonts:
    python install_fonts.py

# Install apps from scoop/Scoopfile.json
apps:
    scoop import scoop/Scoopfile.json

# Install required PowerShell modules
psmodules:
    Install-Module -Name PSFzf -Scope CurrentUser -Force -AcceptLicense

# Refresh scoop/Scoopfile.json from current scoop state
scoop-export:
    scoop export | Out-File -Encoding utf8NoBOM scoop/Scoopfile.json
