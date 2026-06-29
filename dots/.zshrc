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

alias EDITOR='nvim'

export PATH="/usr/local/sbin:$PATH:$HOME/.cargo/bin:$HOME/.fzf/bin:$HOME/.local/bin"

bindkey -v

if command -v fzf 2>&1 >/dev/null; then
    eval "$(fzf --zsh)"
fi

function __clip() {
    local input

    if [ "$#" -gt 0 ]; then
        input="$(cat "$@")"
    else
        input="$(cat)"
    fi

    input="$(printf "%s" "$input" | tr -d '\n')"

    case "$(uname)" in
        Linux)
            if command -v wl-copy >/dev/null 2>&1; then
                printf "%s" "$input" | wl-copy
            elif command -v xclip >/dev/null 2>&1; then
                printf "%s" "$input" | xclip -selection clipboard
            elif command -v xsel >/dev/null 2>&1; then
                printf "%s" "$input" | xsel --clipboard --input
            else
                echo "Unable to copy: wl-copy, xclip, or xsel not found"
                return 1
            fi
            ;;
        Darwin)
            printf "%s" "$input" | pbcopy
            ;;
        *)
            printf "%s" "$input" | clip
            ;;
    esac
}

function __paste() {
    local output

    case "$(uname)" in
        Linux)
            if command -v wl-paste >/dev/null 2>&1; then
                output="$(wl-paste)"
            elif command -v xclip >/dev/null 2>&1; then
                output="$(xclip -selection clipboard -o)"
            elif command -v xsel >/dev/null 2>&1; then
                output="$(xsel --clipboard --output)"
            else
                echo "Unable to paste: wl-paste, xclip, or xsel not found"
                return 1
            fi
            ;;
        Darwin)
            output="$(pbpaste)"
            ;;
        *)
            output="$(powershell.exe Get-Clipboard 2>/dev/null | tr -d '\r')"
            ;;
    esac

    if [ "$#" -gt 0 ]; then
        printf "%s" "$output" > "$@"
    else
        printf "%s" "$output"
    fi
}

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

# Custom yank function
function vi-yank-clip {
    zle vi-yank
    echo -n "$CUTBUFFER" | __clip
}
zle -N vi-yank-clip
bindkey -M vicmd 'y' vi-yank-clip

# Custom put (paste) function
function vi-put-clip {
    CUTBUFFER=$(__paste)
    zle vi-put-after
}
zle -N vi-put-clip
bindkey -M vicmd 'p' vi-put-clip

autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic
