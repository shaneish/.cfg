set -gx DEFAULT_PY_VENV_DIR $HOME/.config/python-venvs
set -gx DEFAULT_PY_VENV $DEFAULT_PY_VENV_DIR/fast-venv
alias py="python"
alias ipy="ipython"
alias mvim="nvim -u $HOME/.config/nvim/minit.vim"
alias pyv="source $DEFAULT_PY_VENV/bin/activate.fish"

alias snvm="sudo nvm"
alias boxes="flatpak run org.gnome.Boxes"
alias spotify="flatpak run com.spotify.Client"

set -gx BROWSER "/usr/bin/zen-browser"
set -gx EDITOR "/usr/bin/nvim"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

fish_add_path /home/shane/.modular/bin
