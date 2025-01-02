function _activate_local_venv
    set venv_activation_script (fd "activate" --extension fish --exact-depth 3 -u | sort -r | head -n 1)
    if test -e $venv_activation_script
        source $venv_activation_script
    end
end
