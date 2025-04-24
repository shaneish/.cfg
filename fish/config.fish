set -l certs_file $FISH_CONFIG_DIRECTORY/certs.fish
if test -e $certs_file
    source $certs_file
end

if status is-interactive
    _source_local # source machine-specific config (machine is id'd by the _machine_id function and $MACHINE_ID env var
    _custom_keybinds # obvious what this is

    # tool-specific configs
    if type -q "starship"
        starship init fish | source
    end
    if type -q fzf
        fzf --fish | source
    else if type -q sk
        skim_key_bindings
    end
    if type -q databricks
        source $FISH_CONFIG_DIRECTORY/databricks.fish
    end
    if type -q git
        source $FISH_CONFIG_DIRECTORY/git.fish
    end
    if type -q "bhop"
        alias _hp_fz_fixed="bhop __bhop_list__ | fnk filter -f 'f -> \":\" not in f' | fz -m | fnk map -f 'f -> f.split()[-1]' | xargs"
        alias _hp_fz="bhop __bhop_list__ | rg '\->' | fz -m | awk -F'->' '{print $2}' | xargs"
        alias hg="cd (_hp_fz_fixed)"
        alias ho="_hp_fz_fixed $EDITOR"
    end

    # random stuff not worth putting elsewhere
    alias lh="history | fz | clip"
    alias ll="eza"
    alias cls="clear; fish"
    alias opn="fd '' . | fz -m | xargs $EDITOR"
    alias vym="source $HOME/.config/nvim/venv/bin/activate.fish; nvim"
    alias vi="nvim"
    abbr -a rp rust-parallel
    abbr -a fs fselect

    # set python venv
    pyv
end
