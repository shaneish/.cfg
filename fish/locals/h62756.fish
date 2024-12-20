set local_dir (dirname (dirname (status --current-filename)))
if test -e $local_dir/cigna_certs.fish
    source $local_dir/cigna_certs.fish"
end

function dbsx --description "Search the Databricks Python SDK codebase for a string"
    psx $argv[1] (hp f dbrx-sdk)
end

function dbfx --description "Search the Databricks Python SDK codebase for a string"
    psx $argv[1] (hp f dbrx-sdk)
end

function shrt
    rg '[\\w\-]+=\\"[\\w\\:/\\.\\?\+\\-\\\]+\\"' $HOME/.config/.shrtcut.toml -N | awk -F'=' '{print $1}' | sk | xargs shrtcut --grab
end
