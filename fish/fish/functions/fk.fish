function fk --description "fuzzy find with hp"
    hp (hp ls | fz | awk '{print $1}')
end
