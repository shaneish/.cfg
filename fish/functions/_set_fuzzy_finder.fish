function _set_fuzzy_finder -d "default fuzzy finder based on current system"
    if type -q "sk"
        alias sk="sk --bind 'ctrl-l:toggle+out,ctrl-h:toggle+in,ctrl-space:toggle'"
        abbr -a fz sk
    else if type -q "fzf"
        alias fzf="fzf --bind 'ctrl-l:toggle+out,ctrl-h:toggle+in,ctrl-space:toggle'"
        abbr -a fz fzf
    end
end
