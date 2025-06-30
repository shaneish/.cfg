function _activate_local_venv
    set validation_flags validate -v --validate
    set venv_dir (fd "pyvenv" --extension cfg --exact-depth 2 -L -H | head -n 1)
    if test -n "$venv_dir"
        if contains "$argv[1]" $validation_flags
            printf '%s' (dirname $venv_dir)
        else
            source (dirname $venv_dir)/bin/activate.fish
            set -x PYTHON_VENV (dirname $venv_dir)
        end
    end
end
