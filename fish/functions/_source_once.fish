function _source_once
    pyv
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
    set -Ux EDITOR "nvim"
    set -Ux SHELL "fish"
    set -Ux PYTHON_VENV_DIR $HOME/.local/python-venvs
    set -Ux CLI_NOTES $HOME/.config/notes/cmd_examples.txt
    change_greeting small
end
