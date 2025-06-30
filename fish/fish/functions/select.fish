function select -d "simplify running SQLish statements from the commandline over CSVs and other file formats"
    # TODO: include logic to parse whether file is csv, psv, tsv, etc and update separator accordingly
    set separator ','
    set source_triggers from FROM From
    set arg_len (count $argv)
    for i in (seq $arg_len)
        if contains $argv[$i] $source_triggers
            set -f next_i (sqlite3 "" "select $i + 1")
            if test $next_i -le $arg_len
                set -f source $argv[$next_i]
                break
            end
        end
    end
    set -f query "select"
    for arg in $argv
        if test "$arg" = "$source"
            set -a query "__CSV__"
        else
            set -a query "$arg"
        end
    end
    if test "$source" = "_"
        set -f source (fd '*.csv' --glob | fz)
    end
    sqlite3 "" ".headers on" ".separator $separator" ".mode csv" ".import $source __CSV__" "$query"
end
