filetype plugin indent on
let mapleader=" "
let maplocalleader="\\"
if ! has('nvim')
    let &t_EI = "\e[2 q"
    let &t_SI = "\e[5 q"
endif
colorscheme quiet
syntax on
function! TrimWhitespace()
    let l:save = winsaveview()
    %s/\\\@<!\s\+$//e
    %s/\r//g
    call winrestview(l:save)
endfunction

function! BuffJump()
    ls
    let bufnr = input("Enter buffer number: ")
    if bufnr != ""
        execute "buffer " . bufnr
    endif
endfunction

function! CloseIt()
    if len(win_findbuf(bufnr('%'))) > 1
        return ':clo'
    else
        return ':silent! bd!'
    endif
endfunction

function! ResizePane(amount="-5")
    if winwidth(0) != &columns
        return ':vertical resize ' . a:amount
    else
        return ':resize ' . a:amount
    endif
endfunction

let g:NetrwIsOpen=0
function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Lexplore
    endif
endfunction

function! WindowProportion(prop=0.20)
    let window_size = line('w$') - line('w0')
    let jump_size = window_size * a:prop
    return float2nr(jump_size)
endfunction

function! NextBlankLine(prop=0.50)
    let next_blank_line = search('^$\n\s*\S', 'n') - line('.')
    let next_prop_jump = WindowProportion(a:prop)
    let jump_dist = next_prop_jump
    if 0 < next_blank_line
        if next_blank_line < jump_dist
            let jump_dist = next_blank_line
        endif
    endif
    return jump_dist
endfunction

function! PrevBlankLine(prop=0.50)
    let prev_blank_line = line('.') - search('^$\n\s*\S', 'nb')
    let prev_prop_jump = WindowProportion(a:prop)
    let jump_dist = prev_prop_jump
    if 0 < prev_blank_line
        if prev_blank_line < jump_dist
            let jump_dist = prev_blank_line
        endif
    endif
    return jump_dist
endfunction

function! TrimAndPaste()
    let @"+ = trim(@"+ )
    normal p
endfunction

function! Fishified(path="")
    let path = a:path
    if a:path == ""
        let path = expand('%:p')
    endif
    let path_info = pathshorten(substitute(path, expand('$HOME'), '~', 'g'))
    if a:path == ""
        let b:path_info = path_info
    endif
    return trim(path_info)
endfunction

function! GitInfo(type="repo", dir="")
    let dir = a:dir
    let git_info = ""
    if dir == ""
        let dir = expand('%:p:h')
    endif
    let info = trim(system("basename $(git -C " . dir . " rev-parse --show-toplevel)"))
    if a:type == "branch"
        let info = trim(system("git -C " . dir . " branch --show-current"))
    endif
    if !(info =~ "fatal: *") && !(info =~ "basename: *")
        return trim(info)
    endif
    return "¯\_(ツ)_/¯"
endfunction

function! CurrentGitRepo()
    return GitInfo('repo')
endfunction

function! CurrentGitBranch()
    return GitInfo('branch')
endfunction

function! Pairs(c)
    if a:c == "("
        return ")"
    elseif a:c == ")"
        return "("
    elseif a:c == "<"
        return ">"
    elseif a:c == ">"
        return "<"
    elseif a:c == "["
        return "]"
    elseif a:c == "]"
        return "["
    elseif a:c == "{"
        return "}"
    elseif a:c == "}"
        return "{"
    endif
    return a:c
endfunction

function! ToggleConcealLevel()
    if &conceallevel == 0
        setlocal conceallevel=2
    else
        setlocal conceallevel=0
    endif
endfunction

