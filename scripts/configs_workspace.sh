#!/usr/bin/env bash
# this script creates/opens a wezterm workspace with default tabs for environment configuration (e.g., nvim, fish, wezterm, etc)

function set_var_if_unset() {
    local var_name="$1"
    local default_value="$2"
    if [ -z "${!var_name}" ]; then
        export "$var_name"="$default_value"
    fi
}

set_var_if_unset WORKSPACE_DIR "$HOME/.config"
set_var_if_unset SHELL "fish"
set_var_if_unset EDITOR "nvim"
WORKSPACE_NAME="configs"

wezterm cli rename-workspace "$WORKSPACE_NAME"

# opens default terminal tab
root_pane_id=$(wezterm cli spawn --cwd "$WORKSPACE_DIR" -- "$SHELL")
wezterm cli set-tab-title "cmd" --pane-id "$root_pane_id"

# open neovim tab
nvim_pane_id=$(wezterm cli spawn --cwd "$WORKSPACE_DIR/nvim" -- "$EDITOR" init.vim .vimrc lua/load-all.lua)
wezterm cli set-tab-title "nvim" --pane-id "$nvim_pane_id"

# open fish tab
fish_pane_id=$(wezterm cli spawn --cwd "$WORKSPACE_DIR/fish" -- "$EDITOR" config.fish git.fish databricks.fish)
wezterm cli set-tab-title "fish" --pane-id "$fish_pane_id"

# open wezterm tab
wezterm_pane_id=$(wezterm cli spawn --cwd "$WORKSPACE_DIR/wezterm" -- "$EDITOR" wezterm.lua)
wezterm cli set-tab-title "wezterm" --pane-id "$wezterm_pane_id"

wezterm cli kill-pane
