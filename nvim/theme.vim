" Name: plain-shane
" Author: Shane Stephenson (shaneish)
" Maintainer: stephenson.shane.a@gmail.com
" Notes: A dark monochrome colorscheme with a hint of color

let g:colorscheme_strings_as_comments = 0
let s:gray = "#a9a9a9"
let s:beige = "#d4cdc6"
let s:dark_brown = "#907f6d"
let s:norm = "#ffffff"
let s:yellow_gray = "#414100"
let s:light_yellow = "#ffffc5"
let s:bright_yellow = "#fad5a5"
let s:light_gray = "#cdcdcd"
let s:light_yellow = "#fcfca9"
let s:gray_d = "#3d3d3d"
let s:gray_dd = "#515151"
" let s:gray_dd = "#515151"
" let s:gray_y = "#777777"
let s:gray_y = "#777777"
let s:gray_dark = "#202020"
" let s:gray_dish = "#636363"
let s:gray_dish = "#c0c0c0"
let s:gunmetal = "#818589"
let s:platinum = "#e5e4e2"
let s:smoke = "#848884"
let s:light_gray = "#d3d3d3"
let s:grey = "#808080"
let s:pewter = "#899499"

let s:dark_0 = "#1f1f1f"
let s:dark_1 = "#1e1e1e"
let s:med_0 = "#323232"
let s:med_1 = "#454545"
let s:med_2 = "#595959"
let s:med_3 = "#636363"
let s:med_4 = "#6c6c6c"
let s:med_5 = "#767676"
let s:light_0 = "#808080"
let s:light_1 = "#8a8a8a"
let s:light_2 = "#949494"
let s:light_3 = "#9d9d9d"
let s:light_4 = "#a7a7a7"
let s:light_5 = "#b1b1b1"
let s:light_6 = "#bbbbbb"
let s:light_7 = "#c5c5c5"
let s:light_8 = "#d8d8d8"
let s:light_9 = "#e2e2e2"
let s:light_10 = "#ececec"
let s:light_11 = "#f6f6f6"

" let s:high_bg = "#fffe62"
" let s:high_fg = s:dark_0
" let s:high_bg = "#fad5a5"
let s:high_bg = s:beige
let s:high_fg = s:dark_1
let s:search_fg = "NONE"
let s:search_bg = s:med_1
let s:search_gui = "underdashed,bold"
let s:string_type = s:norm
let s:comments_fg = s:light_1
let s:comments_bg = "NONE"
" let s:val = s:light_3
let s:val = s:norm
let s:ops = s:string_type
let s:fn = s:norm

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
call H("Normal", s:norm, "#000000")
call H("Cursor", s:norm)
call H("LineNr", s:gray_d)
call H("CursorLineNR", s:norm, "#000000", "bold,underline")
call H("CursorLine",  "NONE", s:med_1, "bold")

" -----------------
" - Number column -
" -----------------
call H("CursorColumn", "NONE",  "NONE", "NONE")
call H("FoldColumn",   s:gray, "NONE", "NONE")
call H("SignColumn",   s:gray, "NONE", "NONE")
call H("Folded",       s:gray, "NONE", "NONE")

" -------------------------
" - Window/Tab delimiters -
" -------------------------
call H("VertSplit",   "NONE",          "NONE",      "NONE")
call H("ColorColumn", "NONE",          s:gray_dark, "NONE")
call H("TabLine",     s:string_type,          "NONE",      "NONE")
call H("TabLineFill", s:bright_yellow, "NONE",      "NONE")
call H("TabLineSel",  s:bright_yellow, "NONE",      "NONE")

" -------------------------------
" - File Navigation / Searching -
" -------------------------------
call H("Directory", s:norm, "NONE", "underline")
call H("Search",    s:search_fg, s:search_bg, s:search_gui)
call H("IncSearch", s:search_fg, s:search_bg, s:search_gui)
call H("CurSearch", s:search_fg, s:search_bg, "underdouble")
call H("QuickFix",  s:bright_yellow, "NONE", "underdotted")

" -----------------
" - Prompt/Status -
" -----------------
call H("StatusLine",   s:gray_y, "NONE", "NONE")
call H("StatusLineNC", s:gray_y, "NONE", "NONE")
call H("WildMenu",     s:gray_y, "NONE", "NONE")
call H("Question",     s:gray_y, "NONE", "NONE")
call H("Title",        s:gray_y, "NONE", "NONE")
call H("ModeMsg",      s:gray_y, "NONE", "NONE")
call H("MoreMsg",      s:gray_y, "NONE", "NONE")

" --------------
" - Visual aid -
" --------------
call H("MatchParen",      s:bright_yellow,        "NONE", "bold,underdouble")
call H("Visual",          s:high_fg,              s:high_bg, "bold")
call H("VisualNOS",       s:high_fg,              s:high_bg, "bold")
call H("NonText",         s:high_fg,              "NONE")
call H("Todo",            s:high_bg,              "NONE", "undercurl")
call H("Underlined",      s:high_bg,              "NONE", "undercurl")
call H("Error",           s:high_bg,              "NONE", "undercurl")
call H("ErrorMsg",        s:high_bg,              "NONE", "undercurl")
call H("WarningMsg",      s:high_bg,              "NONE", "undercurl")
call H("Ignore",          s:high_bg,              "NONE", "undercurl")
call H("SpecialKey",      s:bright_yellow,        "NONE")
call H("WhiteSpaceChar",  s:bright_yellow,        "NONE")
call H("WhiteSpace",      s:bright_yellow,        "NONE")

" --------------------------------
" Variable types
" --------------------------------
call H("Constant",       s:string_type,       "NONE")
call H("String",         s:string_type,  s:comments_bg, "bold")
call H("StringDelimiter",s:val,  s:comments_bg, "bold")
call H("Character",      s:string_type,       "NONE")
call H("Number",         s:string_type,       "NONE")
call H("Boolean",        s:string_type,       "NONE")
call H("Float",          s:string_type,       "NONE")
call H("Identifier",     s:fn,        "NONE")
call H("Function",       s:fn,        "NONE")

" --------------------------------
" Language constructs
" --------------------------------
call H("Keyword",        s:fn)
call H("Statement",      s:fn)
call H("Repeat",         s:fn)
call H("Comment",        s:comments_fg,   s:comments_bg, "italic")
call H("SpecialComment", s:comments_fg,   s:comments_bg, "italic")
call H("Conditional",    s:norm)
call H("Special",        s:norm)
call H("SpecialChar",    s:norm)
call H("Tag",            s:norm)
call H("Delimiter",      s:val)
call H("Debug",          s:norm)
call H("Repeat",         s:norm)
call H("Label",          s:val)
call H("Operator",       s:val)
call H("Exception",      s:val)

" ----------
" - C like -
" ----------
call H("PreProc", s:fn)
call H("Include", s:fn)
call H("Define", s:fn)
call H("Macro", s:fn)
call H("PreCondit", s:fn)
call H("Type", s:fn)
call H("StorageClass", s:fn)
call H("Structure", s:fn)
call H("TypeDef", s:fn)

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
call H("SpellBad",       "#ebe9e6", "NONE", "undercurl")
call H("SpellCap",       "#ebe9e6", "NONE", "undercurl")
call H("SpellLocal",     "#ebe9e6", "NONE", "undercurl")
call H("SpellRare",      "#ebe9e6", "NONE", "undercurl")
