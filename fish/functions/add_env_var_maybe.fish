function add_env_var_maybe # -d "Set the value of an env var the first available command provided.  ie: add_env_var_maybe EDITOR nvim vim vi"
    for v in $argv[2..]
        if type -q "$v"
            set -Ux "$argv[1]" "$v"
            break
        end
    end
end
