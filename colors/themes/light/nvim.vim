" Name:   theme
" Author: (me)

hi! clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "theme"
set termguicolors
set background=light

" Editor UI and Syntax Highlighting
"
" group             guifg                                guibg                                 gui
hi Normal           guifg=#000000                  guibg=#ffffff                   gui=NONE
hi Comment          guifg=#484848                                              gui=italic
hi Constant         guifg=#103310                                          gui=NONE
hi String           guifg=#4a704e                                          gui=NONE
hi Identifier       guifg=#484848                                              gui=NONE
hi Function         guifg=#000000                                                        gui=bold
hi Statement        guifg=#000000                                                        gui=bold
hi PreProc          guifg=#103310                                          gui=NONE
hi Type             guifg=#000000                                                        gui=NONE
hi Special          guifg=#2e2e2e                                              gui=NONE
hi Operator         guifg=#103310                                          gui=NONE
hi Todo                                                  guibg=#dce8dc     gui=bold,underline
hi Error            guifg=#bbbbbb        guibg=#a30000                gui=bold,undercurl
hi ErrorMsg         guifg=#bbbbbb        guibg=#a30000                gui=bold,undercurl
hi WarningMsg       guibg=#ffdddd         guibg=#2e2e2e         gui=NONE

" UI Elements
hi Cursor           guifg=#000000                  guibg=#b0ffb0
hi CursorLine                                            guibg=#dce8dc
hi CursorLineNr     guifg=#2a4c2a                                          gui=bold
hi CursorColumn                                           guibg=#dce8dc
hi Visual           guifg=#000000                  guibg=#e0e8b0
hi ColorColumn      guifg=NONE                           guibg=#ededed                            gui=NONE
hi LineNr           guifg=#bbbbbb
hi NonText          guifg=#bbbbbb
hi VertSplit        guifg=#bbbbbb        guibg=#484848
hi StatusLine       guifg=#2a4c2a    guibg=#ededed         gui=bold
hi StatusLineNC     guifg=#484848        guibg=#bbbbbb         gui=NONE
hi Pmenu            guifg=#2e2e2e        guibg=#bbbbbb
hi PmenuSel         guifg=#000000                  guibg=#e0e8b0
hi PmenuSbar                                             guibg=#bbbbbb
hi PmenuThumb       guifg=#4a704e    guibg=#4a704e
hi Search                                                guibg=#e0e8b0
hi IncSearch        guifg=#000000                  guibg=#e0e8b0
hi MatchParen       guifg=#000000                  guibg=#dce8dc     gui=bold
hi Folded           guibg=#f0fff0                                          gui=NONE

" Diffs
hi DiffAdd                                               guibg=#dce8dc
hi DiffDelete                                            guibg=#ffdddd
hi DiffChange                                            guibg=#f0fff0
hi DiffText         guifg=#000000                  guibg=#e0e8b0            gui=bold

hi SpellBad         guifg=#a30000               guibg=#bbbbbb         gui=undercurl
hi SpellCap         guifg=#a30000               guibg=#bbbbbb         gui=undercurl
hi SpellLocal       guifg=#a30000               guibg=#bbbbbb         gui=undercurl
hi SpellRare        guifg=#a30000               guibg=#bbbbbb         gui=undercurl

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
hi! EyelinerSecondary   guifg=#484848                              gui=bold,italic
hi! EyelinerPrimary     guifg=#000000                                        gui=bold
hi! EyelinerSecondary   guifg=#484848                              gui=bold,italic
hi! SignColumn                                                      guibg=NONE
hi! LspInlayHint        guifg=#ffaa33                       gui=bold,underdotted
hi! QuickFixLine        guifg=#b0ffb0                                    gui=bold
hi! TabLineSel          guifg=#b0ffb0                                    gui=bold
hi! TabLineFill         guifg=#b0ffb0                                    gui=bold
hi! BufferCurrent       guifg=#000000                                        gui=bold


let g:lsp = "#ffaa33"
let g:lsp_bright = "#934e00"
