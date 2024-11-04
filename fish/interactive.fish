source "$FISH_CONFIG_DIR/greeting.fish"

set -gx CONFIG_DIRECTORY $HOME/.config
set -gx SCRIPTS_DIRECTORY $HOME/.config/scripts
set -gx NVIM_DIRECTORY $CONFIG_DIRECTORY/nvim
set -gx NVIM_PYENV_ACTIVATE (fd "activate.fish" $NVIM_DIRECTORY -t f | head -n 1)
set -gx STARSHIP_SWITCHER (fd "aesthetic_switcher" $SCRIPTS_DIRECTORY -t f | head -n 1)

alias p="$STARSHIP_SWITCHER 0"
alias nvm="$NVIM_PYENV_ACTIVATE; nvim"

set python_venv_dir python-venvs pyenvs pyvenv
set python_venv_priority fast-default default fast venv .venv

for d in $python_venv_dir
    for p in $python_venv_priority
        if test -d $CONFIG_DIRECTORY/$d/$p
            alias pyv="source $CONFIG_DIRECTORY/$d/$p/bin/activate.fish"
            alias py="$CONFIG_DIRECTORY/$d/$p/bin/python"
            break
        end
    end
end

fish_vi_key_bindings
if type -q "starship"
    starship init fish | source
end
fish_config theme choose Batdog
if type -q pyv
    pyv
end
set fish_cursor_default block
set fish_cursor_insert line blink
set fish_cursor_replace_one underscore blink
set fish_cursor_replace underscore blink
set fish_cursor_external line blink
set fish_cursor_visual block blink
set -gx fish_vi_force_cursor line blink

if type -q sk
    source $FISH_CONFIG_DIR/skim-keybindings.fish
else if type -q fzf
    fzf --fish | source
end
