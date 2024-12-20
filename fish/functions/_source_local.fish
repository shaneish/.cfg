function _source_local
    for f in (_get_local_machine_id)
        set -l potential_file (dirname (dirname (status --current-filename)))/locals/$f
        if test -e $potential_file
            source $potential_file
        end
    end
end
