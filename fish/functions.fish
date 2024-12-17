function arrout
    set -l arr $argv[2..]
    set -l sub_len (math ceil (math (count $arr) / $argv[1]))
    for i in (seq $sub_len)
        set -l first (math 1 + (math (math $i - 1) \* $argv[1]))
        set -l last (math $i \* $argv[1])
        echo (string join " " $arr[$first..$last])
    end
end

function emoji --description "Get an emoji"
    set multi 0
    set lines 1
    set pattern "$argv[1].*$argv[2]|$argv[2].*$argv[1]"
    if test $argv[1] = "-m" || test $argv[1] = "--multi"
        set pattern "$argv[2].*$argv[3]|$argv[3].*$argv[2]"
        set multi 1
    else if test $argv[1] = "-a" || test $argv[1] = "--any"
        set pattern "[\\w-]+"
    else if test $argv[1] = "-h" || test $argv[1] = "--help"
        echo "Usage: emoji [-m|--multi] [-a|--any] [-h|--help] <pattern> [OPTIONAL]<pattern>"
        return
    end
    set out (jq -r 'to_entries[] | .key, .value' $HOME/.config/fish/ascii-emojis.json | rg "$pattern" -A 1 --context-separator="" -o -r "" | rg -N "\S")
    if test $multi = 1
        set lines (count $out)
    end
    printf %s\n $out | shuf -n $lines
end

function emojis --description "Select from emojis"
    emoji -m $argv | fzf
end

function hp --description "Hop around the terminal"
    set output (sh -c "bhop $argv")
    if not string match -q "*|*" $output
        echo $output
    else
        set cmds (string split "|" $output)
        cd $cmds[1]
        sh -c "$cmds[2]"
    end
end

function manp --description "A simple manpage result without the BS backspace characters"
    man $argv | col -b
end

function src --description "Search a codebase and open files in your editor"
    set -l options 'i/include' 'x/exclude' 'd/dont_include_i' 'e/editor'
    argparse $options -- $argv[2..]
    set cmd $argv[1]
    if not set -q _flag_dont_include_i
        set cmd "$cmd -i"
    end
    if set -q _flag_include
        set cmd = "$cmd -t $_flag_include"
    end
    if set -q _flag_exclude
        set cmd = "$cmd -T $_flag_exclude"
    end
    set editor "nvim"
    if set -q _flag_editor
        set editor $_flag_editor
    end
    set cmd = "rg $cmd -l | xargs $editor -c '/$($argv[1])'"
    fish -c $cmd
end

function psx --description "Search a Python codebase for a string"
    rg $argv -i -l -T rst -t py -g='!__init__.py' -g="!test_*" -g="!examples/**/*" -g="!databricks/sdk/mixins*" | xargs nvim -c "/$argv[1]"
end

function sx --description "Search for summin'"
    rg "$argv" -i -l | xargs nvim -c "/$argv"
end

function skx --description "Search for summin'"
    rg "$argv" -i -l | sk --ansi -i -c 'rg --color=always --line-number "{}"' -m | awk -F':' '{print $1}' | xargs nvim -c "/$argv"
end

function fzx
    sk --ansi -i -c 'rg --color=always --line-number "{}"' -m | awk -F':' '{print $1} {print $2}' | xargs -n 2 sh -c 'nvim +$2 $1'
end
function pfx --description "Search a Python codebase for a string"
    rg $argv -i -l -T rst -t py -g='!__init__.py' -g="!test_*" -g="!examples/**/*" -g="!databricks/sdk/mixins*" | sk -m | xargs nvim -c "/$argv[1]"
end

function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

function shrt
    rg '[\\w\-]+=\\"[\\w\\:/\\.\\?\+\\-\\\]+\\"' /Users/h62756/.config/.shrtcut.toml -N | awk -F'=' '{print $1}' | sk | xargs shrtcut --grab
end

function choose_background
    set CONF_DIR $HOME/.config
    set CFG_DIR $CONF_DIR/.cfg
    set WALL_DIR $CFG_DIR/backgrounds
    set BACK_FILE (fd 'background\\.\\w+' $CFG_DIR -d 1)
    echo $WALL_DIR $BACK_FILE
    set TYPE (random choice jpg png)
    set NEW (random choice $WALL_DIR/*.$TYPE)
    echo $TYPE $NEW
    echo $BACK_FILE
    if test -L $BACK_FILE
        echo $BACK_FILE
        rip $BACK_FILE
        ln -rs $NEW $CFG_DIR/background.$TYPE
    end
end

function read_confirm
  while true
    read -l -P 'Do you want to continue? [y/N] ' confirm
    switch $confirm
      case Y y
        return 0
      case '' N n
        return 1
    end
  end
end

function theme_highlight
    set -gx CURRENT_THEME (rg 'cursor_bg\s+=\s+"#([a-zA-Z0-9]+)"' ~/.config/wezterm/colors/theme.toml -r '$1' -N)
    echo "Current theme highlight: $CURRENT_THEME"
end

function highlight_color
    set -l new_color $argv[1]
    switch $argv[1]
        case GOLD
            set new_color f fd700
        case BRASS
            set new_color f 9e29c
        case FLAX
            set new_color f ad5a5
        case ECRU
            set new_color e edc82
        case JASMINE
            set new_color f 9e29c
        case PEAR
            set new_color b 4c424
        case CADMIUM
            set new_color f dda0d
        case NAVAJO
            set new_color f fdead
        case EGGNOG
            set new_color f 9e29c
        case SEPIA
            set new_color e 3b778
        case ARMY
            set new_color 4 b5320
        case SEAGREEN
            set new_color 2 e8b57
        case ARTICHOKE
            set new_color 8 f9779
        case MOSS
            set new_color f ad5a5
        case MINT
            set new_color 9 8fb98
        case EMERALD
            set new_color 5 0c878
        case HUNTER
            set new_color 3 f704d
        case FERN
            set new_color 4 f7942
        case SAGE
            set new_color 9 DC183
        case FOREST
            set new_color 0 B6623
        case OLIVE
            set new_color 7 08238
        case LIME
            set new_color c 7ea46
        case SALMON
            set new_color f a8072
        case TANGERINE
            set new_color f 08000
        case BLUISH
            set new_color b 0c1b3
        case YELLOWISH
            set new_color f 6cd61
        case BROWN
            set new_color f 6cd61
    end
    set new_color (string join '' $new_color)
    set theme_color (rg 'cursor_bg\s+=\s+"#([a-zA-Z0-9]+)"' ~/.config/wezterm/colors/theme.toml -r '$1' -N)
    if test "$argv[2]" = "-s"; or test "$argv[2]" = "--show"
        set_color $new_color; printf '%s\n' $new_color
    else
        trap 'set_color red; echo "ERROR: Color $new_color not found!"' STOP
        set_color $theme_color; printf '%s\n' "Current color: $theme_color"
        set_color $new_color; printf '%s\n' "New color: $new_color"
        if read_confirm
            set -gx CURRENT_THEME $theme_color
            set term_programs wezterm fish nvim starship-prompts sketchybar sway waybar hypr aerospace.toml
            rg "$theme_color" -l ~/.config/.cfg | xargs sd "$theme_color" $new_color -F
        end
    end
end


