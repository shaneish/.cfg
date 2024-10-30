" Name: plain-shane
" Author: Shane Stephenson (shaneish)
" Maintainer: stephenson.shane.a@gmail.com
" Notes: A dark monochrome colorscheme with a hint of color

let g:colorscheme_strings_as_comments = 0
let s:gray = "#a9a9a9"
let s:beige = "#d4cdc6"
let s:dark_brown = "#907f6d"
let s:white = "#ffffff"
let s:yellow_gray = "#414100"
let s:yellow_yellow = "#ffffc5"
let s:medium_yellow = "#ffec00"
let s:bright_yellow = "#ffd700"
let s:light_gray = "#cdcdcd"
let s:gray_blue = "#c0c8cf"
let s:light_yellow = "#fcfca9"
let s:gray_0 = "#f7f8f9"
let s:gray_1 = "#e8ebde"
let s:gray_2 = "#c9cdd2"
let s:gray_3 = "#9ea4aa"
let s:gray_4 = "#72787f"
let s:gray_5 = "#454c53"
let s:gray_6 = "#26282b"
let s:gray_7 = "#1b1d1f"
let s:gray_x = "#898989"
let s:gray_b = "#222222"
let s:gray_d = "#3d3d3d"
let s:gray_y = "#777777"
let s:gray_z = "#999999"
let s:gray_q = "#b8b8b8"
let s:gray_w = "#9c9c9c"
let s:gray_exp = "#ff6d7c"
let s:gray_dark = "#2d2d2d"
let s:gray_dish = "#636363"

let s:norm = s:white
let s:id_fg = s:gray_w
let s:type_fg = s:gray_w
let s:id_bg = "NONE"
let s:val_fg = s:gray_z
let s:val_bg = "NONE"
let s:sub_id = s:gray_2
let s:string_type = s:gray_z
let s:string_bg = "NONE"
let s:norm_type = s:light_gray
let s:fn_fg = s:gray_y
let s:fn_bg = "NONE"
let s:high_fg = s:gray_6
let s:high_bg = s:light_yellow
let s:search_bg = s:beige
let s:search_fg = s:gray_dark
let s:comments_fg = s:gray_d
let s:comments_bg = "NONE"

if g:colorscheme_strings_as_comments == 1
    let s:string_type = s:comment_fg
    let s:string_bg = s:comment_bg
endif

set background=dark

highlight clear
set termguicolors
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="theme"


function! H(group, guifg="NONE", guibg="NONE", gui="NONE")
    exec 'hi ' . a:group . ' guifg=' . a:guifg . ' guibg=' . a:guibg . ' gui=' . a:gui
endfunction

" --------------------------------
" Editor settings
" --------------------------------
call H("Normal", s:norm)
call H("Cursor", s:norm)
call H("LineNr", s:gray_w)
call H("CursorLineNR", s:bright_yellow)
call H("CursorLine",  s:yellow_yellow, s:yellow_gray)

" -----------------
" - Number column -
" -----------------
call H("CursorColumn", "NONE", "NONE", "NONE")
call H("FoldColumn", "#ffd700", "NONE", "NONE")
call H("SignColumn", "#ffd700", "NONE", "NONE")
call H("Folded", "#ffd700", "NONE", "NONE")

" -------------------------
" - Window/Tab delimiters -
" -------------------------
call H("VertSplit", "NONE", "NONE", "NONE")
call H("ColorColumn", "NONE", s:gray_dark, "NONE")
call H("TabLine", s:gray, "NONE", "NONE")
call H("TabLineFill", s:bright_yellow, "NONE", "NONE")
call H("TabLineSel", s:bright_yellow, "NONE", "NONE")

" -------------------------------
" - File Navigation / Searching -
" -------------------------------
call H("Directory", s:bright_yellow)
call H("Search", s:search_fg, s:search_bg)
call H("IncSearch", s:search_fg, s:search_bg)

