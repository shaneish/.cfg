function _custom_keybinds -d "it is what it says it is"
    set -gx STARSHIP_SWITCHER (fd "aesthetic_switcher" $SCRIPTS_DIRECTORY -t f --follow | head -n 1)

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
        fz --ansi -i -c 'rg -i --color=always --line-number "{}"' | awk -F':' '{print $1} {print "-c +" $2}' | xargs nvim
    end

    function _hp
        set -l cmd (commandline --cut-at-cursor)
        hp $cmd
        commandline -r ''
        commandline -f repaint
    end

    function __alternate_prompt
        $STARSHIP_SWITCHER 0
        commandline -r ''
        commandline -f repaint
    end

    function _hpfuzzy
        set d (hp ls | fz | string split ' -> ')
        if string length --quiet $d[2]
            cd $d[2]
            commandline -f repaint
        end
    end

    function _wez_workspace_hpfuzzy
        set d (hp ls | fz | string split ' -> ')
        if string length --quiet $d[2]
            cd (string trim $d[2])
            wezterm cli rename-workspace (string trim $d[1])
            commandline -f repaint
        end
    end

    function _fg
        fg 2&> /dev/null
    end

    function _fg_select
        set selected $(jobs | fz | awk '{print $1}')
        fg %$selected 2&> /dev/null
    end

    function __run_last_command
        eval $history[1]
    end

    function __select_from_last
        # Re-run the last command and pipe it to fzf
        set -l chosen_line (eval $history[1] | fzf -m --height 20%)

        if test -n "$chosen_line"
            # Inject the text into your current command buffer
            commandline -i (string escape -- $chosen_line)
        end
    end

    abbr --add !! --position anywhere --function __run_last_command
    bind -M insert \cf __select_from_last
    bind -M insert \cp __alternate_prompt
    bind -M insert \cs _fuzzy_grep_and_edit
    bind -M insert \cy _open_yazi
    bind -M insert . _expand_dot_to_parent_directory_path
    bind -M visual y 'fish_clipboard_copy; commandline -f end-selection repaint-mode'
    bind -M normal yy fish_clipboard_copy
    bind -M insert \ch 'history | fz | string trim -r | clip'
    bind -M insert \cg _hpfuzzy
    bind -M insert \cw _wez_workspace_hpfuzzy
    bind -M insert \cb _fg
    bind -M insert \cj _fg_select
    bind -M insert \cl forward-word

    # function bind_bang
    #     switch (commandline -t)[-1]
    #         case "!"
    #             commandline -t -- $history[1]
    #             commandline -f repaint
    #         case "*"
    #             commandline -i !
    #     end
    # end
    #
    # function bind_dollar
    #     switch (commandline -t)[-1]
    #         case "!"
    #             commandline -f backward-delete-char history-token-search-backward
    #         case "*"
    #             commandline -i '$'
    #     end
    # end
    #
    # bind -M insert ! bind_bang
    # bind -M insert '$' bind_dollar

end

