function pyv
    if set -q argv[1]
        set -Ux PYTHON_VENV $PYTHON_VENV_DIR/$argv
        source $PYTHON_VENV/bin/activate.fish
    else if ! test -n "$VIRTUAL_ENV"
        set -fx found_venv (fd "pyvenv" --extension cfg --exact-depth 2 -L -H $PYTHON_VENV_DIR | tail -n 1 | xargs dirname)
        set -fx local_venv (fd "pyvenv" --extension cfg --exact-depth 2 -L -H | sort -n | tail -n 1 | xargs dirname)
        if test -n "$local_venv"
            set -fx found_venv $local_venv
        end
        set -Ux PYTHON_VENV $found_venv
        source $found_venv/bin/activate.fish
    end
end
