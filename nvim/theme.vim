" Name: plain-shane
" Author: Shane Stephenson (shaneish)
" Maintainer: stephenson.shane.a@gmail.com
" Notes: A dark monochrome colorscheme with a hint of color

let g:colorscheme_strings_as_comments = 0
let s:gray = "#a9a9a9"
let s:beige = "#d4cdc6"
let s:dark_brown = "#907f6d"
let s:foreground_color = "#ffffff"
let s:yellow_gray = "#414100"
let s:light_gray = "#cdcdcd"
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
let s:bright_color = "#8b8000"
let s:primary_color = "#f6cd61"
let s:background_color = "#000000"
let s:foreground_color = "#ffffff"
let s:mid = "#a7a7a7"
let s:light = "#c5c5c5"
let s:dark = "#767676"
let s:darkest = "#323232"

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

let s:high_bg = s:bright_color
let s:high_fg = s:background_color
let s:search_fg = "NONE"
let s:search_bg = s:mid
let s:search_gui = "underdashed,bold"
let s:string_type = s:foreground_color
let s:comments_fg = s:light
let s:comments_bg = "NONE"
let s:val = s:foreground_color
let s:ops = s:foreground_color
let s:fn = s:foreground_color

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
call H("Normal", s:foreground_color, "#000000")
call H("Cursor", s:foreground_color)
call H("LineNr", s:dark)
call H("CursorLineNR", s:primary_color, "#000000", "bold")
call H("CursorLine",  "NONE", s:darkest, "bold")

" -----------------
" - Number column -
" -----------------
call H("CursorColumn", "NONE",  "NONE", "NONE")
call H("FoldColumn",   s:mid, "NONE", "NONE")
call H("SignColumn",   s:mid, "NONE", "NONE")
call H("Folded",       s:mid, "NONE", "NONE")

" -------------------------
" - Window/Tab delimiters -
" -------------------------
call H("VertSplit",   "NONE",          "NONE",      "NONE")
call H("ColorColumn", "NONE",          s:gray_dark, "NONE")
call H("TabLine",     s:mid,          "NONE",      "NONE")
call H("TabLineFill", s:primary_color, "NONE",      "NONE")
call H("TabLineSel",  s:primary_color, "NONE",      "NONE")

" -------------------------------
" - File Navigation / Searching -
" -------------------------------
call H("Directory", s:foreground_color, "NONE", "underline")
call H("Search",    s:search_fg, s:search_bg, s:search_gui)
call H("IncSearch", s:search_fg, s:search_bg, s:search_gui)
call H("CurSearch", s:search_fg, s:search_bg, "underdouble")
call H("QuickFix",  s:primary_color, "NONE", "underdotted")

" -----------------
" - Prompt/Status -
" -----------------
call H("StatusLine",   s:dark, "NONE", "NONE")
call H("StatusLineNC", s:dark, "NONE", "NONE")
call H("WildMenu",     s:dark, "NONE", "NONE")
call H("Question",     s:dark, "NONE", "NONE")
call H("Title",        s:dark, "NONE", "NONE")
call H("ModeMsg",      s:dark, "NONE", "NONE")
call H("MoreMsg",      s:dark, "NONE", "NONE")

" --------------
" - Visual aid -
" --------------
call H("MatchParen",      s:darkest,              s:high_bg, "bold,underdouble")
call H("Visual",          s:high_fg,              s:high_bg, "bold")
call H("VisualNOS",       s:high_fg,              s:high_bg, "bold")
call H("NonText",         s:high_fg,              "NONE")
call H("Todo",            s:high_bg,              "NONE",    "underline")
call H("Underlined",      s:high_bg,              "NONE")
call H("Error",           s:high_bg,              "NONE",    "undercurl")
call H("ErrorMsg",        s:high_bg,              "NONE",    "undercurl")
call H("WarningMsg",      s:high_bg,              "NONE",    "undercurl")
call H("Ignore",          s:high_bg,              "NONE")
call H("SpecialKey",      s:primary_color,        "NONE")
call H("WhiteSpaceChar",  s:primary_color,        "NONE")
call H("WhiteSpace",      s:primary_color,        "NONE")

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
call H("Conditional",    s:foreground_color)
call H("Special",        s:foreground_color)
call H("SpecialChar",    s:foreground_color)
call H("Tag",            s:foreground_color)
call H("Delimiter",      s:val)
call H("Debug",          s:foreground_color)
call H("Repeat",         s:foreground_color)
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
