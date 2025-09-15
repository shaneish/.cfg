function tmpv --description 'Create a temporary python venv and activate it.  First arg is the Python CLI reference to use.  Second arg is a requirements.txt file to install.'
    mkdir -p "/tmp/py-venvs/"
    set -l venv_dir (mktemp -d "/tmp/py-venvs/$argv[1]-$(date +%Y-%m-%d_%m-%S).XXXXXX")
    $argv[1] -m venv $venv_dir
    echo "Created: $venv_dir"
    source $venv_dir/bin/activate.fish
    echo "Activated: $venv_dir"
    for dep in $argv[2..]
        echo "Installing: $dep"
        if string match -q "*.txt" "$dep"
            echo 1
            python -m pip install -r $dep
        else if string match -q "*.toml" "$dep"
            echo 2
            python -m pip install $(dirname $dep)
        else if test "$dep" = "..."
            echo 3
            echo "Installing critical deps: build, wheel, ruff, ipython"
            python -m pip install build wheel ruff ipython
        else
            echo 4
            python -m pip install $dep
        end
    end
end
