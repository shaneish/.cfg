function pyv
    if test "$argv" = "ls"
        ls $PYTHON_VENV_DIR
    else if test -e "$PYTHON_VENV_DIR/$argv/bin/activate.fish"
        set -Ux PYTHON_VENV "$PYTHON_VENV_DIR/$argv"
        source $PYTHON_VENV/bin/activate.fish
    else
        set -fx found_venv (fd "pyvenv" --extension cfg --exact-depth 2 -L -H $PYTHON_VENV_DIR | tail -n 1 | xargs dirname)
        set -fx local_venv (fd "pyvenv" --extension cfg --exact-depth 2 -L -H | sort -n | tail -n 1 | xargs dirname 2> /dev/null)
        if test -n "$local_venv"
            set -fx found_venv $local_venv
        end
        set -Ux PYTHON_VENV $found_venv
        source $found_venv/bin/activate.fish
    end
end
