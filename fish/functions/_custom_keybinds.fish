function _custom_keybinds -d "select and copy from a previously submitted command"
    set -gx STARSHIP_SWITCHER (fd "aesthetic_switcher" $SCRIPTS_DIRECTORY -t f --follow | head -n 1)

    function _copy_previous_command
        set out (history | fz)
        if test (uname) = "Darwin"
            echo $out | sd '\s+$' '' | pbcopy
        else if test (uname) = "Linux"
            echo $out | sd '\s+$' '' | xclip -sel copy
        end
    end

    function _expand_dot_to_parent_directory_path -d 'expand ... to ../..'
        set -l cmd (commandline --cut-at-cursor)
        switch $cmd[-1]
            case '..'
                commandline --insert '/..'
            case '?? *..'
                commandline --insert '/..'
            case '..*..'
                commandline --insert '/..'
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
        commandline -f repaint
    end

    function _fuzzy_grep_and_edit
        set -l loc (commandline --cut-at-cursor)
        sk --ansi -i -c 'rg -i --color=always --line-number "{}"' | awk -F':' '{print $1} {print "-c +" $2}' | xargs nvim
    end

    function _hp
        set -l cmd (commandline --cut-at-cursor)
        hp $cmd
        commandline -r ''
        commandline -f repaint
    end

    function __alternate_prompt
        $STARSHIP_SWITCHER 0
        commandline -f repaint
    end

    function _hpfuzzy
        set d (hp ls | fz | string split ' -> ')
        cd $d[2]
        commandline -f repaint
    end

    bind -M insert \cp __alternate_prompt
    bind -M insert \cs _fuzzy_grep_and_edit
    bind -M insert \cu _copy_previous_command
    bind -M insert \cf _open_yazi
    bind -M insert . _expand_dot_to_parent_directory_path
    bind -M insert \cd _hp
    bind -M visual y 'fish_clipboard_copy; commandline -f end-selection repaint-mode'
    bind -M normal yy fish_clipboard_copy
    bind -M insert \ch 'history | fz | string trim -r | clip'
    bind -M insert \cj _hpfuzzy
end

