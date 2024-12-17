function fz -d "default fuzzy finder based on current system"
    if type -q "sk"
        sk --bind 'ctrl-l:toggle+out,ctrl-h:toggle+in,ctrl-space:toggle' $argv
    else if type -q "fzf"
        fzf --bind 'ctrl-l:toggle+out,ctrl-h:toggle+in,ctrl-space:toggle' $argv
    end
end
