
function! SetWarlockTheme()
    "
    " since this is a vim-only no-plugin config meant to be fast to open (used for
    " scrollback and servers), I had to ditch my clean colorscheming via plugin.
    " to fix this (since i obviously can't possibly not use a bland colorscheme),
    " i've simply copied the colorscheme i use (warlock) into this config file
    " directly.  thank you martin hardselius for enabling my laziness, may u
    " forever be blessed with good fortune and a lack of vimscript errors.
    "

    " warlock.vim -- Vim color scheme.
    " Author:      Martin Hardselius (martin.hardselius@gmail.com)
    " Webpage:     https://github.com/hardselius/warlock
    " Description: A grayscale variant of Apprentice by Romain Lafourcade (romainlafourcade@gmail.com)
    " Last Change: 2020-03-04

    hi clear
    if exists("syntax_on")
      syntax reset
    endif

    let colors_name = "warlock"

    if ($TERM =~ '256' || &t_Co >= 256) || has("gui_running")
        hi Normal ctermbg=235 ctermfg=250 cterm=NONE guibg=#262626 guifg=#bcbcbc gui=NONE
        hi NonText ctermbg=NONE ctermfg=240 cterm=NONE guibg=NONE guifg=#585858 gui=NONE
        hi EndOfBuffer ctermbg=NONE ctermfg=240 cterm=NONE guibg=NONE guifg=#585858 gui=NONE
        hi LineNr ctermbg=234 ctermfg=242 cterm=NONE guibg=#1c1c1c guifg=#6c6c6c gui=NONE
        hi FoldColumn ctermbg=234 ctermfg=242 cterm=NONE guibg=#1c1c1c guifg=#6c6c6c gui=NONE
        hi Folded ctermbg=234 ctermfg=242 cterm=NONE guibg=#1c1c1c guifg=#6c6c6c gui=NONE
        hi MatchParen ctermbg=234 ctermfg=231 cterm=NONE guibg=#1c1c1c guifg=#ffffff gui=NONE
        hi SignColumn ctermbg=234 ctermfg=242 cterm=NONE guibg=#1c1c1c guifg=#6c6c6c gui=NONE
        hi Comment ctermbg=NONE ctermfg=240 cterm=NONE guibg=NONE guifg=#585858 gui=NONE
        hi Conceal ctermbg=NONE ctermfg=250 cterm=NONE guibg=NONE guifg=#bcbcbc gui=NONE
        hi Constant ctermbg=NONE ctermfg=247 cterm=NONE guibg=NONE guifg=#9e9e9e gui=NONE
        hi Error ctermbg=NONE ctermfg=243 cterm=reverse guibg=NONE guifg=#767676 gui=reverse
        hi Identifier ctermbg=NONE ctermfg=244 cterm=NONE guibg=NONE guifg=#808080 gui=NONE
        hi Ignore ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
        hi PreProc ctermbg=NONE ctermfg=243 cterm=NONE guibg=NONE guifg=#767676 gui=NONE
        hi Special ctermbg=NONE ctermfg=243 cterm=NONE guibg=NONE guifg=#767676 gui=NONE
        hi Statement ctermbg=NONE ctermfg=248 cterm=NONE guibg=NONE guifg=#a8a8a8 gui=NONE
        hi String ctermbg=NONE ctermfg=247 cterm=NONE guibg=NONE guifg=#9e9e9e gui=NONE
        hi Todo ctermbg=NONE ctermfg=NONE cterm=reverse guibg=NONE guifg=NONE gui=reverse
        hi Type ctermbg=NONE ctermfg=245 cterm=NONE guibg=NONE guifg=#8a8a8a gui=NONE
        hi Underlined ctermbg=NONE ctermfg=243 cterm=underline guibg=NONE guifg=#767676 gui=underline
        hi Pmenu ctermbg=238 ctermfg=250 cterm=NONE guibg=#444444 guifg=#bcbcbc gui=NONE
        hi PmenuSbar ctermbg=240 ctermfg=NONE cterm=NONE guibg=#585858 guifg=NONE gui=NONE
        hi PmenuSel ctermbg=243 ctermfg=235 cterm=NONE guibg=#767676 guifg=#262626 gui=NONE
        hi PmenuThumb ctermbg=243 ctermfg=243 cterm=NONE guibg=#767676 guifg=#767676 gui=NONE
        hi ErrorMsg ctermbg=243 ctermfg=235 cterm=NONE guibg=#767676 guifg=#262626 gui=NONE
        hi ModeMsg ctermbg=247 ctermfg=235 cterm=NONE guibg=#9e9e9e guifg=#262626 gui=NONE
        hi MoreMsg ctermbg=NONE ctermfg=243 cterm=NONE guibg=NONE guifg=#767676 gui=NONE
        hi Question ctermbg=NONE ctermfg=247 cterm=NONE guibg=NONE guifg=#9e9e9e gui=NONE
        hi WarningMsg ctermbg=NONE ctermfg=243 cterm=NONE guibg=NONE guifg=#767676 gui=NONE
        hi TabLine ctermbg=238 ctermfg=244 cterm=NONE guibg=#444444 guifg=#808080 gui=NONE
        hi TabLineFill ctermbg=238 ctermfg=238 cterm=NONE guibg=#444444 guifg=#444444 gui=NONE
        hi TabLineSel ctermbg=244 ctermfg=235 cterm=NONE guibg=#808080 guifg=#262626 gui=NONE
        hi ToolbarLine ctermbg=234 ctermfg=NONE cterm=NONE guibg=#1c1c1c guifg=NONE gui=NONE
        hi ToolbarButton ctermbg=240 ctermfg=250 cterm=NONE guibg=#585858 guifg=#bcbcbc gui=NONE
        hi Cursor ctermbg=242 ctermfg=NONE cterm=NONE guibg=#6c6c6c guifg=NONE gui=NONE
        hi CursorColumn ctermbg=236 ctermfg=NONE cterm=NONE guibg=#303030 guifg=NONE gui=NONE
        hi CursorLineNr ctermbg=236 ctermfg=246 cterm=NONE guibg=#303030 guifg=#949494 gui=NONE
        hi CursorLine ctermbg=236 ctermfg=NONE cterm=NONE guibg=#303030 guifg=NONE gui=NONE
        hi helpLeadBlank ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
        hi helpNormal ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE
        hi StatusLine ctermbg=244 ctermfg=235 cterm=NONE guibg=#808080 guifg=#262626 gui=NONE
        hi StatusLineNC ctermbg=238 ctermfg=244 cterm=NONE guibg=#444444 guifg=#808080 gui=NONE
        hi StatusLineTerm ctermbg=244 ctermfg=235 cterm=NONE guibg=#808080 guifg=#262626 gui=NONE
        hi StatusLineTermNC ctermbg=238 ctermfg=244 cterm=NONE guibg=#444444 guifg=#808080 gui=NONE
        hi Visual ctermbg=235 ctermfg=248 cterm=reverse guibg=#262626 guifg=#a8a8a8 gui=reverse
        hi VisualNOS ctermbg=NONE ctermfg=NONE cterm=underline guibg=NONE guifg=NONE gui=underline
        hi VertSplit ctermbg=238 ctermfg=238 cterm=NONE guibg=#444444 guifg=#444444 gui=NONE
        hi WildMenu ctermbg=248 ctermfg=235 cterm=NONE guibg=#a8a8a8 guifg=#262626 gui=NONE
        hi Function ctermbg=NONE ctermfg=231 cterm=NONE guibg=NONE guifg=#ffffff gui=NONE
        hi SpecialKey ctermbg=NONE ctermfg=240 cterm=NONE guibg=NONE guifg=#585858 gui=NONE
        hi Title ctermbg=NONE ctermfg=231 cterm=NONE guibg=NONE guifg=#ffffff gui=NONE
        hi DiffAdd ctermbg=235 ctermfg=247 cterm=reverse guibg=#262626 guifg=#9e9e9e gui=reverse
        hi DiffChange ctermbg=235 ctermfg=245 cterm=reverse guibg=#262626 guifg=#8a8a8a gui=reverse
        hi DiffDelete ctermbg=235 ctermfg=243 cterm=reverse guibg=#262626 guifg=#767676 gui=reverse
        hi DiffText ctermbg=235 ctermfg=247 cterm=reverse guibg=#262626 guifg=#9e9e9e gui=reverse
        hi IncSearch ctermbg=243 ctermfg=235 cterm=NONE guibg=#767676 guifg=#262626 gui=NONE
        hi Search ctermbg=231 ctermfg=235 cterm=NONE guibg=#ffffff guifg=#262626 gui=NONE
        hi Directory ctermbg=NONE ctermfg=246 cterm=NONE guibg=NONE guifg=#949494 gui=NONE
        hi debugPC ctermbg=244 ctermfg=NONE cterm=NONE guibg=#808080 guifg=NONE gui=NONE
        hi debugBreakpoint ctermbg=243 ctermfg=NONE cterm=NONE guibg=#767676 guifg=NONE gui=NONE
        hi SpellBad ctermbg=NONE ctermfg=243 cterm=undercurl guibg=NONE guifg=#767676 gui=undercurl guisp=#767676
        hi SpellCap ctermbg=NONE ctermfg=246 cterm=undercurl guibg=NONE guifg=#949494 gui=undercurl guisp=#949494
        hi SpellLocal ctermbg=NONE ctermfg=243 cterm=undercurl guibg=NONE guifg=#767676 gui=undercurl guisp=#767676
        hi SpellRare ctermbg=NONE ctermfg=247 cterm=undercurl guibg=NONE guifg=#9e9e9e gui=undercurl guisp=#9e9e9e
        hi ColorColumn ctermbg=234 ctermfg=NONE cterm=NONE guibg=#1c1c1c guifg=NONE gui=NONE

    elseif &t_Co == 8 || $TERM !~# '^linux' || &t_Co == 16
        set t_Co=16

        hi Normal ctermbg=black ctermfg=lightgrey cterm=NONE
        hi NonText ctermbg=NONE ctermfg=darkgrey cterm=NONE
        hi EndOfBuffer ctermbg=NONE ctermfg=darkgrey cterm=NONE
        hi LineNr ctermbg=black ctermfg=lightgrey cterm=NONE
        hi FoldColumn ctermbg=black ctermfg=lightgrey cterm=NONE
        hi Folded ctermbg=black ctermfg=lightgrey cterm=NONE
        hi MatchParen ctermbg=black ctermfg=white cterm=NONE
        hi SignColumn ctermbg=black ctermfg=lightgrey cterm=NONE
        hi Comment ctermbg=NONE ctermfg=darkgrey cterm=NONE
        hi Conceal ctermbg=NONE ctermfg=lightgrey cterm=NONE
        hi Constant ctermbg=NONE ctermfg=lightgrey cterm=NONE
        hi Error ctermbg=NONE ctermfg=lightgrey cterm=reverse
        hi Identifier ctermbg=NONE ctermfg=lightgrey cterm=NONE
        hi Ignore ctermbg=NONE ctermfg=NONE cterm=NONE
        hi PreProc ctermbg=NONE ctermfg=lightgrey cterm=NONE
        hi Special ctermbg=NONE ctermfg=lightgrey cterm=NONE
        hi Statement ctermbg=NONE ctermfg=lightgrey cterm=NONE
        hi String ctermbg=NONE ctermfg=lightgrey cterm=NONE
        hi Todo ctermbg=NONE ctermfg=NONE cterm=reverse
        hi Type ctermbg=NONE ctermfg=lightgrey cterm=NONE
        hi Underlined ctermbg=NONE ctermfg=lightgrey cterm=underline
        hi Pmenu ctermbg=darkgrey ctermfg=lightgrey cterm=NONE
        hi PmenuSbar ctermbg=darkgrey ctermfg=NONE cterm=NONE
        hi PmenuSel ctermbg=lightgrey ctermfg=black cterm=NONE
        hi PmenuThumb ctermbg=lightgrey ctermfg=lightgrey cterm=NONE
        hi ErrorMsg ctermbg=lightgrey ctermfg=black cterm=NONE
        hi ModeMsg ctermbg=lightgrey ctermfg=black cterm=NONE
        hi MoreMsg ctermbg=NONE ctermfg=lightgrey cterm=NONE
        hi Question ctermbg=NONE ctermfg=lightgrey cterm=NONE
        hi WarningMsg ctermbg=NONE ctermfg=lightgrey cterm=NONE
        hi TabLine ctermbg=darkgrey ctermfg=lightgray cterm=NONE
        hi TabLineFill ctermbg=darkgrey ctermfg=darkgrey cterm=NONE
        hi TabLineSel ctermbg=lightgray ctermfg=black cterm=NONE
        hi ToolbarLine ctermbg=black ctermfg=NONE cterm=NONE
        hi ToolbarButton ctermbg=darkgrey ctermfg=lightgrey cterm=NONE
        hi Cursor ctermbg=lightgrey ctermfg=NONE cterm=NONE
        hi CursorColumn ctermbg=darkgrey ctermfg=NONE cterm=NONE
        hi CursorLineNr ctermbg=darkgrey ctermfg=lightgrey cterm=NONE
        hi CursorLine ctermbg=darkgrey ctermfg=NONE cterm=NONE
        hi helpLeadBlank ctermbg=NONE ctermfg=NONE cterm=NONE
        hi helpNormal ctermbg=NONE ctermfg=NONE cterm=NONE
        hi StatusLine ctermbg=lightgray ctermfg=black cterm=NONE
        hi StatusLineNC ctermbg=darkgrey ctermfg=lightgray cterm=NONE
        hi StatusLineTerm ctermbg=lightgray ctermfg=black cterm=NONE
        hi StatusLineTermNC ctermbg=darkgrey ctermfg=lightgray cterm=NONE
        hi Visual ctermbg=black ctermfg=lightgrey cterm=reverse
        hi VisualNOS ctermbg=NONE ctermfg=NONE cterm=underline
        hi VertSplit ctermbg=darkgrey ctermfg=darkgrey cterm=NONE
        hi WildMenu ctermbg=lightgrey ctermfg=black cterm=NONE
        hi Function ctermbg=NONE ctermfg=white cterm=NONE
        hi SpecialKey ctermbg=NONE ctermfg=darkgrey cterm=NONE
        hi Title ctermbg=NONE ctermfg=white cterm=NONE
        hi DiffAdd ctermbg=black ctermfg=lightgrey cterm=reverse
        hi DiffChange ctermbg=black ctermfg=lightgrey cterm=reverse
        hi DiffDelete ctermbg=black ctermfg=lightgrey cterm=reverse
        hi DiffText ctermbg=black ctermfg=lightgrey cterm=reverse
        hi IncSearch ctermbg=lightgrey ctermfg=black cterm=NONE
        hi Search ctermbg=white ctermfg=black cterm=NONE
        hi Directory ctermbg=NONE ctermfg=lightgrey cterm=NONE
        hi debugPC ctermbg=lightgrey ctermfg=NONE cterm=NONE
        hi debugBreakpoint ctermbg=lightgrey ctermfg=NONE cterm=NONE
        hi SpellBad ctermbg=NONE ctermfg=lightgrey cterm=undercurl
        hi SpellCap ctermbg=NONE ctermfg=lightgrey cterm=undercurl
        hi SpellLocal ctermbg=NONE ctermfg=lightgrey cterm=undercurl
        hi SpellRare ctermbg=NONE ctermfg=lightgrey cterm=undercurl
        hi ColorColumn ctermbg=black ctermfg=NONE cterm=NONE
    endif

    hi link Terminal Normal
    hi link Number Constant
    hi link CursorIM Cursor
    hi link Boolean Constant
    hi link Character Constant
    hi link Conditional Statement
    hi link Debug Special
    hi link Define PreProc
    hi link Delimiter Special
    hi link Exception Statement
    hi link Float Number
    hi link HelpCommand Statement
    hi link HelpExample Statement
    hi link Include PreProc
    hi link Keyword Statement
    hi link Label Statement
    hi link Macro PreProc
    hi link Number Constant
    hi link Operator Statement
    hi link PreCondit PreProc
    hi link Repeat Statement
    hi link SpecialChar Special
    hi link SpecialComment Special
    hi link StorageClass Type
    hi link Structure Type
    hi link Tag Special
    hi link Terminal Normal
    hi link Typedef Type
    hi link htmlEndTag htmlTagName
    hi link htmlLink Function
    hi link htmlSpecialTagName htmlTagName
    hi link htmlTag htmlTagName
    hi link htmlBold Normal
    hi link htmlItalic Normal
    hi link xmlTag Statement
    hi link xmlTagName Statement
    hi link xmlEndTag Statement
    hi link markdownItalic Preproc
    hi link asciidocQuotedEmphasized Preproc
    hi link diffBDiffer WarningMsg
    hi link diffCommon WarningMsg
    hi link diffDiffer WarningMsg
    hi link diffIdentical WarningMsg
    hi link diffIsA WarningMsg
    hi link diffNoEOL WarningMsg
    hi link diffOnly WarningMsg
    hi link diffRemoved WarningMsg
    hi link diffAdded String
    hi link QuickFixLine Search

    let g:terminal_ansi_colors = [
            \ '#1c1c1c',
            \ '#767676',
            \ '#767676',
            \ '#808080',
            \ '#808080',
            \ '#626262',
            \ '#767676',
            \ '#6c6c6c',
            \ '#444444',
            \ '#9e9e9e',
            \ '#9e9e9e',
            \ '#ffffff',
            \ '#a8a8a8',
            \ '#8a8a8a',
            \ '#949494',
            \ '#ffffff',
            \ ]
