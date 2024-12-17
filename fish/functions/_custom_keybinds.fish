function _custom_keybinds -d "select and copy from a previously submitted command"

    function _copy_previous_command
        set out (history | fz)
        switch (uname)
            case Darwin
                echo $out | sd '\s+$' '' | pbcopy
            case *
                echo $out | sd '\s+$' '' | xclip -sel copy
        end
    end

    function _expand_dot_to_parent_directory_path -d 'expand ... to ../..'

        # Get command line, up to cursor
        set -l cmd (commandline --cut-at-cursor)

        # Match last line
        switch $cmd[-1]

            # If the command line is just two dots, we want to expand
            case '..'
                commandline --insert '/..'

            # If the command line starts with 'cd' and ends with two dots, we want to expand
            case '?? *..'
                commandline --insert '/..'

            # If the command line starts and ends with two dots, we want to expand
            case '..*..'
                commandline --insert '/..'

            # In all other cases, just insert a dot
            case '*'
                commandline --insert '.'
        end
    end

    function _open_yazi
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
    end

    function _fuzzy_grep_and_edit
        set -l loc (commandline --cut-at-cursor)
        sk --ansi -i -c 'rg -i --color=always --line-number "{}"' | awk -F':' '{print $1} {print "-c +" $2}' | xargs nvim
    end

    bind -M insert \cs _fuzzy_grep_and_edit
    bind -M insert \ch _copy_previous_command
    bind -M insert \cf _open_yazi
    bind -M insert . _expand_dot_to_parent_directory_path
end

