function sfx --description "Search for summin' -- but pick"
    rg "$argv" -i --line-number --color=always | fzf --ansi -m | awk -F':' '{print $1}' | xargs nvim -c "/$argv"
end