endfunction

" Generated with RNB (https://github.com/romainl/vim-rnb)
filetype plugin indent on
let mapleader=" "
set termguicolors

" #globalvars ish
let g:indentLine_char = '▏'
let g:indentLine_defaultGroup = 'NonText'
let g:conceallevel = 0
let g:code_block_suffix = "%%"
let g:code_block_comment = substitute(substitute(&commentstring, '%s', ' ', 'g'), '\s\+', '', 'g')
let g:code_block_type_annotation = ""
let g:code_block_type_annotation_priority = ["", "python", "sql", "json", "rust", "scala", "lua", "sh", "vim", "r", "console", "toml", "yaml"]
let g:code_block_non_comment_file_types = {"md": "```", "markdown": "```", "rmd": "```", "journal": "```", "rmarkdown": "```"}
let g:code_block_is_databricks_notebook = 0
let g:code_block_databricks_notebook_no_end = 0
let g:code_block_databricks_notebook_suffix = "COMMAND ----------"
let s:centerize=1
let g:term_proportion_default = 2.5
let g:term_lines_to_resize = 40
let g:term_default_window_size = 20
let g:default_color_scheme = 1
let g:code_block_defaulted = 0
let g:jump_sep_regex = "\(\s\+\|-\|^\|$\|.\|_\)"

