scoop bucket add extras
scoop bucket add main

scoop install git
scoop install extras/gh
scoop install just
scoop install main/watchexec@2.0.0
scoop install lazygit
scoop install neovim
scoop install micro
sccop install extras/vscode
scoop install main/starship
scoop install fzf
scoop install zoxide
scoop install ntop
sccop install perl
scoop install extras/wezterm
scoop install ripgrep
scoop install broot
scoop install lsd
scoop install bat
scoop install dua
scoop install unar jq poppler fd yazi

iwr -useb https://raw.githubusercontent.com/sigoden/window-switcher/main/install.ps1 | iex

pip install radian
perl -MCPAN -e"install 'File::HomeDir'"
perl -MCPAN -e"install 'YAML::Tiny'"
