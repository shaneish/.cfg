function pynvim --description "nvim but activate python venv first"
    source $HOME/.config/nvim/venv/bin/activate.fish
    nvim $argv
end
