#!/usr/bin/env bash
# this script creates/opens a wezterm workspace for finops asset bundle development

function set_var_if_unset() {
    local var_name="$1"
    local default_value="$2"
    if [ -z "${!var_name}" ]; then
        export "$var_name"="$default_value"
    fi
}

WORKSPACE_NAME="finops_asset_bundle"
set_var_if_unset SHELL "fish"
set_var_if_unset EDITOR "nvim"
FINOPS_DAB_DIR=$(bhop finops_dab | sd '\|\s*' '')
set_var_if_unset WORKSPACE_DIR "$FINOPS_DAB_DIR"

echo "Creating workspace $WORKSPACE_NAME @ $WORKSPACE_DIR"
wezterm cli rename-workspace "$WORKSPACE_NAME"
cd "$WORKSPACE_DIR"

# opens default terminal tab
root_pane_id=$(wezterm cli spawn --cwd "$WORKSPACE_DIR" -- "$SHELL")
echo "root pane id: $root_pane_id"
wezterm cli set-tab-title "cmd" --pane-id "$root_pane_id"

# open yaml config tab
yml_files=$(fd --glob '*.yml' "$WORKSPACE_DIR" | xargs)
yml_pane_id=$(wezterm cli spawn --cwd "$WORKSPACE_DIR" -- $EDITOR $yml_files)
echo "yaml pane id: $yml_pane_id"
wezterm cli set-tab-title "configs" --pane-id "$yml_pane_id"

# open src tab
src_files=$(fd -E __init__.py --glob '*.py' "$WORKSPACE_DIR/src" --max-depth 1 | xargs)
src_pane_id=$(wezterm cli spawn --cwd "$WORKSPACE_DIR/src" -- $EDITOR $src_files)
echo "src pane id: $src_pane_id"
wezterm cli set-tab-title "src" --pane-id "$src_pane_id"

# open lib tab
lib_files=$(fd -E __init__.py --glob '*.py' "$WORKSPACE_DIR/src/ap_databricks" | xargs)
lib_pane_id=$(wezterm cli spawn --cwd "$WORKSPACE_DIR/src/ap_databricks" -- $EDITOR $lib_files)
echo "lib pane id: $lib_pane_id"
wezterm cli set-tab-title "lib" --pane-id "$lib_pane_id"

# open py scripts tab
py_script_files=$(fd -E __init__.py --glob '*.py' "$WORKSPACE_DIR/scripts" --max-depth 1 | xargs)
py_scripts_pane_id=$(wezterm cli spawn --cwd "$WORKSPACE_DIR/scripts" -- $EDITOR $py_script_files)
echo "py scripts pane id: $py_scripts_pane_id"
wezterm cli set-tab-title "py scripts" --pane-id "$py_scripts_pane_id"

# open py scripts tab
scripts_files=$(fd --glob '*.sh' "$WORKSPACE_DIR" | xargs)
scripts_pane_id=$(wezterm cli spawn --cwd "$WORKSPACE_DIR" -- $EDITOR $scripts_files)
echo "scripts pane id: $scripts_pane_id"
wezterm cli set-tab-title "scripts" --pane-id "$scripts_pane_id"

wezterm cli activate-pane --pane-id "$root_pane_id"
wezterm cli kill-pane
