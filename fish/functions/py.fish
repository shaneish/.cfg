function py
    if set -q argv[1]
        $PYTHON_VENV_DIR/$argv[1]/bin/python3 $argv[2..-1]
    else
        python3 $argv
    end
end
