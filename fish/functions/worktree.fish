function worktree --d "Default location git worktree; argv is the name of the branch/commit to switch to."
    set proj_gwt_folder $HOME/.local/gwt/(basename pwd)
    mkdir -p $proj_gwt_folder
    git worktree add $proj_gwt_folder/$argv[1] $argv[1]
    echo $proj_gwt_folder/$argv[1]
    cd $proj_gwt_folder/$argv[1]
end
