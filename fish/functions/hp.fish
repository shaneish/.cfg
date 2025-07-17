function hp --description "Hop around the terminal"
    set output (sh -c "bhop $argv")
    if not string match -q "*|*" $output
        echo $output
    else
        set cmds (string split "|" $output)
        cd $cmds[1]
        sh -c "$cmds[2]"
        if type -q "wezterm"
            wezterm cli set-tab-title "$argv[1]"
        end
    end
end
