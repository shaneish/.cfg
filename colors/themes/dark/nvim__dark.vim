" Name:   active_theme
" Author: (me)

hi clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "active_theme"
set termguicolors
set background=dark

" Editor UI and Syntax Highlighting
"
" group             guifg                                 guibg                                  gui
hi Normal           guifg=#ffffff                  guibg=#1e1e1e                   gui=NONE
hi Comment          guifg=#c4c4c4                                               gui=italic
hi Constant         guifg=#e6e6e6                                               gui=NONE
hi String           guifg=#7d9b83                                           gui=NONE
hi Identifier       guifg=#c2d4bc                                           gui=NONE
hi Function         guifg=#ffffff                                                         gui=bold
hi Statement        guifg=#a7c09f                                           gui=bold
hi PreProc          guifg=#a7c09f                                           gui=NONE
hi Type             guifg=#c2d4bc                                           gui=NONE
hi Special          guifg=#7d9b83                                           gui=NONE
hi Operator         guifg=#7d9b83                                           gui=NONE
hi Todo                                                   guibg=#3a573e     gui=bold,underline
hi Error            guifg=#ff4d4d                                                      gui=bold,undercurl
hi ErrorMsg         guifg=#ff4d4d                                                      gui=undercurl
hi WarningMsg       guifg=#e6e6e6        guibg=#a00000          gui=NONE

" UI Elements
hi Cursor           guifg=#ffffff                  guibg=#bae847
hi CursorLine                                             guibg=#293d2c
hi CursorLineNr     guifg=#a7c09f                                           gui=bold
hi ColorColumn                                            guibg=#293d2c
hi Visual           guifg=#ffffff                  guibg=#5e5e0a
hi CursorColumn     guifg=NONE                            guibg=NONE                             gui=NONE
hi LineNr           guifg=#6b6b6b
hi NonText          guifg=#6b6b6b
hi VertSplit        guifg=#6b6b6b        guibg=#c4c4c4
hi StatusLine       guifg=#a7c09f    guibg=#333333         gui=bold
hi StatusLineNC     guifg=#c4c4c4        guibg=#6b6b6b         gui=NONE
hi Pmenu            guifg=#e6e6e6        guibg=#6b6b6b
hi PmenuSel         guifg=#ffffff                  guibg=#5e5e0a
hi PmenuSbar                                              guibg=#6b6b6b
hi PmenuThumb       guifg=#7d9b83    guibg=#7d9b83
hi Search                                                 guibg=#5e5e0a
hi IncSearch        guifg=#ffffff                  guibg=#5e5e0a
hi MatchParen       guifg=#ffffff                  guibg=#3a573e     gui=bold

" Diffs
hi DiffAdd                                                guibg=#3a573e
hi DiffDelete                                             guibg=#a00000
hi DiffChange                                             guibg=#293d2c
hi DiffText         guifg=#ffffff                  guibg=#5e5e0a            gui=bold

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
hi EyelinerPrimary      guifg=#ffffff           gui=bold
hi EyelinerSecondary    guifg=#c4c4c4 gui=bold,italic

