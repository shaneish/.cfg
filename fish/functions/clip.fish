function clip --description "a single command to clip to clipboard on any operating system"
    switch (uname)
        case Linux
            if type -q "wl-copy"
                wl-copy
            else if type -q "xclip"
                xclip -selection clipboard
            else if type -q "xsel"
                xsel --clipboard --input
            else
                echo "Unable to copy, unable to find xclip, xsel, or wl-copy: $argv"
            end
        case Darwin
            pbcopy
        case '*'
            clip
    end
end
