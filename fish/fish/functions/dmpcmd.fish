function dmpcmd -d "use fuzzy finder to select command and dump into cmd notes file"
    printf '\n# %s' $argv >> $CLI_NOTES
    printf "\n" >> $CLI_NOTES
    set cmd (history | fz -m)
    printf $cmd >> $CLI_NOTES
end