"
" function-ish
"

function! ToggleColorScheme()
    if g:default_color_scheme == 0
        colorscheme default
    else
        SetWarlockTheme()
    endif
endfunction

" Centerizer
function! Centerizer()
    if s:centerize
        return "zz"
    else
        return ""
    endif
endfunction

function! ToggleCenterizer()
  let s:centerize = !s:centerize
endfunction

function! DefaultCodeBlock()
    let g:code_block_comment = substitute(substitute(&commentstring, '%s', ' ', 'g'), '\s\+', '', 'g')
endfunction

function! CodeBlockIdentifier(append=0)
    let block = g:code_block_comment
    if has_key(g:code_block_non_comment_file_types, &filetype) == 1
        let block = g:code_block_non_comment_file_types[&filetype]
    endif
    if g:code_block_is_databricks_notebook == 1
        let block =  block . " " . g:code_block_databricks_notebook_suffix
    else
        let block = block . " " . g:code_block_suffix
    endif
    if a:append == 1
        if g:code_block_is_databricks_notebook == 1
            if g:code_block_type_annotation != ""
                let block = block . " " . "\n%" . g:code_block_type_annotation
            endif
        else
            let block = block . " " . g:code_block_type_annotation
        endif
    elseif g:code_block_databricks_notebook_no_end == 1 && g:code_block_is_databricks_notebook == 1
        return ""
    endif
    return block
