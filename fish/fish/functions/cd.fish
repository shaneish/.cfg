function cd --description "cd overwrite that will activate virtual environment currently in"
    builtin cd $argv
    _activate_local_venv
end
