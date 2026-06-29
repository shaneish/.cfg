" Name:   dark-pink
" Author: (me)

hi! clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "dark-pink"
set termguicolors
set background=dark

" Editor UI and Syntax Highlighting
"
" group             guifg                                guibg                                 gui
hi Normal           guifg=#f2f2f2                  guibg=#0a0a0a                   gui=NONE
hi Comment          guifg=#b0b0b0                                              gui=italic
hi Constant         guifg=#d88fa3                                          gui=NONE
hi String           guifg=#6f3a4a                                          gui=NONE
hi Identifier       guifg=#b0b0b0                                              gui=NONE
hi Function         guifg=#f2f2f2                                                        gui=bold
hi Statement        guifg=#f2f2f2                                                        gui=bold
hi PreProc          guifg=#d88fa3                                          gui=NONE
hi Type             guifg=#f2f2f2                                                        gui=NONE
hi Special          guifg=#e6e6e6                                              gui=NONE
hi Operator         guifg=#d88fa3                                          gui=NONE
hi Todo                                                  guibg=#2f1c23     gui=bold,underline
hi Error            guifg=#3a3a3a        guibg=#ff9aa5                gui=bold,undercurl
hi ErrorMsg         guifg=#3a3a3a        guibg=#ff9aa5                gui=bold,undercurl
hi WarningMsg       guibg=#5a1f2a         guibg=#e6e6e6         gui=NONE

" UI Elements
hi Cursor           guifg=#f2f2f2                  guibg=#c98a9c
hi CursorLine                                            guibg=#2f1c23
hi CursorLineNr     guifg=#a85a70                                          gui=bold
hi ColorColumn                                           guibg=#1a1a1a
hi Visual           guifg=#f2f2f2                  guibg=#2a1a20
hi CursorColumn     guifg=NONE                           guibg=#2f1c23         gui=NONE
hi LineNr           guifg=#3a3a3a
hi NonText          guifg=#3a3a3a
hi VertSplit        guifg=#3a3a3a        guibg=#b0b0b0
hi StatusLine       guifg=#a85a70    guibg=#1a1a1a         gui=bold
hi StatusLineNC     guifg=#b0b0b0        guibg=#3a3a3a         gui=NONE
hi Pmenu            guifg=#e6e6e6        guibg=#3a3a3a
hi PmenuSel         guifg=#f2f2f2                  guibg=#2a1a20
hi PmenuSbar                                             guibg=#3a3a3a
hi PmenuThumb       guifg=#6f3a4a    guibg=#6f3a4a
hi Search                                                guibg=#2a1a20
hi IncSearch        guifg=#f2f2f2                  guibg=#2a1a20
hi MatchParen       guifg=#f2f2f2                  guibg=#2f1c23     gui=bold
hi Folded           guibg=#1a1215                                          gui=NONE

" Diffs
hi DiffAdd                                               guibg=#2f1c23
hi DiffDelete                                            guibg=#5a1f2a
hi DiffChange                                            guibg=#1a1215
hi DiffText         guifg=#f2f2f2                  guibg=#2a1a20            gui=bold

hi SpellBad         guifg=#ff9aa5               guibg=#3a3a3a         gui=undercurl
hi SpellCap         guifg=#ff9aa5               guibg=#3a3a3a         gui=undercurl
hi SpellLocal       guifg=#ff9aa5               guibg=#3a3a3a         gui=undercurl
hi SpellRare        guifg=#ff9aa5               guibg=#3a3a3a         gui=undercurl

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
hi! EyelinerPrimary     guifg=#f2f2f2                                        gui=bold
hi! EyelinerSecondary   guifg=#b0b0b0                              gui=bold,italic
hi! EyelinerPrimary     guifg=#f2f2f2                                        gui=bold
hi! EyelinerSecondary   guifg=#b0b0b0                              gui=bold,italic
hi! SignColumn                                                      guibg=NONE
hi! LspInlayHint        guifg=#7a3f4d                       gui=bold,underdotted
hi! QuickFixLine        guifg=#c98a9c                                    gui=bold
hi! TabLineSel          guifg=#c98a9c                                    gui=bold
hi! TabLineFill         guifg=#c98a9c                                    gui=bold
hi! BufferCurrent       guifg=#f2f2f2                                        gui=bold

let g:lsp = "#7a3f4d"
let g:lsp_bright = "#d88fa3"
