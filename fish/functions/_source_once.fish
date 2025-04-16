function _source_once
    set -Ux FISH_CONFIG_DIRECTORY (dirname (dirname (status --current-filename)))
    fish_vi_key_bindings
    set -Ux fish_cursor_default block
    set -Ux fish_cursor_insert line blink
    set -Ux fish_cursor_replace_one underscore blink
    set -Ux fish_cursor_replace underscore blink
    set -Ux fish_cursor_external line blink
    set -Ux fish_cursor_visual block blink
    set -Ux fish_vi_force_cursor line blink
    set -Ux CONFIG_DIRECTORY $HOME/.config
    set -Ux CFG_DIRECTORY $HOME/.config/.cfg
    set -Ux SCRIPTS_DIRECTORY $HOME/.config/scripts
    set -Ux NVIM_DIRECTORY $CONFIG_DIRECTORY/nvim
    set -Ux PYTHON_VENV_DIR $HOME/.local/venvs
    set -Ux CLI_NOTES $HOME/.config/notes/cmd_examples.txt
    set -Ux EDITOR nvim
    set -U fish_user_paths
    fish_add_path -U $HOME/.local/bin
    fish_add_path -U $HOME/.cargo/bin
    fish_add_path -U $HOME/.modular/bin
    fish_add_path -U $HOME/.config/scripts
    fish_add_path -U $HOME/.go/bin
    fish_add_path -U $HOME/go/bin
    pyv
    change_greeting small
end
