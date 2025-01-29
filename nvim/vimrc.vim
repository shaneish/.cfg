let mapleader=" "
let maplocalleader="\\"
colorscheme retrobox
syntax on

" Centerizer
let s:centerize=1
function! Centerizer(keys="")
    if s:centerize
        return a:keys . "zz"
    else
        return a:keys . ""
    endif
endfunction

function! BuffJump()
    ls
    let bufnr = input("Enter buffer number: ")
    if bufnr != ""
        execute "buffer " . bufnr
    endif
endfunction

" Terminal-ish stuff
let g:term_proportion_default = 3
let g:term_lines_to_resize = 40
let g:term_default_window_size = 20
function! OpenTermSize(vertical=0)
    if a:vertical == 0
        let current_window_size = &lines
    else
        let current_window_size = &columns
    endif
    if current_window_size < g:term_lines_to_resize
        return g:term_default_window_size
    endif
    let new_term_window_size = current_window_size / g:term_proportion_default
    return float2nr(new_term_window_size)
endfunction

function! OpenTerm()
    execute "belowright split +term"
    execute "resize " . OpenTermSize()
    execute "startinsert"
endfunction

function! ResizePane(amount="-5")
    if winwidth(0) != &columns
        return ':vertical resize ' . a:amount
    else
        return ':resize ' . a:amount
    endif
endfunction

function! CloseIt()
    if len(win_findbuf(bufnr('%'))) > 1
        return ':clo'
    else
        return ':silent! bd!'
    endif
endfunction

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
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab autoindent
set incsearch ignorecase smartcase hlsearch
set wildmode=longest,list,full wildmenu
set ruler laststatus=5 showcmd showmode
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
set splitright
set conceallevel=0
set guicursor+=i:blinkon1,v:blinkon1
set cpoptions+=n
set showbreak=...

" #globalvars ish
let g:conceallevel = 0
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" #autcmd ish
autocmd FileType * set formatoptions-=ro
autocmd BufRead,BufNewFile *.csv.txt set filetype=csv
autocmd BufRead,BufNewFile *.tsv.txt set filetype=tsv
autocmd BufRead,BufNewFile *.toml set filetype=toml
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType css setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType xml setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType toml setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType lua setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
autocmd FileType markdown setlocal shiftwidth=2 tabstop=2 softtabstop=2 conceallevel=0
autocmd FileType journal setlocal shiftwidth=2 tabstop=2 softtabstop=2 conceallevel=0
command! BW :bn|:bd#

" #highlight ish
" highlight TabLineSel guifg=#f6cd61 gui=bold
" highlight TabLineFill guifg=#f6cd61 gui=bold

" Terminal
tmap kj <C-\><C-n>
tmap <C-space> <c-\><c-n>
tmap <C-Space><C-Space> <c-\><c-n><C-w><C-w>
tmap <C-q> <C-\><C-n>:q!<CR>
tmap <expr> <C-d> '<C-\><C-n>' . CloseIt() . '<CR>'
tmap <C-w><C-w> <C-\><C-n><C-w><C-w>
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert
nmap <leader><leader>t :call OpenTerm()<CR>

" Core
inoremap <S-CR> <Esc>
nmap \ :Vexplore<CR>:set number<CR>:set nowrap<CR>
nmap <leader><leader>r :so ~/.config/nvim/init.vim<CR>
nmap <silent> <leader><leader><leader>h :noh<CR>
nmap <expr> <C-e><C-e> CloseIt() . '<CR>'
nmap <C-e><C-w> <cmd>w!<CR>
nmap <C-e><C-q> <cmd>q!<CR>
nmap <leader><leader>w <cmd>w!<CR>
nmap <leader><leader>q <cmd>q!<CR>
nnoremap L :cnext<CR>
nnoremap H :cprevious<CR>
nmap <silent> <leader><Tab> <cmd>BufferPick<CR>
nmap <Tab> :BufferNext<CR>
nmap <S-Tab> :BufferPrevious<CR>
inoremap <C-v> <C-r>+
nnoremap <C-t><C-t> :call ToggleTheme()<CR>

""
" Normal remaps
"
nnoremap <Esc> <Nop>
nmap <space> <leader>
nmap <space><space> <leader>

" window stuff
nmap cow <C-w><C-w>:clo<CR>
nnoremap <expr> <leader>- ResizePane("-5") . '<CR>'
nnoremap <expr> <leader>= ResizePane("+5") . '<CR>'
nnoremap <C-b> :call BuffJump()<CR>

" move stuff
nnoremap <expr> <C-d> '<C-d>' . Centerizer()
nnoremap <expr> <C-u> '<C-u>' . Centerizer()
nnoremap <expr> <C-j> '}' . Centerizer()
nnoremap <expr> <C-k> '{' . Centerizer()
nnoremap <expr> j 'j' . Centerizer()
nnoremap <expr> k 'k' . Centerizer()
nnoremap <expr> n 'n' . Centerizer()
nnoremap <expr> N 'N' . Centerizer()
nnoremap <expr> h 'b' . Centerizer()
nnoremap <expr> l 'e' . Centerizer()
nnoremap <leader>l g_
nnoremap <leader>h _
xnoremap <expr> <C-d> '<C-d>' . Centerizer()
xnoremap <expr> <C-u> '<C-u>' . Centerizer()
xnoremap <expr> <C-j> '}' . Centerizer()
xnoremap <expr> <C-k> '{' . Centerizer()
xnoremap <expr> j 'j' . Centerizer()
xnoremap <expr> k 'k' . Centerizer()
xnoremap <expr> n 'n' . Centerizer()
xnoremap <expr> N 'N' . Centerizer()
xnoremap <expr> h 'b' . Centerizer()
xnoremap <expr> l 'e' . Centerizer()
xnoremap <leader>l g_
xnoremap <leader>h _

" copy stuff
nnoremap <C-y><C-y> "+yy
nnoremap <C-y><C-w> "+yiw
nnoremap <C-p> "+p
nnoremap <leader><C-p> "+P
nnoremap y "0y
nnoremap yw BvEy
nnoremap P "0P
nnoremap p "0p
nnoremap dd "1dd
nnoremap x "_x
nnoremap <leader>p "1p
nnoremap <leader>P "1P
xnoremap <C-y> "+y
xnoremap <C-p> "+p
xnoremap <leader><C-p> "+P
xnoremap y "0y
xnoremap yw BvEy
xnoremap P "0P
xnoremap p "0p
xnoremap d "1d
xnoremap x "_x
xnoremap <leader>p "1p
xnoremap <leader>P "1P

" Insert
inoremap  <Esc>
imap <C-h> <Left>
imap <C-l> <Right>
imap <C-k> <Up>
imap <C-j> <Down>
imap <C-l> <Right><Bs>
imap <C-h> <Bs>
inoremap <C-j> <Esc>o<Esc>_C
inoremap <C-k> <Esc>O<Esc>_C
inoremap <C-c> <Esc>lC

" Visual remaps
xmap <space> <leader>
xmap <space><space> <leader>
xnoremap < <gv
xnoremap > >gv
