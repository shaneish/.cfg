source "$FISH_CONFIG_DIRECTORY/greeting.fish"

if type -q "starship"
    starship init fish | source
end
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
fish_bash_keybinds

if type -q sk
    skim_key_bindings
else if type -q fzf
    fzf --fish | source
end

_custom_keybinds
