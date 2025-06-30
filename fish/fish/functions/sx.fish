function sx --description "Search for summin'"
    rg "$argv" -i -l | xargs nvim -c "/$argv"
end
