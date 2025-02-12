function _activate_local_venv
    set venv_dir (fd "pyvenv" --extension cfg --exact-depth 2 -L -H | head -n 1 | xargs dirname)
    if test -n "$venv_dir"
        source $venv_dir/bin/activate.fish
    end
end
