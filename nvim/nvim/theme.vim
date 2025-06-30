" Name: plain-shane
" Author: Shane Stephenson (shaneish)
" Maintainer: stephenson.shane.a@gmail.com
" Notes: A dark monochrome colorscheme with a hint of color

let g:colorscheme_strings_as_comments = 0
let s:gray_dark = "#202020"
let s:grey = "#a6a6a6"
let s:bright_color = "#8b8000"
let s:primary_color = "#f6cd61"
let s:background_color = "#000000"
let s:foreground_color = "#ffffff"
let s:mid = "#a7a7a7"
let s:dark = "#767676"
let s:darkest = "#323232"

set background=dark

set termguicolors
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
call H("CursorLine",  "NONE", s:darkest, "NONE")

" -----------------
" - Number column -
" -----------------
call H("CursorColumn", "NONE",  "NONE", "NONE")
call H("FoldColumn",   s:mid,   "NONE", "NONE")
call H("SignColumn",   s:mid,   "NONE", "NONE")
call H("Folded",       s:mid,   "NONE", "NONE")

" -------------------------
" - Window/Tab delimiters -
" -------------------------
call H("VertSplit",   "NONE",          "NONE",      "NONE")
call H("ColorColumn", "NONE",          s:gray_dark, "NONE")
call H("TabLine",     s:mid,           "NONE",      "NONE")
call H("TabLineFill", s:primary_color, "NONE",      "NONE")
call H("TabLineSel",  s:primary_color, "NONE",      "NONE")
call H("Title",       s:primary_color, "NONE",      "NONE")

" -------------------------------
" - File Navigation / Searching -
" -------------------------------
call H("Directory", s:foreground_color, "NONE", "underline")
call H("Search",    s:background_color, s:mid, "underdashed,bold")
call H("IncSearch", s:background_color, s:mid, "underdashed,bold")
call H("CurSearch", s:background_color, s:mid, "underdouble")
call H("QuickFix",  s:primary_color,    "NONE", "underdotted")

" -----------------
" - Prompt/Status -
" -----------------
call H("StatusLine",   s:primary_color, s:gray_dark, "bold")
call H("StatusLineNC", s:primary_color, s:gray_dark, "bold")
call H("WildMenu",     s:dark,          "NONE",      "NONE")
call H("Question",     s:dark,          "NONE",      "NONE")
call H("Title",        s:dark,          "NONE",      "NONE")
call H("ModeMsg",      s:dark,          "NONE",      "NONE")
call H("MoreMsg",      s:dark,          "NONE",      "NONE")

" --------------
" - Visual aid -
" --------------
call H("MatchParen",      s:background_color,     s:foreground_color, "bold")
call H("Visual",          s:foreground_color,     s:bright_color,     "bold")
call H("VisualNOS",       s:foreground_color,     s:bright_color,     "bold")
call H("NonText",         s:bright_color,         "NONE")
call H("Todo",            s:bright_color,         "NONE",             "underline")
call H("Underlined",      s:bright_color,         "NONE")
call H("Error",           s:bright_color,         "NONE",             "undercurl")
call H("ErrorMsg",        s:bright_color,         "NONE",             "undercurl")
call H("WarningMsg",      s:bright_color,         "NONE",             "undercurl")
call H("Ignore",          s:bright_color,         "NONE")
call H("SpecialKey",      s:primary_color,        "NONE")
call H("WhiteSpaceChar",  s:primary_color,        "NONE")
call H("WhiteSpace",      s:primary_color,        "NONE")

" --------------------------------
" Variable types
" --------------------------------
call H("Constant",       s:foreground_color,       "NONE", "NONE")
call H("String",         s:foreground_color,       "NONE", "NONE")
call H("StringDelimiter",s:foreground_color,       "NONE", "NONE")
call H("Character",      s:foreground_color,       "NONE", "NONE")
call H("Number",         s:foreground_color,       "NONE", "NONE")
call H("Boolean",        s:foreground_color,       "NONE", "NONE")
call H("Float",          s:foreground_color,       "NONE", "NONE")
call H("Identifier",     s:foreground_color,       "NONE", "NONE")
call H("Function",       s:foreground_color,       "NONE", "NONE")

" --------------------------------
" Language constructs
" --------------------------------
call H("Keyword",        s:foreground_color, "NONE", "bold")
call H("Statement",      s:foreground_color, "NONE", "bold")
call H("Repeat",         s:foreground_color, "NONE", "NONE")
call H("Comment",        s:grey,             "NONE", "italic")
call H("SpecialComment", s:grey,             "NONE", "italic")
call H("Conditional",    s:foreground_color, "NONE", "bold")
call H("Special",        s:foreground_color, "NONE", "bold")
call H("SpecialChar",    s:foreground_color, "NONE", "bold")
call H("Tag",            s:foreground_color, "NONE", "bold")
call H("Delimiter",      s:foreground_color)
call H("Debug",          s:foreground_color)
call H("Repeat",         s:foreground_color)
call H("Label",          s:foreground_color)
call H("Operator",       s:foreground_color, "NONE", "bold")
call H("Exception",      s:foreground_color, "NONE", "bold")

" ----------
" - C like -
" ----------
call H("PreProc",      s:foreground_color, "NONE", "bold")
call H("Include",      s:foreground_color, "NONE", "bold")
call H("Define",       s:foreground_color, "NONE", "bold")
call H("Macro",        s:foreground_color, "NONE", "bold")
call H("PreCondit",    s:foreground_color, "NONE", "bold")
call H("Type",         s:foreground_color, "NONE", "bold")
call H("StorageClass", s:foreground_color, "NONE", "bold")
call H("Structure",    s:foreground_color, "NONE", "bold")
call H("TypeDef",      s:foreground_color, "NONE", "bold")

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

" this is just down here to remember and reference
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

