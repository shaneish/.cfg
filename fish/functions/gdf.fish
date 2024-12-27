function gdf --description "show the git diff, but pretty"
    if type -q "dunk"
        git diff $argv | dunk
    else if type -q "delta"
        git diff $argv | delta
    else
        git diff
    end
end