endfunction

function! UpdateCodeBlockSuffix()
    let g:code_block_suffix = input("Enter the code block suffix: ")
    let g:code_block_comment = substitute(substitute(&commentstring, '%s', ' ', 'g'), '\s\+', ' ', 'g')
endfunction

function! UpdateCodeBlockComment()
    let g:code_block_comment = input("Enter the code block comment: ")
endfunction

function! UpdateCodeBlockTypeSuffix()
    let g:code_block_type_annotation = input("Enter the code block type suffix: ")
endfunction

function! CycleCodeBlockTypeAnnotation()
    let ind = index(g:code_block_type_annotation_priority, g:code_block_type_annotation)
    if ind >= 0
        if ind == len(g:code_block_type_annotation_priority) - 1
            let g:code_block_type_annotation = g:code_block_type_annotation_priority[0]
        else
            let g:code_block_type_annotation = g:code_block_type_annotation_priority[ind + 1]
        endif
    else
        let g:code_block_type_annotation = g:code_block_type_annotation_priority[0]
    endif
endfunction

function! ToggleDatabricksNotebook()
    if g:code_block_is_databricks_notebook == 1
        let g:code_block_is_databricks_notebook = 0
    else
        let g:code_block_is_databricks_notebook = 1
    endif
endfunction

