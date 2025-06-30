function gcp --description "git diff; git add argv[2]; git commit -m arg[1]; git push"
    set -f add_flag "-i"
    if set -q argv[2]
        set -f add_flag $argv[2]
    end
    gdf
    git add $add_flag
    git commit -m "$argv[1]"
    git push origin
end