" #settings ish"
set termguicolors
set linespace=10
set mouse=a
set nocompatible
set showmatch
set expandtab
set smarttab
set autoindent
set number relativenumber
set cursorline
set cursorcolumn
set list listchars=tab:❘-,trail:·,extends:»,precedes:«,nbsp:×
set ttyfast
set tabstop=4 softtabstop=4 shiftwidth=4
set incsearch ignorecase smartcase hlsearch
set wildmode=longest,list,full wildmenu
set ruler laststatus=5 showcmd showmode
set wrap breakindent
set linebreak
set encoding=utf-8
set textwidth=0
set hidden
set title
set matchpairs+=<:>
set iskeyword-=_
set swapfile
set fillchars+=vert:\│
set completeopt=menu,menuone,noselect
set splitright
set conceallevel=0
set guicursor+=i:blinkon1,v:blinkon1
set cpoptions+=n
set showbreak=·· " ↳…
set formatoptions-=o
set laststatus=2
set wrap

" #autcmd ish
augroup new_file_types
    autocmd!
    autocmd BufRead,BufNewFile *.toml set filetype=toml
augroup END

augroup weird_two_space_formats
    autocmd!
    autocmd FileType toml,markdown,html,css,xml,json setlocal shiftwidth=2 tabstop=2 softtabstop=2 conceallevel=0
    autocmd FileType lua,haskell setlocal shiftwidth=2 tabstop=2 softtabstop=2
augroup END

augroup terminal_madness
    autocmd!
    autocmd BufWinEnter,WinEnter term://* startinsert
    autocmd BufLeave term://* stopinsert
augroup END

augroup errytime
    autocmd!
    autocmd VimEnter,BufEnter,WinEnter *.toml setlocal conceallevel=0
    autocmd VimEnter,BufEnter,WinEnter *.md setlocal conceallevel=0
    autocmd VimEnter,BufEnter,WinEnter *.json setlocal conceallevel=0
    autocmd VimEnter,BufEnter,WinEnter *.yaml setlocal conceallevel=0
    autocmd VimEnter,BufEnter,WinEnter * silent nmap <C-,> :cprev<CR> " :lprev
    autocmd VimEnter,BufEnter,WinEnter * silent nmap <C-.> :cnext<CR> " :lnext
    autocmd VimEnter,BufEnter * silent let b:curr_repo = CurrentGitRepo()
    autocmd VimEnter,BufEnter * silent let b:curr_branch = CurrentGitBranch()
    autocmd VimEnter,BufEnter * silent let b:curr_path = Fishified()
    autocmd VimEnter,BufEnter * setlocal statusline=\ \ \ #%n\ \|\ :%L\ =\ %P\ \|\ %{b:curr_path}\ \|\ %{b:curr_repo}\ ->\ %{b:curr_branch}
augroup END

augroup colorscheme_madness
    autocmd!
    autocmd VimEnter,BufEnter,WinEnter * highlight StatusLine guibg=#ffd700 guifg=#000000 gui=bold
    autocmd VimEnter,BufEnter,WinEnter * highlight NonText guifg=#ffd700 gui=bold
    " autocmd VimEnter,BufEnter,WinEnter * highlight SignColumn guibg=NONE
augroup END

if ! has('nvim')
    augroup compatibility
        autocmd!
        autocmd VimEnter,BufEnter,WinEnter * nmap <S-Tab> :bprev<CR>
        autocmd VimEnter,BufEnter,WinEnter * nmap <Tab> :bnext<CR>
        autocmd VimEnter,BufEnter,WinEnter * silent !echo -ne "\\e[2 q"
    augroup END
endif

" Terminal
tmap kj <C-\><C-n>
tmap <C-Space> <c-\><c-n>
tmap <C-Space><C-Space> <c-\><c-n><C-w><C-w>
tmap <Esc><Esc> <c-\><c-n>
tmap <expr> <C-d> '<C-\><C-n>' . CloseIt() . '<CR>'
tmap <C-w><C-w> <C-\><C-n><C-w><C-w>
tmap <expr> <C-e><C-e> '<C-\><C-n>' . CloseIt() . '<CR>'

