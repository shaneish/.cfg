function _get_local_machine_id
    set -f user_id (id -un)
    set -f machine_name (string lower (uname -a | awk '{print $1}'))
    set -f os_type (string lower (uname -a | awk '{print $1}'))
    set -f files_to_check "default.fish" "$os_type.fish" "$user_id.fish" "$os_type-$user_id.fish" "$machine_name.fish"

    if test -e /etc/os-release
        set linux_type (cat /etc/os-release | rg '^ID="([\\w\\-\\.]+)"' -r '$1')
        set -f files_to_check $files_to_check "$linux_type.fish"
    end

    printf '%s\n' $files_to_check
end
