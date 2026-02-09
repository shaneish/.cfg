" Name:   theme
" Author: (me)

hi! clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "theme"
set termguicolors
set background=dark

" Editor UI and Syntax Highlighting
"
" group             guifg                                guibg                                 gui
hi Normal           guifg=#ffffff                  guibg=#000000                   gui=NONE
hi Comment          guifg=#bbbbbb                                              gui=italic
hi Constant         guifg=#ffffe0                                          gui=NONE
hi String           guifg=#fce205                                          gui=NONE
hi Identifier       guifg=#bbbbbb                                              gui=NONE
hi Function         guifg=#ffffff                                                        gui=bold
hi Statement        guifg=#ffffff                                                        gui=bold
hi PreProc          guifg=#ffffe0                                          gui=NONE
hi Type             guifg=#ffffff                                                        gui=NONE
hi Special          guifg=#ededed                                              gui=NONE
hi Operator         guifg=#ffffe0                                          gui=NONE
hi Todo                                                  guibg=#695200     gui=bold,underline
hi Error            guifg=#454545        guibg=#ffdddd                gui=bold,undercurl
hi ErrorMsg         guifg=#454545        guibg=#ffdddd                gui=bold,undercurl
hi WarningMsg       guibg=#a30000         guibg=#ededed         gui=NONE

" UI Elements
hi Cursor           guifg=#ffffff                  guibg=#8c8804
hi CursorLine                                            guibg=#695200
hi CursorLineNr     guifg=#fdefb2                                          gui=bold
hi ColorColumn                                           guibg=#2f2f2f
hi Visual           guifg=#ffffff                  guibg=#5a5802
hi CursorColumn     guifg=NONE                           guibg=#695200         gui=NONE
hi LineNr           guifg=#454545
hi NonText          guifg=#454545
hi VertSplit        guifg=#454545        guibg=#bbbbbb
hi StatusLine       guifg=#fdefb2    guibg=#2f2f2f         gui=bold
hi StatusLineNC     guifg=#bbbbbb        guibg=#454545         gui=NONE
hi Pmenu            guifg=#ededed        guibg=#454545
hi PmenuSel         guifg=#ffffff                  guibg=#5a5802
hi PmenuSbar                                             guibg=#454545
hi PmenuThumb       guifg=#fce205    guibg=#fce205
hi Search                                                guibg=#5a5802
hi IncSearch        guifg=#ffffff                  guibg=#5a5802
hi MatchParen       guifg=#ffffff                  guibg=#695200     gui=bold
hi Folded           guibg=#737003                                          gui=NONE

" Diffs
hi DiffAdd                                               guibg=#695200
hi DiffDelete                                            guibg=#a30000
hi DiffChange                                            guibg=#737003
hi DiffText         guifg=#ffffff                  guibg=#5a5802            gui=bold

hi SpellBad         guifg=#ffdddd               guibg=#454545         gui=undercurl
hi SpellCap         guifg=#ffdddd               guibg=#454545         gui=undercurl
hi SpellLocal       guifg=#ffdddd               guibg=#454545         gui=undercurl
hi SpellRare        guifg=#ffdddd               guibg=#454545         gui=undercurl

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
hi! EyelinerSecondary   guifg=#bbbbbb                              gui=bold,italic
hi! EyelinerPrimary     guifg=#ffffff                                        gui=bold
hi! EyelinerSecondary   guifg=#bbbbbb                              gui=bold,italic
hi! SignColumn                                                      guibg=NONE
hi! LspInlayHint        guifg=#f4ab6a                       gui=bold,underdotted
hi! QuickFixLine        guifg=#8c8804                                    gui=bold
hi! TabLineSel          guifg=#8c8804                                    gui=bold
hi! TabLineFill         guifg=#8c8804                                    gui=bold
hi! BufferCurrent       guifg=#ffffff                                        gui=bold

let g:lsp = "#f4ab6a"
let g:lsp_bright = "#eabd8c"
