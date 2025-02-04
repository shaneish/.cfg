function psx --description "Search a Python codebase for a string"
    rg $argv -i -l -T rst -t py -g='!__init__.py' -g="!test_*" -g="!examples/**/*" -g="!databricks/sdk/mixins*" | xargs nvim -c "/$argv[1]"
end