function! CheckLine(empty, not)
    if getline(".") =~ '^\s*$'
        return a:empty
    endif
    return a:not
endfunction

function! BuffJump()
    ls
    let bufnr = input("Enter buffer number: ")
    execute "buffer " . bufnr
endfunction

" Terminal-ish stuff
function! OpenTermSize()
    let current_window_size = line('w$') - line('w0')
    if current_window_size < g:term_lines_to_resize
        return g:term_default_window_size
    endif
    let new_term_window_size = current_window_size / g:term_proportion_default
    return new_term_window_size
endfunction

function! JumpWs(backwards=0)
    let flags = "e"
    if a:backwards == 1
        let flags = "be"
    endif
    let pattern = "\\\\(\\\\s\\\\+\\\\|-\\\\|_\\\\|<\\\\|(\\\\|[\\\\|{\\\\|\\\"\\\\|'\\\\|:\\\\|#\\\\|@\\\\|^\\\\|=\\\\|+\\\\|`\\\\)\\\\w"
    return '<CMD>call search("' . pattern . '", "' . flags . '")<CR>'
endfunction

" getline('.')[col('.'):]
" \(\s\+\|\s\*_\s\*\|\s\*-\s\*\|\s\*.\s\*\|\s\*\/\s\*\)
" \(\s\+\|-\|_\|<\|(\|[\|{\|\"\|'\|:\|#\|@\|^\|=\|+\|`\)\w
" strpart(getline('.'), col('.') - 1, 1, 1)
" #settings ish"
set linespace=10
set mouse=a
set nocompatible
set showmatch
set expandtab
set autoindent
set number relativenumber
set cursorline
set ttyfast
set backupdir=~/.config/nvim/nvim-temp
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab autoindent
set incsearch ignorecase smartcase hlsearch
set wildmode=longest,list,full wildmenu
set ruler laststatus=2 showcmd showmode
set list listchars=trail:»,tab:»-
set wrap breakindent
set encoding=utf-8
set textwidth=0
set hidden
set title
set matchpairs+=<:>
set iskeyword-=_
set swapfile
set fillchars+=vert:\│
set completeopt=menu,menuone,noselect
set shell=nu

