function worktree --d "Default location git worktree.  Last argument (argv[-1]) is the name of the branch/commit to switch to."
    set current_repo (basename $(git rev-parse --show-toplevel))
    set proj_gwt_folder $HOME/.local/gwt/$current_repo
    set current_short_hash (git rev-parse --short HEAD)
    set branch_dir $proj_gwt_folder/$argv[-1]__$current_short_hash
    if not test -e $proj_gwt_folder
        mkdir -p $proj_gwt_folder
    end
    if test -e $branch_dir
        set branch_dir $branch_dir__(date "+%Y%m%d-%H%M%S")
    end
    git worktree add $branch_dir $argv
    if test -e $branch_dir
        echo "new git worktree created at $branch_dir..."
        cd $branch_dir
    else
        echo "error creating git worktree for repo $current_repo and branch $arvg[-1] at location $branch_dir ..."
    end
end
