_source_local
source $FISH_CONFIG_DIRECTORY/env.fish
source $FISH_CONFIG_DIRECTORY/functions.fish

if status is-interactive
    if type -q "starship"
        starship init fish | source
    end
    source $FISH_CONFIG_DIRECTORY/interactive.fish
end
