" Name:   lightscale
" Author: (me)

hi! clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "lightscale"
set termguicolors
set background=light

" Editor UI and Syntax Highlighting
"
" group             guifg                                guibg                                 gui
hi Normal           guifg=#000000                  guibg=#ffffff                   gui=NONE
hi Comment          guifg=#808080                                              gui=italic
hi Constant         guifg=#3c3926                                          gui=NONE
hi String           guifg=#6d6644                                          gui=NONE
hi Identifier       guifg=#808080                                              gui=NONE
hi Function         guifg=#000000                                                        gui=bold
hi Statement        guifg=#000000                                                        gui=bold
hi PreProc          guifg=#3c3926                                          gui=NONE
hi Type             guifg=#000000                                                        gui=NONE
hi Special          guifg=#0a0a0a                                              gui=NONE
hi Operator         guifg=#3c3926                                          gui=NONE
hi Todo                                                  guibg=#fff9d8     gui=bold,underline
hi Error            guifg=#cecece        guibg=#c40000                gui=bold,undercurl
hi ErrorMsg         guifg=#cecece        guibg=#c40000                gui=bold,undercurl
hi WarningMsg       guibg=#ffb3b3         guibg=#0a0a0a         gui=NONE

" UI Elements
hi Cursor           guifg=#000000                  guibg=#ffd700
hi CursorLine                                            guibg=#fff9d8
hi CursorLineNr     guifg=#555035                                          gui=bold
hi ColorColumn                                           guibg=#f6f6f6
hi Visual           guifg=#000000                  guibg=#d0d0d0
hi CursorColumn     guifg=NONE                           guibg=#fff9d8         gui=NONE
hi LineNr           guifg=#cecece
hi NonText          guifg=#cecece
hi VertSplit        guifg=#cecece        guibg=#808080
hi StatusLine       guifg=#555035    guibg=#f6f6f6         gui=bold
hi StatusLineNC     guifg=#808080        guibg=#cecece         gui=NONE
hi Pmenu            guifg=#0a0a0a        guibg=#cecece
hi PmenuSel         guifg=#000000                  guibg=#d0d0d0
hi PmenuSbar                                             guibg=#cecece
hi PmenuThumb       guifg=#6d6644    guibg=#6d6644
hi Search                                                guibg=#d0d0d0
hi IncSearch        guifg=#000000                  guibg=#d0d0d0
hi MatchParen       guifg=#000000                  guibg=#fff9d8     gui=bold
hi Folded           guibg=#fff3b1                                          gui=NONE

" Diffs
hi DiffAdd                                               guibg=#fff9d8
hi DiffDelete                                            guibg=#ffb3b3
hi DiffChange                                            guibg=#fff3b1
hi DiffText         guifg=#000000                  guibg=#d0d0d0            gui=bold

hi SpellBad         guifg=#c40000               guibg=#cecece         gui=undercurl
hi SpellCap         guifg=#c40000               guibg=#cecece         gui=undercurl
hi SpellLocal       guifg=#c40000               guibg=#cecece         gui=undercurl
hi SpellRare        guifg=#c40000               guibg=#cecece         gui=undercurl

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
hi! EyelinerPrimary     guifg=#000000                                        gui=bold
hi! EyelinerSecondary   guifg=#808080                              gui=bold,italic
hi! EyelinerPrimary     guifg=#000000                                        gui=bold
hi! EyelinerSecondary   guifg=#808080                              gui=bold,italic
hi! SignColumn                                                      guibg=NONE
hi! LspInlayHint        guifg=#b04a4a                       gui=bold,underdotted
hi! QuickFixLine        guifg=#ffd700                                    gui=bold
hi! TabLineSel          guifg=#ffd700                                    gui=bold
hi! TabLineFill         guifg=#ffd700                                    gui=bold
hi! BufferCurrent       guifg=#000000                                        gui=bold

let g:lsp = "#b04a4a"
let g:lsp_bright = "#c40000"
