" Name:   darkscale
" Author: (me)

hi! clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "darkscale"
set termguicolors
set background=dark

" Editor UI and Syntax Highlighting
"
" group             guifg                                guibg                                 gui
hi Normal           guifg=#ffffff                  guibg=#000000                   gui=NONE
hi Comment          guifg=#c0c0c0                                              gui=italic
hi Constant         guifg=#eeeeee                                          gui=NONE
hi String           guifg=#6f6f6f                                          gui=NONE
hi Identifier       guifg=#c0c0c0                                              gui=NONE
hi Function         guifg=#ffffff                                                        gui=bold
hi Statement        guifg=#ffffff                                                        gui=bold
hi PreProc          guifg=#eeeeee                                          gui=NONE
hi Type             guifg=#ffffff                                                        gui=NONE
hi Special          guifg=#f5f5f5                                              gui=NONE
hi Operator         guifg=#eeeeee                                          gui=NONE
hi Todo                                                  guibg=#2f2f2f     gui=bold,underline
hi Error            guifg=#404040        guibg=#ff3b3b                gui=bold,undercurl
hi ErrorMsg         guifg=#404040        guibg=#ff3b3b                gui=bold,undercurl
hi WarningMsg       guibg=#8a1f1f         guibg=#f5f5f5         gui=NONE

" UI Elements
hi Cursor           guifg=#ffffff                  guibg=#f0f0f0
hi CursorLine                                            guibg=#2f2f2f
hi CursorLineNr     guifg=#b5b5b5                                          gui=bold
hi ColorColumn                                           guibg=#202020
hi Visual           guifg=#ffffff                  guibg=#3a3a3a
hi CursorColumn     guifg=NONE                           guibg=#2f2f2f         gui=NONE
hi LineNr           guifg=#404040
hi NonText          guifg=#404040
hi VertSplit        guifg=#404040        guibg=#c0c0c0
hi StatusLine       guifg=#b5b5b5    guibg=#202020         gui=bold
hi StatusLineNC     guifg=#c0c0c0        guibg=#404040         gui=NONE
hi Pmenu            guifg=#f5f5f5        guibg=#404040
hi PmenuSel         guifg=#ffffff                  guibg=#3a3a3a
hi PmenuSbar                                             guibg=#404040
hi PmenuThumb       guifg=#6f6f6f    guibg=#6f6f6f
hi Search                                                guibg=#3a3a3a
hi IncSearch        guifg=#ffffff                  guibg=#3a3a3a
hi MatchParen       guifg=#ffffff                  guibg=#2f2f2f     gui=bold
hi Folded           guibg=#1c1c1c                                          gui=NONE

" Diffs
hi DiffAdd                                               guibg=#2f2f2f
hi DiffDelete                                            guibg=#8a1f1f
hi DiffChange                                            guibg=#1c1c1c
hi DiffText         guifg=#ffffff                  guibg=#3a3a3a            gui=bold

hi SpellBad         guifg=#ff3b3b               guibg=#404040         gui=undercurl
hi SpellCap         guifg=#ff3b3b               guibg=#404040         gui=undercurl
hi SpellLocal       guifg=#ff3b3b               guibg=#404040         gui=undercurl
hi SpellRare        guifg=#ff3b3b               guibg=#404040         gui=undercurl

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
hi! EyelinerPrimary     guifg=#ffffff                                        gui=bold
hi! EyelinerSecondary   guifg=#c0c0c0                              gui=bold,italic
hi! EyelinerPrimary     guifg=#ffffff                                        gui=bold
hi! EyelinerSecondary   guifg=#c0c0c0                              gui=bold,italic
hi! SignColumn                                                      guibg=NONE
hi! LspInlayHint        guifg=#9b2d2d                       gui=bold,underdotted
hi! QuickFixLine        guifg=#f0f0f0                                    gui=bold
hi! TabLineSel          guifg=#f0f0f0                                    gui=bold
hi! TabLineFill         guifg=#f0f0f0                                    gui=bold
hi! BufferCurrent       guifg=#ffffff                                        gui=bold

let g:lsp = "#9b2d2d"
let g:lsp_bright = "#ff7a7a"
