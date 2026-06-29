" Name:   dark-yellow
" Author: (me)

hi! clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "dark-yellow"
set termguicolors
set background=dark

" Editor UI and Syntax Highlighting
"
" group             guifg                                guibg                                 gui
hi Normal           guifg=#f2f2f2                  guibg=#0a0a0a                   gui=NONE
hi Comment          guifg=#b0b0b0                                              gui=italic
hi Constant         guifg=#d8cd6a                                          gui=NONE
hi String           guifg=#6f6730                                          gui=NONE
hi Identifier       guifg=#b0b0b0                                              gui=NONE
hi Function         guifg=#f2f2f2                                                        gui=bold
hi Statement        guifg=#f2f2f2                                                        gui=bold
hi PreProc          guifg=#d8cd6a                                          gui=NONE
hi Type             guifg=#f2f2f2                                                        gui=NONE
hi Special          guifg=#e6e6e6                                              gui=NONE
hi Operator         guifg=#d8cd6a                                          gui=NONE
hi Todo                                                  guibg=#2f2f1c     gui=bold,underline
hi Error            guifg=#3a3a3a        guibg=#ff9a9a                gui=bold,undercurl
hi ErrorMsg         guifg=#3a3a3a        guibg=#ff9a9a                gui=bold,undercurl
hi WarningMsg       guibg=#5a1f1f         guibg=#e6e6e6         gui=NONE

" UI Elements
hi Cursor           guifg=#f2f2f2                  guibg=#c9bc5a
hi CursorLine                                            guibg=#2f2f1c
hi CursorLineNr     guifg=#a89c45                                          gui=bold
hi ColorColumn                                           guibg=#1a1a1a
hi Visual           guifg=#f2f2f2                  guibg=#2a2a1a
hi CursorColumn     guifg=NONE                           guibg=#2f2f1c         gui=NONE
hi LineNr           guifg=#3a3a3a
hi NonText          guifg=#3a3a3a
hi VertSplit        guifg=#3a3a3a        guibg=#b0b0b0
hi StatusLine       guifg=#a89c45    guibg=#1a1a1a         gui=bold
hi StatusLineNC     guifg=#b0b0b0        guibg=#3a3a3a         gui=NONE
hi Pmenu            guifg=#e6e6e6        guibg=#3a3a3a
hi PmenuSel         guifg=#f2f2f2                  guibg=#2a2a1a
hi PmenuSbar                                             guibg=#3a3a3a
hi PmenuThumb       guifg=#6f6730    guibg=#6f6730
hi Search                                                guibg=#2a2a1a
hi IncSearch        guifg=#f2f2f2                  guibg=#2a2a1a
hi MatchParen       guifg=#f2f2f2                  guibg=#2f2f1c     gui=bold
hi Folded           guibg=#1a1a12                                          gui=NONE

" Diffs
hi DiffAdd                                               guibg=#2f2f1c
hi DiffDelete                                            guibg=#5a1f1f
hi DiffChange                                            guibg=#1a1a12
hi DiffText         guifg=#f2f2f2                  guibg=#2a2a1a            gui=bold

hi SpellBad         guifg=#ff9a9a               guibg=#3a3a3a         gui=undercurl
hi SpellCap         guifg=#ff9a9a               guibg=#3a3a3a         gui=undercurl
hi SpellLocal       guifg=#ff9a9a               guibg=#3a3a3a         gui=undercurl
hi SpellRare        guifg=#ff9a9a               guibg=#3a3a3a         gui=undercurl

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
hi! LspInlayHint        guifg=#7a7335                       gui=bold,underdotted
hi! QuickFixLine        guifg=#c9bc5a                                    gui=bold
hi! TabLineSel          guifg=#c9bc5a                                    gui=bold
hi! TabLineFill         guifg=#c9bc5a                                    gui=bold
hi! BufferCurrent       guifg=#f2f2f2                                        gui=bold

let g:lsp = "#7a7335"
let g:lsp_bright = "#d8cd6a"
