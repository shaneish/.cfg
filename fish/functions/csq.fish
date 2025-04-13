function csq -d "run sql queries on csv data"
    sqlite3 "" ".mode csv" ".import $argv[1] _" "$argv[2]"
end
