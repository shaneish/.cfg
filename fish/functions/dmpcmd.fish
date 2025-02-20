function dmpcmd -d "use fuzzy finder to select command and dump into cmd notes file"
    echo "\n" >> $CLI_NOTES
    printf '# %s ' $argv >> $CLI_NOTES
    set cmd (history | fz -m) >> $CLI_NOTES
end
