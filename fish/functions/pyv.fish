function pyv
    if test "$argv[1]" = "ls"
        set filter $argv[2]
        fish -c "cd \"$PYTHON_VENV_DIR\"; fd \"activate\" | awk -F '/' '{print \$1}' | rg \"$filter\" | sort | uniq"
    else if test "$argv[1]" = "new"
        if not set -q argv[1]
            echo "Error: Please provide a name for the new virtual environment."
            echo "Usage: pyv new <venv_name> [python_version] (ex: `pyv new myvenv 3.14`, `pyv new myvenv`)"
            return 1
        end
        set -l venv_name $argv[2]
        set python_version $(python3 --version | awk '{print $2}' | awk -F'.' 'BEGIN{OFS=FS} {NF--; print}') # use the current python version as default
        if set -q argv[3]
            set python_version $argv[3]
        end
        if test -z "$venv_name"
            echo "Error: Please provide a name for the new virtual environment."
            echo "Usage: pyv new <venv_name> [python_version] (ex: `pyv new myvenv 3.14`, `pyv new myvenv`)"
            return 1
        end
        if type -q uv
            uv venv "$PYTHON_VENV_DIR/$venv_name" --python "$python_version"
        else
            if set -q argv[3]
                echo "Warning: uv is not installed, using default python version $python_version"
            end
            python3 -m venv "$PYTHON_VENV_DIR/$venv_name"
        end
        set PYTHON_VENV "$PYTHON_VENV_DIR/$venv_name"
        source "$PYTHON_VENV/bin/activate.fish"
        python -m ensurepip
        python -m pip install ipython # install ipython by default just because
    else if test "$argv[1]" = "rm"
        if not set -q argv[2]
            echo "Error: Please provide the name of the virtual environment to remove."
            echo "Usage: pyv rm <venv_name>"
            return 1
        end
        set venv_name $argv[2]
        if test -e "$PYTHON_VENV_DIR/$venv_name"
            if set -q rip
                rip "$PYTHON_VENV_DIR/$venv_name"
            else
                rm -rf "$PYTHON_VENV_DIR/$venv_name"
            end
            echo "Removed virtual environment: $venv_name"
        else
            echo "Error: Virtual environment '$venv_name' does not exist."
            return 1
        end
    else if test -e "$PYTHON_VENV_DIR/$argv/bin/activate.fish"
        set -gx PYTHON_VENV "$PYTHON_VENV_DIR/$argv"
        source "$PYTHON_VENV/bin/activate.fish"
    else
        set local_venv (_activate_local_venv validate)
        if test -n "$local_venv"
            source "$local_venv/bin/activate.fish"
        else if test -n "$PYTHON_VENV"; and test -e "$PYTHON_VENV/bin/activate.fish"
            source "$PYTHON_VENV/bin/activate.fish"
        else
            set -fx found_venv (fd "pyvenv" --extension cfg --exact-depth 2 -L -H $PYTHON_VENV_DIR | tail -n 1 | xargs dirname)
            set -gx PYTHON_VENV $found_venv
            source "$found_venv/bin/activate.fish"
        end
    end
end
