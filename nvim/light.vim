" Name:        lightgreen.vim

hi clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "light"
set termguicolors
set background=light

" GUI color definitions
let s:bg        = "#ffffff"
let s:fg        = "#000000"
let s:selection = "#ececa3"
let s:cursor_bg = "#bae847"
let s:comment   = "#8e8e8e"
let s:accent1   = "#416741"
let s:accent2   = "#304529"
let s:accent3   = "#4d6b53"
let s:error     = "#800400"
let s:warning   = "#ffd3d3"
let s:dim_fg    = "#b9b9b9"
let s:ui_bg1    = "#eeeeee"
let s:ui_bg2    = "#b9b9b9"
let s:ui_fg1    = "#374f2f"
let s:ui_fg2    = "#747474"
let s:light     = "#f2fae9"
let s:off_light = "#d5f5d5"
let s:dark_grey = "#464646"


" Editor UI and Syntax Highlighting
"
"                 ctermfg    ctermbg   guifg           guibg           gui
hi Normal                              guifg=#000000   guibg=#ffffff   gui=NONE
hi Comment                             guifg=#8e8e8e                   gui=NONE
hi Constant                            guifg=#464646                   gui=NONE
hi String                              guifg=#4d6b53                   gui=NONE
hi Identifier                          guifg=#304529                   gui=NONE
hi Function                            guifg=#000000                   gui=bold
hi Statement                           guifg=#374f2f                   gui=bold
hi PreProc                             guifg=#374f2f                   gui=NONE
hi Type                                guifg=#304529                   gui=NONE
hi Special                             guifg=#4d6b53                   gui=NONE
hi Operator                            guifg=#4d6b53                   gui=NONE
hi Todo                                                guibg=#d5f5d5   gui=bold,underline
hi Error                                               guifg=#800400   gui=bold,undercurl
hi ErrorMsg                                            guifg=#800400   gui=undercurl
hi WarningMsg                          guifg=#464646   guifg=#ffd3d3   gui=NONE

" UI Elements
hi Cursor                              guifg=#000000   guibg=#bae847
hi CursorLine                                          guibg=#f2fae9
hi CursorLineNr                        guifg=#374f2f                   gui=bold
hi ColorColumn                                         guibg=#f2fae9
hi Visual                              guifg=#000000   guibg=#ececa3
hi CursorColumn                        guifg=NONE      guibg=NONE      gui=NONE
hi LineNr                              guifg=#b9b9b9
hi NonText                             guifg=#b9b9b9
hi VertSplit                           guifg=#b9b9b9   guibg=#747474
hi StatusLine                          guifg=#374f2f   guibg=#eeeeee   gui=bold
hi StatusLineNC                        guifg=#747474   guibg=#b9b9b9   gui=NONE
hi Pmenu                               guifg=#464646   guibg=#b9b9b9
hi PmenuSel                            guifg=#000000   guibg=#ececa3
hi PmenuSbar                                           guibg=#b9b9b9
hi PmenuThumb                          guifg=#4d6b53   guibg=#4d6b53
hi Search                                              guibg=#ececa3
hi IncSearch                           guifg=#000000   guibg=#ececa3
hi MatchParen                          guifg=#000000   guibg=#d5f5d5   gui=bold

" Diffs
hi DiffAdd                                             guibg=#d5f5d5
hi DiffDelete                                          guibg=#ffd3d3
hi DiffChange                                          guibg=#f2fae9
hi DiffText                                            guifg=#000000   guibg=#ececa3 gui=bold

" Linking common groups for consistency
hi! link Number Constant
hi! link Boolean Constant
hi! link Float Constant
hi! link Character Constant
hi! link Keyword Statement
hi! link Conditional Statement
hi! link Repeat Statement
hi! link Label Statement
hi! link Exception Statement
hi! link Define PreProc
hi! link Include PreProc
hi! link Macro PreProc
hi! link PreCondit PreProc
hi! link StorageClass Type
hi! link Structure Type
hi! link Typedef Type
hi! link Title Function
hi! link StatusLine CursorLine

" Plugin-specific highlights
hi EyelinerPrimary      guifg=#000000 gui=bold
hi EyelinerSecondary    guifg=#747474 gui=bold,italic

" " Terminal Colors
" if has('nvim')
"     let g:terminal_color_0 = '#b9b9b9'
"     let g:terminal_color_1 = '#416741'
"     let g:terminal_color_2 = '#8e8e8e'
"     let g:terminal_color_3 = '#800400'
"     let g:terminal_color_4 = '#304529'
"     let g:terminal_color_5 = '#747474'
"     let g:terminal_color_6 = '#868686'
"     let g:terminal_color_7 = '#464646'
"     let g:terminal_color_8 = '#ababab'
"     let g:terminal_color_9 = '#4a6741'
"     let g:terminal_color_10 = '#8e8e8e'
"     let g:terminal_color_11 = '#fe6b40'
"     let g:terminal_color_12 = '#304529'
"     let g:terminal_color_13 = '#747474'
"     let g:terminal_color_14 = '#868686'
"     let g:terminal_color_15 = '#f2fae9'
" elseif has("terminal")
"     let g:terminal_ansi_colors = [
"         \ '#b9b9b9', '#416741', '#8e8e8e', '#800400', '#304529',
"         \ '#747474', '#868686', '#464646', '#ababab', '#4a6741',
"         \ '#8e8e8e', '#fe6b40', '#304529', '#747474', '#868686',
"         \ '#f2fae9'
"     \ ]
" endif
