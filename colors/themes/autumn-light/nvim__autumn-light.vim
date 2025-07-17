" Name:   active_theme
" Author: (me)

hi clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "active_theme"
set termguicolors
set background=light

" Editor UI and Syntax Highlighting
"
" group             guifg                                 guibg                                  gui
hi Normal           guifg=#000000                  guibg=#ffffff                   gui=NONE
hi Comment          guifg=#747474                                               gui=italic
hi Constant         guifg=#464646                                               gui=NONE
hi String           guifg=#d9a164                                           gui=NONE
hi Identifier       guifg=#8b4513                                           gui=NONE
hi Function         guifg=#000000                                                         gui=bold
hi Statement        guifg=#b87333                                           gui=bold
hi PreProc          guifg=#b87333                                           gui=NONE
hi Type             guifg=#8b4513                                           gui=NONE
hi Special          guifg=#d9a164                                           gui=NONE
hi Operator         guifg=#d9a164                                           gui=NONE
hi Todo                                                   guibg=#fbe7c0     gui=bold,underline
hi Error            guifg=#800400                                                      gui=bold,undercurl
hi ErrorMsg         guifg=#800400                                                      gui=undercurl
hi WarningMsg       guifg=#464646        guibg=#ffd3d3          gui=NONE

" UI Elements
hi Cursor           guifg=#000000                  guibg=#e8a447
hi CursorLine                                             guibg=#fff8e1
hi CursorLineNr     guifg=#b87333                                           gui=bold
hi ColorColumn                                            guibg=#fff8e1
hi Visual           guifg=#000000                  guibg=#f7e1c8
hi CursorColumn     guifg=NONE                            guibg=NONE                             gui=NONE
hi LineNr           guifg=#b9b9b9
hi NonText          guifg=#b9b9b9
hi VertSplit        guifg=#b9b9b9        guibg=#747474
hi StatusLine       guifg=#b87333    guibg=#eeeeee         gui=bold
hi StatusLineNC     guifg=#747474        guibg=#b9b9b9         gui=NONE
hi Pmenu            guifg=#464646        guibg=#b9b9b9
hi PmenuSel         guifg=#000000                  guibg=#f7e1c8
hi PmenuSbar                                              guibg=#b9b9b9
hi PmenuThumb       guifg=#d9a164    guibg=#d9a164
hi Search                                                 guibg=#f7e1c8
hi IncSearch        guifg=#000000                  guibg=#f7e1c8
hi MatchParen       guifg=#000000                  guibg=#fbe7c0     gui=bold

" Diffs
hi DiffAdd                                                guibg=#fbe7c0
hi DiffDelete                                             guibg=#ffd3d3
hi DiffChange                                             guibg=#fff8e1
hi DiffText         guifg=#000000                  guibg=#f7e1c8            gui=bold

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
hi EyelinerPrimary      guifg=#000000           gui=bold
hi EyelinerSecondary    guifg=#747474 gui=bold,italic