" Terminal
tmap kj <C-\><C-n>
tmap <C-d> kj:q<CR>
tmap <C-t> <Esc><cmd>bd!<CR>
nmap <expr> <C-space><C-t> ":terminal python3 -i " . resolve(expand('%:p')) . "<CR>"
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert
nmap <expr> <C-t> ":botright terminal<CR>:resize " . OpenTermSize() . "<CR>i"
xmap <expr> <C-t> ":botright terminal<CR>:resize " . OpenTermSize() . "<CR>i"
nmap <expr> <space><C-t> ":cd %:p:h<CR>:botright terminal<CR>i"

" Core
inoremap <S-CR> <Esc>
nmap <expr> <leader><leader><leader>f DefaultCodeBlock()
nmap \ :Lex<CR>:set number<CR>:set nowrap<CR>:vertical resize 25<CR>
nmap <leader><leader>r :so ~/.vimrc<CR>
nmap <leader><leader>t :call TrimWhitespace()<CR>
nmap <silent> <leader><leader> :noh<CR>
nmap <leader><leader>d <cmd>silent! bd!<CR>
nmap D <cmd>silent! bd!<CR>
nmap <leader><leader>w <cmd>w!<CR>
nmap W <cmd>w!<CR>
nmap <leader><leader>q <cmd>q!<CR>
nmap <C-q> <cmd>q!<CR>
nmap <leader><leader>s <cmd>w!<CR><cmd>q!<CR>
nmap <C-space>n :cnext<CR>
nmap <C-space>N :cprevious<CR>
xmap <leader><leader>d <cmd>silent! bd!<CR>
xmap <leader><leader>w <cmd>w!<CR>
xmap <leader><leader>q <cmd>q!<CR>
xmap <C-q> <cmd>q!<CR>
xmap W <cmd>w!<CR>
xmap D <cmd>silent! bd!<CR>
xnoremap <C-d> D

