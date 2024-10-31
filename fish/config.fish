set -gx FISH_CONFIG_DIR "$HOME/.config/fish"
for f in (string split " " $fish_user_paths)
    if test -e $f
        set -l parent_dir (string split "/" $f --right --m=1)
        set -l fish_config (string join "/" $parent_dir[1] "config.fish")
        if test -e $fish_config
            set -gx FISH_CONFIG_DIR $parent_dir[1]
            break
        end
    end
end

source "$FISH_CONFIG_DIR/locals/default.local.fish"
if test -e "$FISH_CONFIG_DIR/locals/$(id -un).local.fish"
    source "$FISH_CONFIG_DIR/locals/$(id -un).local.fish"
end
source "$FISH_CONFIG_DIR/env.fish"
source "$FISH_CONFIG_DIR/functions.fish"

set paths $HOME/.local/bin $HOME/.cargo/bin $HOME/.modular/bin $HOME/.config/scripts $HOME/go/bin
for p in $paths
    if test -d $p; and not contains $p $PATH
        fish_add_path $p
    end
end

fish_add_path $HOME/.modular/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.local/bin

if status is-interactive
    source "$FISH_CONFIG_DIR/greeting.fish"
    fish_vi_key_bindings
    if type -q "starship"
        starship init fish | source
    end
    fish_config theme choose Batdog
    # if not string match -q "" (which python)
    #     pyv
    # end
    set fish_cursor_default block
    set fish_cursor_insert line blink
    set fish_cursor_replace_one underscore blink
    set fish_cursor_replace underscore blink
    set fish_cursor_external line blink
    set fish_cursor_visual block blink
    set -gx fish_vi_force_cursor line blink
end

if not string match -q "" (which fzf)
    fzf --fish | source
end

