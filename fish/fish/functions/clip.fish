function clip --description "a single command to clip from clipboard on any operating system"
    switch (uname)
        case Linux
            if type -q "xclip"
                cat $argv | tr -d '\n' | xclip -selection clipboard
            else if type -q "xsel"
                cat $argv | tr -d '\n' | xsel --clipboard --input
            else if type -q "wl-copy"
                cat $argv | tr -d '\n' | wl-copy
            else
                echo "Unable to copy, unable to find xclip, xsel, or wl-copy: $argv"
            end
        case Darwin
            cat $argv | tr -d '\n' | pbcopy
        case '*'
            clip < $argv
    end
end
