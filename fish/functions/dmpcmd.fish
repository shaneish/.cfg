function dmpcmd -d "use fuzzy finder to select command and dump into cmd notes file"
    printf '## : %s\n' $argv >> $CLI_NOTES
    history | fz -m >> $CLI_NOTES
end
