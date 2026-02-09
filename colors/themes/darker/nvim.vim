" Name:   theme
" Author: (me)

hi! clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "theme"
set termguicolors
set background=darker

" Editor UI and Syntax Highlighting
"
" group             guifg                                guibg                                 gui
hi Normal           guifg=#f2f2f2                  guibg=#050505                   gui=NONE
hi Comment          guifg=#cfcfcf                                              gui=italic
hi Constant         guifg=#f4efb2                                          gui=NONE
hi String           guifg=#c9b83a                                          gui=NONE
hi Identifier       guifg=#cfcfcf                                              gui=NONE
hi Function         guifg=#f2f2f2                                                        gui=bold
hi Statement        guifg=#f2f2f2                                                        gui=bold
hi PreProc          guifg=#f4efb2                                          gui=NONE
hi Type             guifg=#f2f2f2                                                        gui=NONE
hi Special          guifg=#ffffff                                              gui=NONE
hi Operator         guifg=#f4efb2                                          gui=NONE
hi Todo                                                  guibg=#8a7f2a     gui=bold,underline
hi Error            guifg=#3a3a3a        guibg=#ffb3b3                gui=bold,undercurl
hi ErrorMsg         guifg=#3a3a3a        guibg=#ffb3b3                gui=bold,undercurl
hi WarningMsg       guibg=#d64b4b         guibg=#ffffff         gui=NONE

" UI Elements
hi Cursor           guifg=#f2f2f2                  guibg=#c9b83a
hi CursorLine                                            guibg=#8a7f2a
hi CursorLineNr     guifg=#e3d36a                                          gui=bold
hi ColorColumn                                           guibg=#171717
hi Visual           guifg=#f2f2f2                  guibg=#1f1f1f
hi CursorColumn     guifg=NONE                           guibg=#8a7f2a         gui=NONE
hi LineNr           guifg=#3a3a3a
hi NonText          guifg=#3a3a3a
hi VertSplit        guifg=#3a3a3a        guibg=#cfcfcf
hi StatusLine       guifg=#e3d36a    guibg=#171717         gui=bold
hi StatusLineNC     guifg=#cfcfcf        guibg=#3a3a3a         gui=NONE
hi Pmenu            guifg=#ffffff        guibg=#3a3a3a
hi PmenuSel         guifg=#f2f2f2                  guibg=#1f1f1f
hi PmenuSbar                                             guibg=#3a3a3a
hi PmenuThumb       guifg=#c9b83a    guibg=#c9b83a
hi Search                                                guibg=#1f1f1f
hi IncSearch        guifg=#f2f2f2                  guibg=#1f1f1f
hi MatchParen       guifg=#f2f2f2                  guibg=#8a7f2a     gui=bold
hi Folded           guibg=#6f6821                                          gui=NONE

" Diffs
hi DiffAdd                                               guibg=#8a7f2a
hi DiffDelete                                            guibg=#d64b4b
hi DiffChange                                            guibg=#6f6821
hi DiffText         guifg=#f2f2f2                  guibg=#1f1f1f            gui=bold

hi SpellBad         guifg=#ffb3b3               guibg=#3a3a3a         gui=undercurl
hi SpellCap         guifg=#ffb3b3               guibg=#3a3a3a         gui=undercurl
hi SpellLocal       guifg=#ffb3b3               guibg=#3a3a3a         gui=undercurl
hi SpellRare        guifg=#ffb3b3               guibg=#3a3a3a         gui=undercurl

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
hi! EyelinerSecondary   guifg=#cfcfcf                              gui=bold,italic
hi! EyelinerPrimary     guifg=#f2f2f2                                        gui=bold
hi! EyelinerSecondary   guifg=#cfcfcf                              gui=bold,italic
hi! SignColumn                                                      guibg=NONE
hi! LspInlayHint        guifg=#8f8630                       gui=bold,underdotted
hi! QuickFixLine        guifg=#c9b83a                                    gui=bold
hi! TabLineSel          guifg=#c9b83a                                    gui=bold
hi! TabLineFill         guifg=#c9b83a                                    gui=bold
hi! BufferCurrent       guifg=#f2f2f2                                        gui=bold

let g:lsp = "#8f8630"
let g:lsp_bright = "#d8c65a"
