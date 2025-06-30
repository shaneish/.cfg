filetype plugin indent on
let mapleader=" "
let maplocalleader="\\"
colorscheme quiet
syntax on

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

" #settings ish"
set termguicolors
set linespace=10
set mouse=a
set clipboard=unnamed
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
set laststatus=2
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

highlight TabLineSel guifg=#f6cd61 gui=bold
highlight TabLineFill guifg=#f6cd61 gui=bold

" #cursor stuff
let &t_EI = "\e[2 q"
let &t_SI = "\e[5 q"
augroup myCmds
    au!
    autocmd VimEnter * silent !echo -ne "\\e[2 q"
augroup END

" #autcmd ish
autocmd BufRead,BufNewFile *.toml set filetype=toml
autocmd FileType toml setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType lua setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
autocmd FileType go setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
autocmd FileType haskell setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
autocmd FileType markdown setlocal shiftwidth=2 tabstop=2 softtabstop=2 conceallevel=0

" Terminal
tmap kj <C-\><C-n>
tmap <C-space> <c-\><c-n>
tmap <C-Space><C-Space> <c-\><c-n><C-w><C-w>
tmap <expr> <C-d> '<C-\><C-n>' . CloseIt() . '<CR>'

" Core
inoremap <S-CR> <Esc>
nmap \ :call ToggleNetrw()<CR>
nmap <silent> <leader><leader>h :noh<CR>
nmap <expr> <C-e><C-e> CloseIt() . '<CR>'
nmap <C-e><C-w> <cmd>w!<CR>
nmap <C-e><C-q> <cmd>q!<CR>
nmap <leader><leader>w <cmd>w!<CR>
nmap <leader><leader>q <cmd>q!<CR>
nmap <C-w><C-q> :w!<CR>:q!<CR>
nnoremap ] :cnext<CR>
nnoremap [ :cprevious<CR>
nmap <Tab> :BufferNext<CR>
nmap <S-Tab> :BufferPrevious<CR>
inoremap <C-v> <C-r>+

" window stuff
nnoremap <expr> <leader>- ResizePane("-5") . '<CR>'
nnoremap <expr> <leader>= ResizePane("+5") . '<CR>'
nnoremap <C-b> :call BuffJump()<CR>

" move stuff
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap <C-j> }zz
nnoremap <C-k> {zz
nnoremap <C-h> gezz
nnoremap <C-l> wzz
nnoremap j jzz
nnoremap k kzz
nnoremap n nzz
nnoremap N Nzz
nnoremap <leader>l g_
nnoremap <leader>h _
xnoremap <C-d> <C-d>zz
xnoremap <C-u> <C-u>zz
xnoremap <C-j> }zz
xnoremap <C-k> {zz
xnoremap <C-h> bzz
xnoremap <C-l> ezz
xnoremap j jzz
xnoremap k kzz
xnoremap n nzz
xnoremap N Nzz
xnoremap <leader>l g_
xnoremap <leader>h _

" copy stuff
nnoremap dd "1dd
nnoremap d "1d
nnoremap x "_x
nnoremap <leader>p "1p
nnoremap <leader>P "1P
xnoremap dd "1dd
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
imap '' ''<Esc>i
imap "" ""<Esc>i
imap (( ()<Esc>i
imap [[ []<Esc>i
imap {{ {}<Esc>i
imap << <><Esc>i

" Visual remaps
xnoremap < <gv
xnoremap > >gv
xnoremap S' <Esc>`<i'<Esc>`>la'<Esc>`<
xnoremap S" <Esc>`<i"<Esc>`>la"<Esc>`<
xnoremap S) <Esc>`<i(<Esc>`>la)<Esc>`<
xnoremap S] <Esc>`<i[<Esc>`>la]<Esc>`<
xnoremap S} <Esc>`<i{<Esc>`>la}<Esc>`<
xnoremap S> <Esc>`<i<<Esc>`>la><Esc>`<
xnoremap Sd <Esc>`<x`>x`<v`>h
