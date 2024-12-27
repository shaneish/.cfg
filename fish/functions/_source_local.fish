function _source_local
    for f in (_get_local_fish_configs)
        set -l potential_file (dirname (dirname (status --current-filename)))/locals/$f
        if test -e $potential_file
            source $potential_file
        end
    end
    set MACHINE_IDENTIFIER (uname -a | awk '{print $1"-"$2"-"$3}')
    if not set -q _MACHINE_IDENTIFIER; or not test $_MACHINE_IDENTIFIER = $MACHINE_IDENTIFIER
        _source_once
        set -Ux _MACHINE_IDENTIFIER $MACHINE_IDENTIFIER
    end
end
