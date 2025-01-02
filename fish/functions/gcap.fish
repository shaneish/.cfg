function gcap --description "git add .; git commit -m; git push"
    git add .
    git commit -m "$argv"
    git push origin
end