" -----------------
" - Prompt/Status -
" -----------------
call H("StatusLine", s:bright_yellow, "NONE", "NONE")
call H("StatusLineNC", s:bright_yellow, "NONE", "NONE")
call H("WildMenu", s:bright_yellow, "NONE", "NONE")
call H("Question", s:bright_yellow, "NONE", "NONE")
call H("Title", s:bright_yellow, "NONE", "NONE")
call H("ModeMsg", s:bright_yellow, "NONE", "NONE")
call H("MoreMsg", s:bright_yellow, "NONE", "NONE")

" --------------
" - Visual aid -
" --------------
" call H("MatchParen",      s:medium_yellow,      "NONE")
call H("MatchParen",      s:bright_yellow,        "NONE")
call H("Visual",          s:high_fg,              s:high_bg)
call H("VisualNOS",       s:high_fg,              s:high_bg)
call H("NonText",         "NONE",                 "NONE")
call H("Todo",            s:gray_1,               "NONE")
call H("Underlined",      s:gray_1,               "NONE")
call H("Error",           s:bright_yellow,        "NONE")
call H("ErrorMsg",        s:bright_yellow,        "NONE")
call H("WarningMsg",      s:bright_yellow,        "NONE")
call H("Ignore",          s:bright_yellow,        "NONE")
call H("SpecialKey",      s:bright_yellow,        "NONE")
call H("WhiteSpaceChar",  s:bright_yellow,        "NONE")
call H("WhiteSpace",      s:bright_yellow,        "NONE")

" --------------------------------
" Variable types
" --------------------------------
call H("Constant",       s:val_fg,       s:val_bg)
call H("String",         s:string_type,  s:string_bg)
call H("StringDelimiter",s:string_type)
call H("Character",      s:val_fg,       s:val_bg)
call H("Number",         s:val_fg,       s:val_bg)
call H("Boolean",        s:val_fg,       s:val_bg)
call H("Float",          s:val_fg,       s:val_bg)
call H("Identifier",     s:fn_fg,        s:id_bg)
call H("Function",       s:fn_fg,        s:fn_bg)

" --------------------------------
" Language constructs
" --------------------------------
call H("Keyword",        s:fn_fg,         s:id_bg)
call H("Statement",      s:id_fg,         s:id_bg)
call H("Repeat",         s:id_fg,         s:id_bg)
call H("Comment",        s:comments_fg,   s:comments_bg, "underline")
call H("SpecialComment", s:comments_fg,   s:comments_bg, "underline")
call H("Conditional",    s:val_fg)
call H("Special",        s:id_fg,         s:id_bg)
call H("SpecialChar",    s:id_fg,         s:id_bg)
call H("Tag",            s:sub_id)
call H("Delimiter",      s:sub_id)
call H("Debug",          s:sub_id)
call H("Repeat",         s:sub_id)
call H("Label",          s:sub_id)
call H("Operator",       s:sub_id)
call H("Exception",      s:sub_id)

" ----------
" - C like -
" ----------
call H("PreProc", s:type_fg)
call H("Include", s:type_fg)
call H("Define", s:type_fg)
call H("Macro", s:type_fg)
call H("PreCondit", s:type_fg)
call H("Type", s:type_fg)
call H("StorageClass", s:type_fg)
call H("Structure", s:type_fg)
call H("TypeDef", s:type_fg)

" --------------------------------
" Diff
" --------------------------------
call H("DiffDelete",   "#fdb7b7")
call H("DiffAdd",      "#66ff00")
call H("DiffChange",   "#ffff00")
call H("DiffText",     "#c0c0c0")

" --------------------------------
" Completion menu
" --------------------------------
call H("Pmenu",          "#8C8C8C")
call H("PmenuSel",       "#8C8C8C")
call H("PmenuSbar",      "#8C8C8C")
call H("PmenuThumb",     "#8C8C8C")

" --------------------------------
" Spelling
" --------------------------------
call H("SpellBad",       "#ffd700")
call H("SpellCap",       "#ebe9e6")
call H("SpellLocal",     "#ebe9e6")
call H("SpellRare",      "#ebe9e6")
