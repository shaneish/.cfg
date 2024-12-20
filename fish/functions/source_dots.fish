function source_dots
    set -f json_file ~/.dots
    if set -q argv[1]
        set -f json_file $argv[1]
    end
    if test -e $json_file
        for l in (cat $json_file)
            set it (string split " " (cat ~/.dots))
            set -Ux $it[1] $it[2]
        end
    end
end
