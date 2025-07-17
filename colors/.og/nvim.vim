" Name:   {{metadata.name}}
" Author: {{metadata.author}}

hi clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "{{metadata.name}}"
set termguicolors
set background={{metadata.background}}

" Editor UI and Syntax Highlighting
"
" group             guifg                                 guibg                                  gui
hi Normal           guifg=#000000                  guibg=#ffffff                   gui=NONE
hi Comment          guifg=#8e8e8e                                               gui=NONE
hi Constant         guifg=#464646                                               gui=NONE
hi String           guifg=#4d6b53                                           gui=NONE
hi Identifier       guifg=#304529                                           gui=NONE
hi Function         guifg=#000000                                                         gui=bold
hi Statement        guifg=#374f2f                                           gui=bold
hi PreProc          guifg=#374f2f                                           gui=NONE
hi Type             guifg=#304529                                           gui=NONE
hi Special          guifg=#4d6b53                                           gui=NONE
hi Operator         guifg=#4d6b53                                           gui=NONE
hi Todo                                                   guibg=#d5f5d5     gui=bold,underline
hi Error            guifg=#800400                                                      gui=bold,undercurl
hi ErrorMsg         guifg=#800400                                                      gui=undercurl
hi WarningMsg       guifg=#464646        guibg=#ffd3d3          gui=NONE

" UI Elements
hi Cursor           guifg=#000000                  guibg=#bae847
hi CursorLine                                             guibg=#f2fae9
hi CursorLineNr     guifg=#374f2f                                           gui=bold
hi ColorColumn                                            guibg=#f2fae9
hi Visual           guifg=#000000                  guibg=#ececa3
hi CursorColumn     guifg=NONE                            guibg=NONE                             gui=NONE
hi LineNr           guifg=#b9b9b9
hi NonText          guifg=#b9b9b9
hi VertSplit        guifg=#b9b9b9        guibg=#747474
hi StatusLine       guifg=#374f2f    guibg=#eeeeee         gui=bold
hi StatusLineNC     guifg=#747474        guibg=#b9b9b9         gui=NONE
hi Pmenu            guifg=#464646        guibg=#b9b9b9
hi PmenuSel         guifg=#000000                  guibg=#ececa3
hi PmenuSbar                                              guibg=#b9b9b9
hi PmenuThumb       guifg=#4d6b53    guibg=#4d6b53
hi Search                                                 guibg=#ececa3
hi IncSearch        guifg=#000000                  guibg=#ececa3
hi MatchParen       guifg=#000000                  guibg=#d5f5d5     gui=bold

" Diffs
hi DiffAdd                                                guibg=#d5f5d5
hi DiffDelete                                             guibg=#ffd3d3
hi DiffChange                                             guibg=#f2fae9
hi DiffText         guifg=#000000                  guibg=#ececa3            gui=bold

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

