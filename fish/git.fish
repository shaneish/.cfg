alias git="git --no-pager"
alias gdob="git diff origin/(git branch --show-current)" # get diff between local branch and origin branch
alias gpob="git push origin (git branch --show-current)" # push current branch to origin
alias gpub="git pull origin (git branch --show-current)" # pull current branch from origin
alias gwtrm="git worktree list | fz | awk '{print \$3}' | sd '\[|\]' '' | xargs git worktree remove -f" # remove a worktree with fuzzy finder

abbr -a gl git log
abbr -a gap git add -p
abbr -a gau git add -u
abbr -a gaa git add .
abbr -a ga git add
abbr -a gcm git commit -m
abbr -a gb git branch
abbr -a gbc git branch --show-current
abbr -a gbll git branch -l
abbr -a gbl git branch -a
abbr -a gm git merge
abbr -a gpo git push origin
abbr -a gpu git pull origin
abbr -a gco git checkout
abbr -a gs git status
abbr -a gcb git checkout -b
abbr -a gwt git worktree
abbr -a gwtl git worktree list
abbr -a gwta git worktree add
abbr -a gwtr git worktree remove
abbr -a gd git diff

if type -q nvim
    abbr -a merge git mergetool --tool=nvimdiff1
    abbr -a gmt git mergetool --tool=nvimdiff1
else if type -q vim
    abbr -a merge git mergetool --tool=vimdiff1
    abbr -a gmt git mergetool --tool=vimdiff1
else
    abbr -a merge git mergetool
    abbr -a gmt git mergetool
end
