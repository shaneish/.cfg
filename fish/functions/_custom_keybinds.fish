function _custom_keybinds -d "select and copy from a previously submitted command"

    function copy-previous-command
        set out (history | fuzz)
        switch (uname)
            case Darwin
                echo $out | sd '\s+$' '' | pbcopy
            case *
                echo $out | sd '\s+$' '' | xclip -sel copy
        end
    end

    function expand-dot-to-parent-directory-path -d 'expand ... to ../..'

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

    function open-yazi
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
    end

    bind -M insert \ch copy-previous-command
    bind -M insert \cf open-yazi
    bind -M insert . expand-dot-to-parent-directory-path
end

