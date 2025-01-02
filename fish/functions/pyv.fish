function pyv
    function _infer_python_venv
        set venv_priority fast venv .venv 3.13 3.12 3.11 3.10 3.9
        for d in $PYTHON_VENV_DIR
            for p in $venv_priority
                if test -e $d/$p/bin/activate.fish
                    set -gx PYTHON_VENV $d/$p
                    source $d/$p/bin/activate.fish
                    return
                end
            end
        end
    end

    if set -q argv[1]
        set -gx PYTHON_VENV $PYTHON_VENV_DIR/$argv
        source $PYTHON_VENV/bin/activate.fish
    else
        _infer_python_venv
    end
end
