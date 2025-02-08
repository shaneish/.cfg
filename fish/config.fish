if type -q brew
    eval "$(brew shellenv)"
end

set -l certs_file (dirname (status --current-filename))/certs.fish
if test -e $certs_file
    source $certs_file
end

if status is-interactive
    set _MACHINE_IDENTIFIER (uname -a | awk '{print $1"-"$2"-"$3}')
    if not set -q MACHINE_IDENTIFIER; or not test $_MACHINE_IDENTIFIER = "$MACHINE_IDENTIFIER"
        _source_once
        set -Ux MACHINE_IDENTIFIER $_MACHINE_IDENTIFIER
    end

    if type -q "starship"
        starship init fish | source
    end

    fish_bash_keybinds
    _custom_keybinds

    if type -q fzf
        fzf --fish | source
    else if type -q sk
        skim_key_bindings
    end

    alias lh="history | fz | clip"
    alias ll="eza"
    alias cls="clear; fish"
    alias opn="fd '' . | fz -m | xargs $EDITOR"
    alias cat="bat"
    abbr -a fs fselect
    if type -q "bhop"
        alias _hp_fz_fixed="bhop __bhop_list__ | fnk filter -f 'f -> \":\" not in f' | fz -m | fnk map -f 'f -> f.split()[-1]' | xargs"
        alias _hp_fz="bhop __bhop_list__ | rg '\->' | fz -m | awk -F'->' '{print $2}' | xargs"
        alias hg="cd (_hp_fz_fixed)"
        alias ho="_hp_fz_fixed $EDITOR"
    end
    if type -q "bat"
        alias cat="bat"
    end
    abbr -a dx databricks
    abbr -a rp rust-parallel

    # all the git ones
    alias git="git --no-pager"
    alias gdo="git diff origin/(git branch --show-current)"
    alias gpob="git push origin (git branch --show-current)"
    alias gpub="git pull origin (git branch --show-current)"
    abbr -a gl git log
    abbr -a gap git add -p
    abbr -a gau git add -u
    abbr -a gaa git add .
    abbr -a ga git add
    abbr -a gcm git commit -m
    abbr -a gb git branch --show-current
    abbr -a gbll git branch -l
    abbr -a gbl git branch -a
    abbr -a gm git merge
    abbr -a gpo git push origin
    abbr -a gpu git pull origin
    abbr -a gco git checkout
    abbr -a gs git status
    abbr -a gcb git checkout -b
    abbr -a gwt git worktree
    abbr -a gwtl git worktree list
    abbr -a gwta git worktree add
    abbr -a gwtr git worktree remove
    abbr -a gd git diff
end

