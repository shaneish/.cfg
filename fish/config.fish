_source_local
source $FISH_CONFIG_DIRECTORY/env.fish
source $FISH_CONFIG_DIRECTORY/functions.fish

if status is-interactive
    source $FISH_CONFIG_DIRECTORY/interactive.fish
end
