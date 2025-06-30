function _source_local
    set _MACHINE_IDENTIFIER "$(_machine_id)"
    if not set -q MACHINE_IDENTIFIER; or not test $_MACHINE_IDENTIFIER = "$MACHINE_IDENTIFIER"
        _source_once
        set -Ux MACHINE_IDENTIFIER $_MACHINE_IDENTIFIER
    end
    if test -e "$FISH_CONFIG_DIRECTORY/local/$_MACHINE_IDENTIFIER"
        "$FISH_CONFIG_DIRECTORY/$_MACHINE_IDENTIFIER"
    end
end
