function srchp -d "search the path variable for executable with regex (ripgrep)"
    if not type -q fnk
        git clone https://github.com/shaneish/fnkpy.git /tmp/fnkpy
        if type -q pipx
            pipx install /tmp/fnkpy
        else if type -q pypy3
            pypy3 -m pip install /tmp/fnkpy
        else if type -q python3
            python3 -m pip install /tmp/fnkpy
        else
            echo "[error] unable to install dependency fnkpy as no appropriate python3 interface exists in PATH"
            exit 1
        end
    end
    set -l checked_paths ""
    for p in $PATH
        if not contains "$p" $checked_paths
            set -a checked_paths "$p"
            set results $(ls -l $p 2>/dev/null | rg "x\.\s" | fnk -m "' '.join(_.split()[8:])" | rg "$argv[1]" -i)
            if test -n "$results"
                echo "$p:"
                for r in $results
                    echo "    $r"
                end
            end
        end
    end
end
