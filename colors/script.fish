if test -z $argv[1]
    echo "please supply a target spec in the ./specs folder"
    exit 1
end
set spec ./specs/$argv[1]
set name (cat $spec | yj -tj | jaq '.metadata.name' -r)
set theme_name (basename -s .toml $spec)
set themes_dir themes/$theme_name
rip $themes_dir
cp -rf templates $themes_dir
echo $name
echo $theme_name
echo $themes_dir
ls $themes_dir

for pair in (cat $spec | yj -tj | jaq '.colors | to_entries | .[] | "\(.value) \(.key)"' -r)
    set p (string split ' ' -- $pair)
    set rp (echo $p[1] | sd "#" "")
    echo "{{colors.$p[2]}}" $rp
    rg "\{\{colors.$p[2]}}" -l $themes_dir | xargs sd "\{\{colors.$p[2]}}" "$rp"
end

for pair in (cat $spec | yj -tj | jaq '.metadata | to_entries | .[] | "\(.value) \(.key)"' -r)
    set p (string split ' ' -- $pair)
    echo value: $p[1], key: $p[2]
    rg "\{\{metadata.$p[2]}}" -l $themes_dir | xargs sd "\{\{metadata.$p[2]}}" "$p[1]"
end

set name (cat $spec | yj -tj | jaq '.metadata.name' -r)
for f in (ls $themes_dir | rg "(\.theme)|(\.vim)|(\.toml)")
    set f $themes_dir/$f
    set ext (basename $f | cut -d'.' -f2-)
    if string match -q -- "*nvim.vim" (basename $f)
        set new "$themes_dir/nvim__$theme_name.$ext"
        echo renaming $f $new
        mv $f $new
        cp -f $new $HOME/.config/.cfg/nvim/active_theme.vim
    else if string match -q -- "*wezterm.toml" (basename $f)
        set new "$themes_dir/wez__$theme_name.$ext"
        echo renaming $f $new
        mv $f $new
        cp -f $new $HOME/.config/.cfg/wezterm/colors/active_theme.toml
        # wezterm --config-file $HOME/.config/wezterm/wezterm.lua
    else if string match -q -- "*fish.theme" (basename $f)
        set new "$themes_dir/fish__$theme_name.$ext"
        echo renaming $f $new
        mv $f $new
        cp -f $new $HOME/.config/.cfg/fish/themes/active_theme.theme # this garbo is because fish themes can't be symlinks
        fish_config theme choose active_theme
        yes | fish_config theme save
    end
end
