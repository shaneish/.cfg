function _source_once
    set -Ux FISH_CONFIG_DIRECTORY (dirname (dirname (status --current-filename)))
    fish_vi_key_bindings
    set -Ux fish_cursor_default block
    set -Ux fish_cursor_insert line blink
    set -Ux fish_cursor_replace_one underscore blink
    set -Ux fish_cursor_replace underscore blink
    set -Ux fish_cursor_external line blink
    set -Ux fish_cursor_visual block blink
    set -Ux fish_vi_force_cursor line blink
    change_greeting small
end
