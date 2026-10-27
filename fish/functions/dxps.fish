function dxps --description "Select Databricks profile for current shell session"
    set SELECTED_PROFILE $(databricks auth profiles | grep -E 'YES' | sed -E 's/YES$//' | fzf | awk '{print $1}')
    set -gx DATABRICKS_CONFIG_PROFILE $SELECTED_PROFILE
end
