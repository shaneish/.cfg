function csq -d "run sql queries on csv data"
    set separator ,
    if test -n "$argv[3]"
        set separator $argv[3]
    end
    sqlite3 "" ".headers on" ".separator $separator" ".mode csv" ".import $argv[1] _" "$argv[2]"
end
