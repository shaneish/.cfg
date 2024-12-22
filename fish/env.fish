_set_python_venv
_set_fuzzy_finder
set -Ux GIT_ATOMS "refname" "objecttype" "objectsize" "objectname" "deltabase" "tree" "parent" "numparent" "object" "type" "tag" "author" "authorname" "authoremail" "authordate" "committer" "committername" "committeremail" "committerdate" "tagger" "taggername" "taggeremail" "taggerdate" "creator" "creatordate" "describe" "subject" "body" "trailers" "contents" "signature" "raw" "upstream" "push" "symref" "flag" "HEAD" "color" "worktreepath" "align" "end" "if" "then" "else" "rest" "ahead-behind"

alias lh="history | fz | clip"
alias ll="eza"
alias cat="bat"
alias cls="clear; fish"
alias clip="xclip -sel clip"
alias opn="fd '' . | fz -m | xargs nvim"
alias mvim="nvim -u $HOME/.config/nvim/minit.vim"
alias cat="bat"
switch (uname)
    case Darwin
        alias clip="pbcopy"
end
if type -q "fselect"
    abbr -a fs fselect
end
if type -q "bhop"
    alias _hp_fz_fixed="bhop __bhop_list__ | fnk filter -f 'f -> \":\" not in f' | fz -m | fnk map -f 'f -> f.split()[-1]' | xargs"
    alias _hp_fz="bhop __bhop_list__ | rg '\->' | fz -m | awk -F'->' '{print $2}' | xargs"
    alias hg="cd (_hp_fz_fixed)"
    alias ho="_hp_fz_fixed $EDITOR"
end
abbr -a dx databricks
abbr -a ai shelldon

# all the git ones
alias git="git --no-pager"
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
abbr -a gpob git push origin (git branch --show-current)
abbr -a gpub git pull origin (git branch --show-current)
abbr -a gwt git worktree
abbr -a gwtl git worktree list
abbr -a gwta git worktree add
abbr -a gwtr git worktree remove
abbr -a gd git diff
abbr -a gdo git diff origin/(git branch --show-current)
