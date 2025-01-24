# source "$FISH_CONFIG_DIRECTORY/greeting.fish"

if type -q pyv
    pyv
    _activate_local_venv
end
fish_bash_keybinds

if type -q sk
    skim_key_bindings
else if type -q fzf
    fzf --fish | source
end

_custom_keybinds
