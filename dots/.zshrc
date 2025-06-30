export KEYTIMEOUT=1

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fzf=fzf --bind 'ctrl-l:toggle+out,ctrl-h:toggle+in,ctrl-space:toggle'
alias git='git --no-pager'
alias gpob='git push origin (git branch --show-current)'
alias gpub='git pull origin (git branch --show-current)'
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

bindkey -v

if command -v fzf 2>&1 >/dev/null; then
    eval "$(fzf --zsh)"
fi

# Change cursor with support for inside/outside tmux
function _set_cursor() {
    if [[ $TMUX = '' ]]; then
        echo -ne $1
    else
        echo -ne "\ePtmux;\e\e$1\e\\"
    fi
}

function _set_block_cursor() { _set_cursor '\e[2 q' }
function _set_beam_cursor() { _set_cursor '\e[5 q' }

function zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
        _set_block_cursor
    else
        _set_beam_cursor
    fi
}
zle -N zle-keymap-select
