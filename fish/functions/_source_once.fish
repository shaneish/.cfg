function _source_once
    set -Ux FISH_CONFIG_DIRECTORY (dirname (dirname (status --current-filename)))
    source_dots
    for f in (_get_local_fish_configs)
        set potential_file "$FISH_CONFIG_DIRECTORY/locals/_$f"
        if test -e $potential_file
            source $potential_file
        end
    end
end
