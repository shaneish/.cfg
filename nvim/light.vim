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
let s:cursor_bg = "#c7e847"
let s:comment   = "#8e8e8e"
let s:accent1   = "#416741" " Green
let s:accent2   = "#304529" " Dark Green
let s:accent3   = "#4d6b53" " Gray Green (Cursor)
let s:accent4   = "#c7e847" " Bright Green
let s:error     = "#800400"
let s:warning   = "#fe6b40"
let s:dim_fg    = "#b9b9b9"
let s:ui_bg1    = "#eeeeee"
let s:ui_bg2    = "#dadada"
let s:ui_fg1    = "#374f2f"
let s:ui_fg2    = "#6c6c6c"
let s:off_white = "#f2fae9"
let s:dark_grey = "#464646"


" Editor UI and Syntax Highlighting
"
"                    ctermfg         ctermbg         guifg           guibg           cterm       gui
hi Normal            ctermfg=black   ctermbg=white   guifg=#000000   guibg=#ffffff   cterm=NONE  gui=NONE
hi Comment           ctermfg=darkgrey                guifg=#8e8e8e                   cterm=NONE  gui=NONE
hi Constant          ctermfg=darkgreen               guifg=#464646                   cterm=NONE  gui=NONE
hi String            ctermfg=darkgreen               guifg=#416741                   cterm=NONE  gui=NONE
hi Identifier        ctermfg=darkgreen               guifg=#304529                   cterm=NONE  gui=NONE
hi Function          ctermfg=black                   guifg=#000000                   cterm=bold  gui=bold
hi Statement         ctermfg=darkgreen               guifg=#374f2f                   cterm=bold  gui=bold
hi PreProc           ctermfg=darkgreen               guifg=#374f2f                   cterm=NONE  gui=NONE
hi Type              ctermfg=darkgreen               guifg=#304529                   cterm=NONE  gui=NONE
hi Special           ctermfg=darkred                 guifg=#4d6b53                   cterm=NONE  gui=NONE
hi Operator          ctermfg=darkgreen               guifg=#4d6b53                   cterm=NONE  gui=NONE
hi Todo              ctermfg=red     ctermbg=yellow                  guibg=#c7e847   cterm=bold  gui=bold,underline
hi Error             ctermfg=white   ctermbg=red                     guifg=#800400   cterm=NONE  gui=bold,undercurl
hi ErrorMsg          ctermfg=white   ctermbg=red                     guifg=#800400   cterm=NONE  gui=undercurl
hi WarningMsg        ctermfg=black   ctermbg=yellow                  guifg=#fe6b40   cterm=NONE  gui=NONE

" UI Elements
hi Cursor                                            guifg=#000000   guibg=#c7e847
hi CursorLine                        ctermbg=255     guibg=#f2fae9                   cterm=NONE
hi CursorLineNr      ctermfg=darkgreen               guifg=#374f2f                   cterm=bold  gui=bold
hi ColorColumn                       ctermbg=255     guibg=#f2fae9
hi visual                            ctermbg=255     guibg=#ececa3                   cterm=none
hi CursorColumn                                      guifg=NONE      guibg=NONE                  gui=NONE
hi LineNr            ctermfg=darkgrey                guifg=#b9b9b9
hi NonText           ctermfg=darkgrey                guifg=#b9b9b9
hi VertSplit         ctermfg=darkgrey ctermbg=darkgrey guifg=#dadada   guibg=#dadada
hi StatusLine        ctermfg=black   ctermbg=white   guifg=#374f2f   guibg=#eeeeee   cterm=bold  gui=bold
hi StatusLineNC      ctermfg=darkgrey ctermbg=white   guifg=#6c6c6c   guibg=#dadada   cterm=NONE  gui=NONE
hi Pmenu                             ctermbg=lightgrey guifg=#464646   guibg=#dadada
hi PmenuSel          ctermfg=black   ctermbg=darkgrey guifg=#000000   guibg=#ececa3
hi PmenuSbar                         ctermbg=grey    guibg=#b9b9b9
hi PmenuThumb        ctermfg=black   ctermbg=black   guifg=#4d6b53   guibg=#4d6b53
hi Search                            ctermbg=yellow  guibg=#ececa3
hi IncSearch         ctermfg=black   ctermbg=darkgreen guifg=#000000   guibg=#ececa3
hi MatchParen        ctermfg=white   ctermbg=darkgreen guifg=#000000   guibg=#ececa3   cterm=bold  gui=bold

" Diffs
hi DiffAdd                           ctermbg=darkgreen guibg=#eafaea
hi DiffDelete                        ctermbg=darkred   guibg=#ffecec
hi DiffChange                        ctermbg=darkcyan  guibg=#f2fae9
hi DiffText          ctermfg=black   ctermbg=yellow    guifg=#000000   guibg=#ececa3   cterm=bold  gui=bold

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

" Terminal Colors
if has('nvim')
    let g:terminal_color_0 = '#b9b9b9'
    let g:terminal_color_1 = '#416741'
    let g:terminal_color_2 = '#8e8e8e'
    let g:terminal_color_3 = '#800400'
    let g:terminal_color_4 = '#304529'
    let g:terminal_color_5 = '#747474'
    let g:terminal_color_6 = '#868686'
    let g:terminal_color_7 = '#464646'
    let g:terminal_color_8 = '#ababab'
    let g:terminal_color_9 = '#4a6741'
    let g:terminal_color_10 = '#8e8e8e'
    let g:terminal_color_11 = '#fe6b40'
    let g:terminal_color_12 = '#304529'
    let g:terminal_color_13 = '#747474'
    let g:terminal_color_14 = '#868686'
    let g:terminal_color_15 = '#f2fae9'
elseif has("terminal")
    let g:terminal_ansi_colors = [
        \ '#b9b9b9', '#416741', '#8e8e8e', '#800400', '#304529',
        \ '#747474', '#868686', '#464646', '#ababab', '#4a6741',
        \ '#8e8e8e', '#fe6b40', '#304529', '#747474', '#868686',
        \ '#f2fae9'
    \ ]
endif
