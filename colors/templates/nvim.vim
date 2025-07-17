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
hi Normal           guifg=#{{colors.fg}}                  guibg=#{{colors.bg}}                   gui=NONE
hi Comment          guifg=#{{colors.gray_scale_4}}                                               gui=italic
hi Constant         guifg=#{{colors.gray_scale_5}}                                               gui=NONE
hi String           guifg=#{{colors.palette_accent_3}}                                           gui=NONE
hi Identifier       guifg=#{{colors.palette_accent_5}}                                           gui=NONE
hi Function         guifg=#{{colors.fg}}                                                         gui=bold
hi Statement        guifg=#{{colors.palette_accent_4}}                                           gui=bold
hi PreProc          guifg=#{{colors.palette_accent_4}}                                           gui=NONE
hi Type             guifg=#{{colors.palette_accent_5}}                                           gui=NONE
hi Special          guifg=#{{colors.palette_accent_3}}                                           gui=NONE
hi Operator         guifg=#{{colors.palette_accent_3}}                                           gui=NONE
hi Todo                                                   guibg=#{{colors.palette_accent_2}}     gui=bold,underline
hi Error            guifg=#{{colors.alert}}                                                      gui=bold,undercurl
hi ErrorMsg         guifg=#{{colors.alert}}                                                      gui=undercurl
hi WarningMsg       guifg=#{{colors.gray_scale_5}}        guibg=#{{colors.minor_alert}}          gui=NONE

" UI Elements
hi Cursor           guifg=#{{colors.fg}}                  guibg=#{{colors.cursor}}
hi CursorLine                                             guibg=#{{colors.palette_accent_1}}
hi CursorLineNr     guifg=#{{colors.palette_accent_4}}                                           gui=bold
hi ColorColumn                                            guibg=#{{colors.palette_accent_1}}
hi Visual           guifg=#{{colors.fg}}                  guibg=#{{colors.selection}}
hi CursorColumn     guifg=NONE                            guibg=NONE                             gui=NONE
hi LineNr           guifg=#{{colors.gray_scale_2}}
hi NonText          guifg=#{{colors.gray_scale_2}}
hi VertSplit        guifg=#{{colors.gray_scale_2}}        guibg=#{{colors.gray_scale_4}}
hi StatusLine       guifg=#{{colors.palette_accent_4}}    guibg=#{{colors.gray_scale_1}}         gui=bold
hi StatusLineNC     guifg=#{{colors.gray_scale_4}}        guibg=#{{colors.gray_scale_2}}         gui=NONE
hi Pmenu            guifg=#{{colors.gray_scale_5}}        guibg=#{{colors.gray_scale_2}}
hi PmenuSel         guifg=#{{colors.fg}}                  guibg=#{{colors.selection}}
hi PmenuSbar                                              guibg=#{{colors.gray_scale_2}}
hi PmenuThumb       guifg=#{{colors.palette_accent_3}}    guibg=#{{colors.palette_accent_3}}
hi Search                                                 guibg=#{{colors.selection}}
hi IncSearch        guifg=#{{colors.fg}}                  guibg=#{{colors.selection}}
hi MatchParen       guifg=#{{colors.fg}}                  guibg=#{{colors.palette_accent_2}}     gui=bold

" Diffs
hi DiffAdd                                                guibg=#{{colors.palette_accent_2}}
hi DiffDelete                                             guibg=#{{colors.minor_alert}}
hi DiffChange                                             guibg=#{{colors.palette_accent_1}}
hi DiffText         guifg=#{{colors.fg}}                  guibg=#{{colors.selection}}            gui=bold

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
hi EyelinerPrimary      guifg=#{{colors.fg}}           gui=bold
hi EyelinerSecondary    guifg=#{{colors.gray_scale_4}} gui=bold,italic

