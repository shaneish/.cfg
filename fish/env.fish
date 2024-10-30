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
alias gh="git rev-parse --abbrev-ref origin/HEAD"
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
if type -q "fzf"
    if type -q "bhop"
        alias _hp_fzf_fixed="bhop __bhop_list__ | fnk filter -f 'f -> \":\" not in f' | fzf -m | fnk map -f 'f -> f.split()[-1]' | xargs"
        alias _hp_fzf="bhop __bhop_list__ | rg '\->' | fzf -m | awk -F'->' '{print $2}' | xargs"
        alias hg="cd (_hp_fzf_fixed)"
        alias ho="_hp_fzf_fixed $EDITOR"
    end
    alias lh="history | nl | awk -F'\t' '{print $2}' | fzf"
end

if type -q "fselect"
    alias fs="fselect"
end

set -gx CONFIG_DIRECTORY $HOME/.config
set -gx SCRIPTS_DIRECTORY $HOME/.config/scripts
set -gx NVIM_DIRECTORY $CONFIG_DIRECTORY/nvim
set -gx NVIM_PYENV_ACTIVATE (fd "activate.fish" $NVIM_DIRECTORY -t f | head -n 1)
set -gx STARSHIP_SWITCHER (fd "aesthetic_switcher" $SCRIPTS_DIRECTORY -t f | head -n 1)
alias .="$STARSHIP_SWITCHER 0"
alias nvm="$NVIM_PYENV_ACTIVATE; nvim"

function handle_empty_line
    read -l line
    if test -z "$line"
        $STARSHIP_SWITCHER 0
    end
end

bind \r handle_empty_line

