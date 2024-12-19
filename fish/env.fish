set -Ux GIT_ATOMS "refname" "objecttype" "objectsize" "objectname" "deltabase" "tree" "parent" "numparent" "object" "type" "tag" "author" "authorname" "authoremail" "authordate" "committer" "committername" "committeremail" "committerdate" "tagger" "taggername" "taggeremail" "taggerdate" "creator" "creatordate" "describe" "subject" "body" "trailers" "contents" "signature" "raw" "upstream" "push" "symref" "flag" "HEAD" "color" "worktreepath" "align" "end" "if" "then" "else" "rest" "ahead-behind"

alias ll="eza"
alias cls="clear; fish"

abbr -a dx databricks
if type -q "fselect"
    abbr -a fs fselect
end

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

alias opn="fd '' . | fz -m | xargs nvim"
if type -q "bhop"
    alias _hp_fz_fixed="bhop __bhop_list__ | fnk filter -f 'f -> \":\" not in f' | fz -m | fnk map -f 'f -> f.split()[-1]' | xargs"
    alias _hp_fz="bhop __bhop_list__ | rg '\->' | fz -m | awk -F'->' '{print $2}' | xargs"
    alias hg="cd (_hp_fz_fixed)"
    alias ho="_hp_fz_fixed $EDITOR"
end
alias lh="history | nl | awk -F'\t' '{print $2}' | fz"

set -gx CONFIG_DIRECTORY $HOME/.config
set -gx SCRIPTS_DIRECTORY $HOME/.config/scripts
set -gx NVIM_DIRECTORY $CONFIG_DIRECTORY/nvim
set -gx NVIM_PYENV_ACTIVATE (fd "activate.fish" $NVIM_DIRECTORY -t f | head -n 1)
set -gx STARSHIP_SWITCHER (fd "aesthetic_switcher" $SCRIPTS_DIRECTORY -t f | head -n 1)
alias prompt_switch="$STARSHIP_SWITCHER"
alias nvm="$NVIM_PYENV_ACTIVATE; nvim"
set python_venv_dir python-venvs pyenvs pyvenv
set python_venv_priority fast-default default fast venv .venv
set leave_loop 0
for d in $python_venv_dir
    for p in $python_venv_priority
        if test -d $CONFIG_DIRECTORY/$d/$p
            set leave_loop 1
            alias pyv="source $CONFIG_DIRECTORY/$d/$p/bin/activate.fish"
            alias py="$CONFIG_DIRECTORY/$d/$p/bin/python"
            break
        end
    end
    if test $leave_loop -eq 1
        break
    end
end

function __alternate_prompt
    prompt_switch 0
    commandline -f repaint
end

bind -M insert \cp __alternate_prompt

switch (uname)
    case Darwin
        alias clip="pbcopy"
    case *
        alias clip="xclip -sel clip"
end
