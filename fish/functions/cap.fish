function cap --description 'Run a terminal command and capture command + output to clipboard.'
    argparse h/help p/prompt-icon= u/include-user H/include-hostname d/include-directory a/all -- $argv
    or return # Exit early if argparse finds an invalid flag

    set preprompt ""
    set postprompt "~\$"

    if set -q _flag_prompt
        set postprompt "$_flag_prompt"
    end

    if set -q _flag_include_user; or set -q _flag_all
        set preprompt "$(whoami)"
    end

    if set -q _flag_include_hostname; or set -q _flag_all
        set preprompt "$preprompt@$(uname -n)"
    end

    if set -q _flag_include_directory; or set -q _flag_all
        set preprompt "$preprompt:$(prompt_pwd)"
    end

    set prompt "$preprompt$postprompt $argv"

    set response "$(eval "$argv" 2>&1)"
    printf "$prompt\n$response" | clip
    printf $response
end
