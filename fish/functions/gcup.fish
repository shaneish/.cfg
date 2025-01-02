function gcup --description "git add -u; git commit -m; git push"
    git add -u
    git commit -m "$argv"
    git push origin
end
