# STOLEN FROM: https://github.com/fish-shell/fish-shell/issues/9751
# CHANGES MADE:
#   - had to change the user's custom `_fzf_wrapper` to `fzf`
#   - added flags to allow function to return output to command line or to clipboard
function fzf_search_history --description 'Search command history, starting with an empty query. Copy to clipboard (default behavior) or insert an old command at the cursor (with -i/--insert flag). Adapted from _fzf_search_history'
    argparse h/help i/insert s/select -- $argv
    or return # Exit early if argparse finds an invalid flag
    # history merge incorporates history changes from other fish sessions
    builtin history merge

    if set -q _flag_insert
        set dont_copy_to_clipboard 1
    else if set -q _flag_select
        set selection (echo copy\ninsert | fz --prompt="Select action: " --height=~2% --reverse --border --ansi)
        if test "$selection" = "insert"
            set dont_copy_to_clipboard 1
        end
    end

    set command_with_ts (
        # Reference https://devhints.io/strftime to understand strftime format symbols
        builtin history --null --show-time="%m-%d %H:%M:%S │ " |
        fz --read0 \
            --tiebreak=index \
            # preview current command using fish_ident in a window at the bottom 3 lines tall
            --preview="echo -- {4..} | fish_indent --ansi" \
            --preview-window="bottom:3:wrap" \
            $fzf_history_opts |
        string collect
    )

    if test $status -eq 0
        set command_selected (string split --max 1 " │ " $command_with_ts)[2]
        if set -q dont_copy_to_clipboard
            commandline --insert -- $command_selected
        else
            echo -n "$command_selected" | clip
        end
    end

    commandline --function repaint

end
