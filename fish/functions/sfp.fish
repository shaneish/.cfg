function sfp --description "Search through python files -- but pick"
    rg "$argv" -i --line-number --color=always -t py | fzf --ansi -m | awk -F':' '{print $1}' | xargs nvim -c "/$argv"
end
