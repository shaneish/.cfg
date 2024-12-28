function gcp --description "git add -p; git commit -m; git push"
    git add -p
    git commit -m "$argv"
    git push origin
end
