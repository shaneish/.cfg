# wezterm
dnf copr enable -y wezfurlong/wezterm-nightly
dnf install -y wezterm

_lnkr $CFG/wezterm $CONFIGS/wezterm
_lnkr $HOME/wezterm.lua
_empa SHELL $(which wezterm)