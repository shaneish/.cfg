set -l git_atoms "refname" "objecttype" "objectsize" "objectname" "deltabase" "tree" "parent" "numparent" "object" "type" "tag" "author" "authorname" "authoremail" "authordate" "committer" "committername" "committeremail" "committerdate" "tagger" "taggername" "taggeremail" "taggerdate" "creator" "creatordate" "describe" "subject" "body" "trailers" "contents" "signature" "raw" "upstream" "push" "symref" "flag" "HEAD" "color" "worktreepath" "align" "end" "if" "then" "else" "rest" "ahead-behind"

alias ll="eza"
alias setclip="xclip -select c"
alias getclip="xclip -select c -o"
alias gap="git add -p"
alias gau="git add -u"
alias gaa="git add ."
alias ga="git add"
alias gc="git commit"
alias gcm="git commit -m"
alias gp="git push"
alias gb="git branch --show-current"
alias gpo="git push origin"
alias gpu="git pull origin"
alias gck="git checkout"
alias gs="git status"
alias gco="git checkout"
alias gcb="git checkout -b"
alias gpob="git push origin (git branch --show-current)"
alias gpub="git pull origin (git branch --show-current)"
alias gbh="git rev-parse --abbrev-ref HEAD"
alias gf="arrout 3 $git_atoms"
alias dx="databricks"
alias cat="bat --paging=never --decorations=never"
alias gwt="git worktree"
alias gwtl="git worktree list"
alias gwta="git worktree add"
alias gwtr="git worktree remove"
alias gd="git diff"
alias goh="git rev-parse --abbrev-ref origin/HEAD"
alias gmb="gh | sd '\w+/' ''"
alias cls="clear; fish"
if type -q "dunk"
    alias gdd="git diff | dunk"
    alias gdo="git diff origin/(git branch --show-current) | dunk"
    alias gdm="git diff (gmb) | dunk"
    alias gdom="git diff origin/HEAD | dunk"
else
    alias gdo="git diff origin/(git branch --show-current)"
    alias gdm="git diff (gmb)"
    alias gdom="git diff origin/HEAD"
end
if type -q "sk"
    alias sk="sk --bind 'ctrl-l:toggle+out,ctrl-h:toggle+in,ctrl-space:toggle'"
    alias fuzz="sk"
    alias skm="sk -m"
else if type -q "fzf"
    alias fzf="--bind 'ctrl-l:toggle+out,ctrl-h:toggle+in,ctrl-space:toggle'"
    alias fuzz="fzf"
    alias fzm="fzf -m"
end

alias opn="fd '' . | fuzz -m | xargs nvim"
if type -q "bhop"
    alias _hp_fuzz_fixed="bhop __bhop_list__ | fnk filter -f 'f -> \":\" not in f' | fuzz -m | fnk map -f 'f -> f.split()[-1]' | xargs"
    alias _hp_fuzz="bhop __bhop_list__ | rg '\->' | fuzz -m | awk -F'->' '{print $2}' | xargs"
    alias hg="cd (_hp_fuzz_fixed)"
    alias ho="_hp_fuzz_fixed $EDITOR"
end
alias lh="history | nl | awk -F'\t' '{print $2}' | fuzz"

if type -q "fselect"
    alias fs="fselect"
end

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
end

bind -M insert \cp __alternate_prompt

switch (uname)
    case Darwin
        alias clip="pbcopy"
    case *
        alias clip="xclip -sel clip"
end