""
"Normal remaps
"
nnoremap <leader>l g_
nnoremap <leader>h _
nnoremap <leader>k g_
nnoremap <leader>j _
nnoremap <leader>y "+y
nnoremap <leader>yw BvE"+y
nnoremap <leader>yy ^vg_"+y
nnoremap <leader>p "+p
nnoremap <leader>P "+P
nnoremap vw BvE
nnoremap <C-y> "+y
nnoremap <C-p> "+p
nnoremap <leader><C-p> "+P
nnoremap y "0y
nnoremap yw BvEy
nnoremap P "0P
nnoremap p "0p
nnoremap d "1d
nnoremap x "_x
nnoremap <C-space>p "1p
nnoremap <C-space>P "1P
nnoremap R s
nnoremap <C-h> b
nnoremap <C-l> w
nnoremap <expr> <C-j> '<C-d>' . Centerizer()
nnoremap <expr> <C-k> '<C-u>' . Centerizer()
nnoremap <expr> j 'j' . Centerizer()
nnoremap <expr> k 'k' . Centerizer()
nnoremap <expr> n 'n' . Centerizer()
nnoremap <expr> N 'N' . Centerizer()
nnoremap <C-c> zz:call ToggleCenterizer()<CR>
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <C-space>j o<Esc>_C<Esc>
nnoremap <C-space>k O<Esc>_C<Esc>
nmap <c-.> <C-W>l
nmap <c-,> <C-W>h
nnoremap gg gg0
nnoremap G G$
nnoremap <leader><C-y> gg0vG$"+y
nnoremap <leader>` _i```
nnoremap <leader><leader>` i```
nnoremap <leader>o o<Esc>_
nnoremap <leader><C-o> o<Esc>_C
nnoremap <leader>O O<Esc>_C
nnoremap <C-space><C-o> O<Esc>_
nnoremap <leader><leader>o o<Esc>_i
nnoremap <C-space><C-space><C-o> O<Esc>_i
nnoremap <leader>th :/```<CR>NjVnk:noh<CR>
nnoremap <leader>tk :/```<CR>N:noh<CR>
nnoremap <leader>tj :/```<CR>n:noh<CR>
nnoremap <expr> <C-b> CheckLine("C", "o<Esc>_C") . CodeBlockIdentifier(1) . '<Esc>o<Esc>_C' . CodeBlockIdentifier() . '<Esc>ko<Esc>_C'
nnoremap <expr> <C-i> CheckLine("C", "o<Esc>_C") . CodeBlockIdentifier() . '<Esc>o<Esc>_C' . CodeBlockIdentifier() . '<Esc>kA '
nnoremap <expr> <C-space><C-i> "a" . CodeBlockIdentifier() . '<Esc>'
nnoremap <expr> <C-space><C-b> "a" . CodeBlockIdentifier(1) . '<Esc>'
nnoremap <leader>s :call BuffJump()<CR>
nmap <expr> <A-C-j> ']]' . Centerizer()
nmap <expr> <A-C-k> '[[' . Centerizer()
nmap <expr> <A-j> ']m' . Centerizer()
nmap <expr> <A-k> '[m' . Centerizer()
nmap <A-l> ]M
nmap <A-h> [M
nmap <expr> } '}' . Centerizer()
nmap <expr> { '{' . Centerizer()
" nmap <expr> <C-l> JumpWs()
" nmap <expr> <C-h> JumpWs(1)

" Insert remaps
inoremap  <Esc>
inoremap <C-l> <Esc>la
inoremap <C-;> <Esc>lxa
inoremap <C-h> <Esc>ha
inoremap <C-k> <Esc>ka
inoremap <C-j> <Esc>ja
inoremap <C-space>l <Esc>A
inoremap <C-space>h <Esc>I
inoremap <C-space>j <Esc>o<Esc>_C
inoremap <C-space>k <Esc>O<Esc>_C
inoremap <C-space>` <Esc>_i```
inoremap <C-space><C-space>` ```
inoremap <C-space>C <Esc>lC
inoremap <C-d>l <Esc>lC
inoremap <C-d>h <Esc>v_di
inoremap <C-d>j <Esc>jddkA
inoremap <C-d>k <Esc>kddjA
inoremap <expr> <C-b> CheckLine('', '<Esc>o<Esc>_C') . CodeBlockIdentifier(1) . '<Esc>o<Esc>_C' . CodeBlockIdentifier() . '<Esc>ko<Esc>_C'
inoremap <expr> <C-i> CheckLine('', '<Esc>o<Esc>_C') . CodeBlockIdentifier() . '<Esc>o<Esc>_C' . CodeBlockIdentifier() . '<Esc>kA '
inoremap <expr> <C-space><C-b> CodeBlockIdentifier(1)
inoremap <expr> <C-space><C-i> CodeBlockIdentifier()
imap <Tab> <Tab>

" Visual remaps
xnoremap <C-d> D
xnoremap < <gv
xnoremap > >gv
xnoremap <leader>k g_
xnoremap <leader>j _
xnoremap <expr> <C-j> '<C-d>' . Centerizer()
xnoremap <expr> <C-k> '<C-u>' . Centerize()
xnoremap <expr> j 'j' . Centerizer()
xnoremap <expr> k 'k' . Centerizer()
xnoremap <expr> n 'n' . Centerizer()
xnoremap <expr> N 'N' . Centerizer()
xnoremap <C-c> zz:call ToggleCenterizer()<CR>
xnoremap <leader>y "+y
xnoremap <leader>yy "+yy
xnoremap <leader>Y "+yg_
xnoremap <leader>p "+p
xnoremap <leader>P "+P
xnoremap <C-y> "+y
xnoremap y "0y
xnoremap p "0p
xnoremap d "1d
xnoremap x "_x
xnoremap <C-p> "1p
xnoremap <leader><C-p> "1P
xnoremap <expr> <C-space>V mode() ==# "v" ? "v" : "<C-v>"
xnoremap gg gg0
xnoremap G G$
xnoremap <leader>` <Esc>`<O```<Esc>`>o```<Esc>
xnoremap <C-s> <cmd>Pounce<CR>
xnoremap <Esc> <Nop>
xnoremap <Esc><Esc> <Esc>
xnoremap <expr> <C-b> '<Esc><Esc>`<O<Esc>_C' . CodeBlockIdentifier(1) . '<Esc>`><Esc>o' . CodeBlockIdentifier() . '<Esc>`<kA '
xnoremap <expr> <C-i> '<Esc><Esc>`<O<Esc>_C' . CodeBlockIdentifier() . '<Esc>`><Esc>o' . CodeBlockIdentifier() . '<Esc>`>jo<Esc>_C'
xmap <expr> <A-C-j> ']]' . Centerizer()
xmap <expr> <A-C-k> '[[' . Centerizer()
xmap <expr> <S-}> '}' . Centerizer()
xmap <expr> <S-{> '{' . Centerizer()
