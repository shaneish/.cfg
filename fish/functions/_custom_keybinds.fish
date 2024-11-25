function _custom_keybinds -d "select and copy from a previously submitted command"
    function copy_previous_command
        set out (history | fuzz)
        switch (uname)
            case Darwin
                echo $out | sd '\s+$' '' | pbcopy
            case *
                echo $out | sd '\s+$' '' | xclip -sel copy
        end
    end

    bind -M insert \ch copy_previous_command
end

