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
hi String           guifg=#7d5537                                           gui=NONE
hi Identifier       guifg=#d4a97f                                           gui=NONE
hi Function         guifg=#ffffff                                                         gui=bold
hi Statement        guifg=#aa7b52                                           gui=bold
hi PreProc          guifg=#aa7b52                                           gui=NONE
hi Type             guifg=#d4a97f                                           gui=NONE
hi Special          guifg=#7d5537                                           gui=NONE
hi Operator         guifg=#7d5537                                           gui=NONE
hi Todo                                                   guibg=#4a2d18     gui=bold,underline
hi Error            guifg=#ff4d4d                                                      gui=bold,undercurl
hi ErrorMsg         guifg=#ff4d4d                                                      gui=undercurl
hi WarningMsg       guifg=#e6e6e6        guibg=#a00000          gui=NONE

" UI Elements
hi Cursor           guifg=#ffffff                  guibg=#e8a447
hi CursorLine                                             guibg=#2d1a0e
hi CursorLineNr     guifg=#aa7b52                                           gui=bold
hi ColorColumn                                            guibg=#2d1a0e
hi Visual           guifg=#ffffff                  guibg=#5a3a1f
hi CursorColumn     guifg=NONE                            guibg=NONE                             gui=NONE
hi LineNr           guifg=#6b6b6b
hi NonText          guifg=#6b6b6b
hi VertSplit        guifg=#6b6b6b        guibg=#c4c4c4
hi StatusLine       guifg=#aa7b52    guibg=#333333         gui=bold
hi StatusLineNC     guifg=#c4c4c4        guibg=#6b6b6b         gui=NONE
hi Pmenu            guifg=#e6e6e6        guibg=#6b6b6b
hi PmenuSel         guifg=#ffffff                  guibg=#5a3a1f
hi PmenuSbar                                              guibg=#6b6b6b
hi PmenuThumb       guifg=#7d5537    guibg=#7d5537
hi Search                                                 guibg=#5a3a1f
hi IncSearch        guifg=#ffffff                  guibg=#5a3a1f
hi MatchParen       guifg=#ffffff                  guibg=#4a2d18     gui=bold

" Diffs
hi DiffAdd                                                guibg=#4a2d18
hi DiffDelete                                             guibg=#a00000
hi DiffChange                                             guibg=#2d1a0e
hi DiffText         guifg=#ffffff                  guibg=#5a3a1f            gui=bold

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

