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
let s:bright_yellow = "#ffd700"
let s:light_gray = "#cdcdcd"
let s:light_yellow = "#fcfca9"
let s:gray_d = "#3d3d3d"
let s:gray_dd = "#515151"
let s:gray_y = "#777777"
let s:gray_dark = "#202020"
let s:gray_dish = "#636363"

let s:string_type = s:gray_dd
let s:string_bg = "NONE"
let s:high_fg = s:gray_dark
let s:high_bg = s:norm
let s:search_fg = "NONE"
let s:search_bg = "NONE"
let s:search_gui = "underdashed,bold"
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
call H("Normal", s:norm, "#000000")
call H("Cursor", s:norm)
call H("LineNr", s:gray_d)
call H("CursorLineNR", s:norm, "#000000", "bold,underline")
call H("CursorLine",  s:norm, s:gray_dark)

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
call H("TabLine",     s:gray,          "NONE",      "NONE")
call H("TabLineFill", s:bright_yellow, "NONE",      "NONE")
call H("TabLineSel",  s:bright_yellow, "NONE",      "NONE")

" -------------------------------
" - File Navigation / Searching -
" -------------------------------
call H("Directory", s:norm, "NONE", "underline")
call H("Search",    s:search_fg, s:search_bg, s:search_gui)
call H("IncSearch", s:search_fg, s:search_bg, s:search_gui)
call H("CurSearch", s:search_fg, s:search_bg, "underdouble")
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
call H("MatchParen",      s:high_fg,              s:gray_dish)
call H("Visual",          s:high_fg,              s:beige, "bold")
call H("VisualNOS",       s:high_fg,              s:beige, "bold")
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
call H("Constant",       s:gray_y,       "NONE")
call H("String",         s:string_type,  s:comments_bg, "bold")
call H("StringDelimiter",s:norm,  s:comments_bg, "bold")
call H("Character",      s:gray_y,       "NONE")
call H("Number",         s:gray_y,       "NONE")
call H("Boolean",        s:gray_y,       "NONE")
call H("Float",          s:gray_y,       "NONE")
call H("Identifier",     s:norm,        "NONE")
call H("Function",       s:norm,        "NONE")

" --------------------------------
" Language constructs
" --------------------------------
call H("Keyword",        s:gray_dish)
call H("Statement",      s:norm)
call H("Repeat",         s:norm)
call H("Comment",        s:comments_fg,   s:comments_bg, "italic")
call H("SpecialComment", s:comments_fg,   s:comments_bg, "italic")
call H("Conditional",    s:norm)
call H("Special",        s:norm)
call H("SpecialChar",    s:norm)
call H("Tag",            s:norm)
call H("Delimiter",      s:norm)
call H("Debug",          s:norm)
call H("Repeat",         s:norm)
call H("Label",          s:norm)
call H("Operator",       s:gray_dish)
call H("Exception",      s:gray_dish)

" ----------
" - C like -
" ----------
call H("PreProc", s:gray_dish)
call H("Include", s:gray_dish)
call H("Define", s:gray_dish)
call H("Macro", s:gray_dish)
call H("PreCondit", s:gray_dish)
call H("Type", s:gray_dish)
call H("StorageClass", s:gray_dish)
call H("Structure", s:gray_dish)
call H("TypeDef", s:gray_dish)

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
