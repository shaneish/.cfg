function gcp --description "git diff; git add -i; git commit -m; git push"
    gdf
    git add -i
    git commit -m "$argv"
    git push origin
end
