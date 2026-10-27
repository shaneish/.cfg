function hp --description "Hop around the terminal"
    set output (sh -c "bhop $argv")
    if not string match -q "*|*" $output
        echo $output
    else
        set cmds (string split "|" $output)
        cd $cmds[1]
        sh -c "$cmds[2]"
        if type -q "wezterm"
            if set -q TERM_PROGRAM; and test $TERM_PROGRAM = "WezTerm"
                if test "$cmds[1]" != "."
                    # NOTE: gotta dump the errors below, for some reason Wezzie Terminazzi freaks out with this error on linux (cachyos):
                    #    "config::config > Color scheme in `/home/shane/.config/wezterm/colors/wezterm.toml` failed to load: No such file or directory (os error 2)" 
                    # not seeing this on my macbook -- just cachyos.  no idea about windows because windows is ultra-omega-epi-gay (and not the fun, cool type of gay where other men put your weenie in their mouth) and I use windows solely for gaming / media consumption.
                    wezterm cli set-tab-title "$argv[1]" 2>/dev/null
                end
            end
        end
    end
end
