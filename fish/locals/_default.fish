set -Ux CONFIG_DIRECTORY $HOME/.config
set -Ux CFG_DIRECTORY $HOME/.config/.cfg
set -Ux SCRIPTS_DIRECTORY $HOME/.config/scripts
set -Ux NVIM_DIRECTORY $CONFIG_DIRECTORY/nvim

fish_add_path -U $HOME/.local/bin
fish_add_path -U $HOME/.cargo/bin
fish_add_path -U $HOME/.modular/bin
fish_add_path -U $HOME/.config/scripts
fish_add_path -U $HOME/go/bin

fish_config theme choose theme
