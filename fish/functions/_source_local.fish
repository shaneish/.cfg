function _source_local
    for f in (_get_local_fish_configs)
        set -l potential_file (dirname (dirname (status --current-filename)))/locals/$f
        if test -e $potential_file
            source $potential_file
        end
    end
    if not set -q _MACHINE_IDENTIFIER
        _source_once
        set -gx _MACHINE_IDENTIFIER (uname -a | awk '{print $1"-"$2"-"$3}')
    end
end
