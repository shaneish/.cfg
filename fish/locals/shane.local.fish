set -gx DEFAULT_PY_VENV_DIR $HOME/.config/python-venvs
set -gx DEFAULT_PY_VENV $DEFAULT_PY_VENV_DIR/fast-venv
alias py="python"
alias ipy="ipython"
alias mvim="nvim -u $HOME/.config/nvim/minit.vim"

alias snvm="sudo nvm"
alias boxes="flatpak run org.gnome.Boxes"
alias spotify="flatpak run com.spotify.Client"

set -gx BROWSER "/usr/bin/zen-browser"
set -gx EDITOR "/usr/bin/nvim"
