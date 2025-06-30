# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias git='git --no-pager'
alias gpob="git push origin (git branch --show-current)"
alias gpub="git pull origin (git branch --show-current)"
alias gap='git add -p'
alias gau='git add -u'
alias gaa='git add .'
alias ga='git add'
alias gcm='git commit -m'
alias gb='git branch --show-current'
alias gm='git merge'
alias gpo='git push origin'
alias gpu='git pull origin'
alias gco='git checkout'
alias gs='git status'
alias gcb='git checkout -b'
alias gwt='git worktree'
alias gd='git diff'

alias EDITOR='vim'

export PATH="/usr/local/sbin:$PATH:$HOME/.cargo/bin:$HOME/.fzf/bin:$HOME/.local/bin"

PS1='\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]$\[\033[00m\] '

set -o vi

if command -v fzf 2>&1 >/dev/null; then
    eval "$(fzf --bash)"
fi

set vi-cmd-mode-string "\1\e[2 q\2"
set vi-ins-mode-string "\1\e[5 q\2"
