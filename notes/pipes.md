# random pipes for future reference i don't want to lose

1) search for shrtcut with fzf instead of gui
```fish
rg '[\\w\-]+=\\"[\\w\\:/\\.\\?\+\\-\\\]+\\"' /Users/h62756/.config/.shrtcut.toml -N | awk -F'=' '{print $1}' | sk -i | xargs shrtcut --grab
```
