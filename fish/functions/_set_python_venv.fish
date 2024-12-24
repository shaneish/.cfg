function _set_python_venv
    function _infer_python_venv
        set venv_dir_names $HOME/.local/python-venvs $HOME/.config/python-venvs
        set venv_priority fast-default fast default venv .venv
        for d in $venv_dir_names
            for p in $venv_priority
                if test -d $d/$p/bin/activate.fish
                    set -Ux PYTHON_VENV $d/$p
                    return
                end
            end
        end
    end

    if set -q argv[1]
        set -gx PYTHON_VENV $argv[1]
    else if not set -q PYTHON_VENV
        _infer_python_venv
    end
    if set -q PYTHON_VENV
        source $PYTHON_VENV/bin/activate.fish
    end
end
