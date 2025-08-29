function add_to_path_maybe -d "Add (and create if not exists) a directory to PATH variable if the the value in arg2 position is a valid command or if arg2 is empty.  ie: `add_to_path_maybe $HOME/.local/bin`, `add_to_path_maybe $HOME/.cargo/bin rust`"
    if type -q "$argv[2]"; or test -z "$argv[2]"
        if not test -e "$argv[1]"
            mkdir -p "$argv[1]"
        end
        fish_add_path -U "$argv[1]"
    end
end

