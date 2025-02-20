filetype plugin indent on
let mapleader=" "
let maplocalleader="\\"
let &t_EI = "\e[2 q"
let &t_SI = "\e[5 q"
colorscheme quiet
syntax on

function! TrimWhitespace()
    let l:save = winsaveview()
    %s/\\\@<!\s\+$//e
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

function! GitInfo(dir="", prefix="")
    let dir = a:dir
    let git_info = ""
    if a:dir == ""
        let dir = expand('%:p:h')
    endif
    let repo = trim(system("basename $(git -C " . dir . " rev-parse --show-toplevel)"))
    if !(repo =~ "fatal: *") && !(repo =~ "basename: *")
        let git_info = git_info . repo
    endif
    let branch = trim(system("git -C " . dir . " branch --show-current"))
    if !(branch =~ "fatal: *")
        let git_info = git_info . " (" . branch . ")"
    endif
    if git_info != ""
        let git_info = a:prefix . git_info
    endif
    if a:dir == ""
        let b:git_info = git_info
    endif
    return trim(git_info)
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
let b:git_info = GitInfo("", "> ")
let b:path_info = Fishified()
set statusline=buff:\ %n\ >\ lines:\ %L\ (%P)\ >\ %{b:path_info}\ %{b:git_info}

" #autcmd ish
augroup new_file_types
    autocmd!
    autocmd BufRead,BufNewFile *.toml set filetype=toml
augroup END

augroup weird_two_space_formats
    autocmd!
    autocmd FileType toml setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd FileType lua setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
    autocmd FileType go setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
    autocmd FileType haskell setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
    autocmd FileType markdown setlocal shiftwidth=2 tabstop=2 softtabstop=2 conceallevel=0
    autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd FileType css setlocal shiftwidth=2 tabstop=2 softtabstop=2
    autocmd FileType xml setlocal shiftwidth=2 tabstop=2 softtabstop=2
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
    autocmd VimEnter,BufEnter,WinEnter * silent call GitInfo("", "> ")
    autocmd VimEnter,BufEnter,WinEnter * silent call Fishified()
    autocmd VimEnter,BufEnter,WinEnter * nmap H :cprev<CR>
    autocmd VimEnter,BufEnter,WinEnter * nmap L :cnext<CR>
    autocmd VimEnter,BufEnter,WinEnter * setlocal statusline=buff:\ %n\ >\ lines:\ %L\ (%P)\ >\ %{b:path_info}\ %{b:git_info}
augroup END

augroup compatibility
    autocmd!
    autocmd VimEnter * silent !echo -ne "\\e[2 q"
    autocmd VimEnter * silent nmap H :cprev<CR>
    autocmd VimEnter * silent nmap L :cnext<CR>
augroup END

augroup colorscheme_madness
    autocmd!
    autocmd VimEnter,BufEnter,WinEnter * highlight StatusLine guibg=#ffd700 guifg=#000000 gui=bold
    autocmd VimEnter,BufEnter,WinEnter * highlight NonText guifg=#ffd700 gui=bold
    " autocmd VimEnter,BufEnter,WinEnter * highlight SignColumn guibg=NONE
augroup END

if ! has('nvim')
    augroup buff_fix
        autocmd!
        autocmd VimEnter,BufEnter,WinEnter * nmap <S-Tab> :bprev<CR>
        autocmd VimEnter,BufEnter,WinEnter * nmap <Tab> :bnext<CR>
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
nmap <silent> <leader><leader>h :noh<CR>
nmap <expr> <C-e><C-e> CloseIt() . '<CR>'
nmap <C-e><C-w> <cmd>w!<CR>
nmap <C-q><C-q> <cmd>q!<CR>
nmap <leader><leader>w <cmd>w!<CR>
nmap <leader><leader>q <cmd>q!<CR>
nmap <C-w><C-q> :w!<CR>:q!<CR>
nmap L :cnext<CR>
nmap H :cprev<CR>
nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprev<CR>
inoremap <C-v> <C-r>+
nmap <silent> <leader><leader>t :call TrimWhitespace()<CR>
nmap <silent> <leader><leader>h :noh<CR>
nmap \ :call ToggleNetrw()<CR>

" grepy grep
if executable('rg')
    set grepprg=rg\ --vimgrep\ --hidden\ --glob\ ‘!.git’
endif
nmap <silent> <expr> <C-g><C-f> ":grep " . input("> ") . " *<CR>:copen<CR>"
nmap <silent> <expr> <C-g><C-h> ":grep " . input("> ") . " *." expand('%:e') . "<CR>:copen<CR>"
nmap <silent> <C-g><C-g> :grep <cword> *<CR>:copen<CR>
nmap <silent> <expr> <C-g><C-j> ":grep <cword> *." . expand('%:e') . "<CR>:copen<CR>"

" window stuff
nnoremap <expr> <leader>- ResizePane("-5") . '<CR>'
nnoremap <expr> <leader>= ResizePane("+5") . '<CR>'
nmap cow <C-w><C-w>:clo<CR>
nnoremap <C-b> :call BuffJump()<CR>

" line stuff
nnoremap <C-o><C-o> O<Esc>jo<Esc>k
nnoremap <C-o><C-j> o<Esc>k
nnoremap <C-o><C-k> O<Esc>j

" move stuff
noremap j gj
noremap k gk
noremap J )zz
noremap K (zz
noremap <C-j> }zz
noremap <C-k> {zz
noremap <expr> D WindowProportion() . 'jzz'
noremap <expr> U WindowProportion() . 'kzz'
noremap <leader>l g$
noremap <leader>h g^
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

" Insert
inoremap  <Esc>
imap <C-h> <Left>
imap <C-l> <Right>
imap <C-k> <Up>
imap <C-j> <Down>
for k in ["(", "[", "{", "<"]
    execute 'inoremap '.k.k.' '.k.Pairs(k).'<Esc>i'
endfor
for k in ["'", '"', "`", "*", "_"]
    execute 'inoremap '.k.k.k.' '.k.k.'<Esc>i'
endfor

" Visual remaps
xnoremap < <gv
xnoremap > >gv
xnoremap Svv <Esc>`<hv`>l
for k in ["\'", '"', "`", ")", "]", "}", ">", "_", "<Space>", "*", '.']
    execute 'xnoremap S'.k.' <Esc>`<i'.Pairs(k).'<Esc>`>la'.k.'<Esc>`<'
    execute 'xnoremap Sv'.k.' <Esc>`<i'.Pairs(k).'<Esc>`>la'.k.'<Esc>v`<'
    execute 'xnoremap Sr'.k.' <Esc>`<r'.Pairs(k).'`>r'.k.'v`<'
endfor
