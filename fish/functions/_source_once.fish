function _source_once
    set -Ux FISH_CONFIG_DIRECTORY (dirname (dirname (status --current-filename)))
    set -Ux fish_cursor_default block
    set -Ux fish_cursor_insert line blink
    set -Ux fish_cursor_replace_one underscore blink
    set -Ux fish_cursor_replace underscore blink
    set -Ux fish_cursor_external line blink
    set -Ux fish_cursor_visual block blink
    set -Ux fish_vi_force_cursor line blink
    set -Ux CONFIG_DIRECTORY (dirname $FISH_CONFIG_DIRECTORY)
    set -Ux CFG_DIRECTORY $CONFIG_DIRECTORY/.cfg
    set -Ux SCRIPTS_DIRECTORY $CONFIG_DIRECTORY/scripts
    set -Ux NVIM_DIRECTORY $CONFIG_DIRECTORY/nvim
    set -Ux PYTHON_VENV_DIR $HOME/.local/venvs
    set -Ux CLI_NOTES $CONFIG_DIRECTORY/notes/cmd_examples.txt

    add_env_var_maybe EDITOR nvim vim vi
    add_env_var_maybe SHELL fish zsh dash bash powershell sh

    set -U fish_user_paths
    add_to_path_maybe $CFG_DIRECTORY/bin
    add_to_path_maybe $HOME/.local/bin
    add_to_path_maybe $HOME/.cargo/bin
    add_to_path_maybe $HOME/.modular/bin
    add_to_path_maybe $HOME/.config/scripts
    add_to_path_maybe $HOME/.go/bin
    add_to_path_maybe $HOME/go/bin

    pyv
    change_greeting small
    fish_vi_key_bindings
end