" Core
inoremap <S-CR> <Esc>
nmap <expr> <C-e><C-e> CloseIt() . '<CR>'
nmap <C-e><C-w> <cmd>w!<CR>
nmap <C-q><C-q> <cmd>q!<CR>
nmap <leader><leader>w <cmd>w!<CR>
nmap <leader><leader>q <cmd>q!<CR>
nmap <C-w><C-q> :w!<CR>:q!<CR>
nmap <C-.> :cnext<CR> " :lnext
nmap <C-,> :cprev<CR> " :lprev
nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprev<CR>
inoremap <C-v> <C-r>+
nmap <silent> <leader><leader>t :call TrimWhitespace()<CR>
nmap <silent> <leader><leader>h :noh<CR>
nmap \ :call ToggleNetrw()<CR>
nmap <C-f><C-t> :call ToggleConcealLevel()<CR>
imap <C-f><C-t> :call ToggleConcealLevel()<CR>

" grepy grep
if executable('rg')
    set grepprg=rg\ --vimgrep\ --hidden\ --glob\ ‘!.git’
endif
nmap <silent> <C-g><C-g> :grep <cword> '%'<CR>:copen<CR>
nmap <silent> <expr> <C-g><C-f> ":grep <cword> *." . expand('%:e') . "<CR>:copen<CR>"

" window stuff
nnoremap <expr> <leader>- ResizePane("-5") . '<CR>'
nnoremap <expr> <leader>= ResizePane("+5") . '<CR>'
nmap cow <C-w><C-w>:clo<CR>
nnoremap <leader>bj :call BuffJump()<CR>

" line stuff
nnoremap <C-o><C-o> O<Esc>jo<Esc>k
nnoremap <C-o><C-j> o<Esc>k
nnoremap <C-o><C-k> O<Esc>j

" move stuff
noremap j gj
noremap k gk
noremap J )zz
noremap K (zz
noremap <expr> <C-j> NextBlankLine() . 'jzzg^'
noremap <expr> <C-k> PrevBlankLine() . 'kzzg^'
noremap <expr> D WindowProportion() . 'jzz'
noremap <expr> U WindowProportion() . 'kzz'
noremap <leader>l g$
noremap <leader>h g^
noremap <expr> <leader>k WindowProportion(0.25) . 'k'
noremap <expr> <leader>j WindowProportion(0.25) . 'j'
nnoremap <C-i> J
nnoremap <C-h> ge
nnoremap <C-l> w
xnoremap <C-h> b
xnoremap <C-l> e

for k in ["<C-d>", "<C-u>", "n", "N"]
    execute 'map '.k.' '.k.'zz'
endfor

" copy stuff
nnoremap yy 0vg_"+y
nnoremap dd "1dd
noremap y "+y
noremap p "+p
noremap P "+P
noremap d "1d
noremap x "_x
noremap C "1C
noremap <leader>p "1p
noremap <leader>P "1P
noremap <leader><C-p> :call TrimAndPaste()<CR>

" Insert
inoremap  <Esc>
inoremap <C-c> <Esc>0C

" Visual remaps
xnoremap < <gv
xnoremap > >gv
xnoremap Svv <Esc>`<hv`>l
for k in ["\'", '"', "`", ")", "]", "}", ">", "_", "<Space>", "*", '.']
    execute 'xnoremap S'.k.' <Esc>`<i'.Pairs(k).'<Esc>`>la'.k.'<Esc>`<'
    execute 'xnoremap Sv'.k.' <Esc>`<i'.Pairs(k).'<Esc>`>la'.k.'<Esc>v`<'
    execute 'xnoremap Sr'.k.' <Esc>`<r'.Pairs(k).'`>r'.k.'v`<'
endfor
for k in ["\'", '"', "`", ")", "]", "}", ">", "_", "<Space>", "*", '.']
    for v in ["\'", '"', "`", ")", "]", "}", ">", "_", "<Space>", "*", '.']
        execute 'nmap Ss'.k.v.' F'.k.'vf'.k.'Sr'.v.'<Esc>'
    endfor
endfor

for k in ["\'", '"', "`", ")", "]", "}", ">", "_", "<Space>", "*", '.']
    execute 'nmap Sw'.k.' viwS'.k.'l'
endfor
