filetype plugin indent on
filetype plugin on
let mapleader=" "
let maplocalleader="\\"
if has('win64')
    source $HOME/AppData/Local/nvim/theme.vim
else
    source $HOME/.config/nvim/theme.vim
endif
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


function! ToggleCenterizer()
  let s:centerize = !s:centerize
endfunction

function! CloseIt()
    if len(win_findbuf(bufnr('%'))) > 1
        return ':clo'
    else
        return ':silent! bd!'
    endif
endfunction

" Core
inoremap <S-CR> <Esc>
nmap \ :NvimTreeFindFileToggle<CR>:set number<CR>:set nowrap<CR>
nmap <leader><leader>r :so ~/.config/nvim/minit.vim<CR>
nmap <silent> <leader><leader><leader>h :noh<CR>
nmap <expr> <leader><leader>d CloseIt() . '<CR>'
xmap <expr> <leader><leader>d CloseIt() . '<CR>'
nmap <expr> <C-c> CloseIt() . '<CR>'
xmap <expr> <C-d> CloseIt() . '<CR>'
nmap <leader><leader>w <cmd>w!<CR>
nmap <leader><leader>q <cmd>q!<CR>
nmap <C-q> <cmd>q!<CR>
nmap <C-]> :cnext<CR>
nmap <C-[> :cprevious<CR>
nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprev<CR>
xmap <leader><leader>w <cmd>w!<CR>
xmap <leader><leader>q <cmd>q!<CR>

""
" Normal remaps
"
nnoremap <Esc> <Nop>
nmap <space> <leader>
nmap <space><space> <leader>

" window stuff
nmap W <C-w><C-w>
nmap <leader>w <C-w><C-w>
nmap cow <C-w><C-w>:clo<CR>
nmap <C-.> <C-w>l
nmap <C-,> <C-w>h
nnoremap <expr> <leader>- ResizePane("-5") . '<CR>'
nnoremap <expr> <leader>= ResizePane("+5") . '<CR>'

" line stuff
nnoremap <C-o> O<Esc>jo<Esc>k
nnoremap <leader>o o<Esc>k
nnoremap <leader>O O<Esc>j

" move stuff
nnoremap <expr> <C-d> '10j' . Centerizer()
nnoremap <expr> <C-u> '10k' . Centerizer()
nnoremap <expr> D '<C-d>' . Centerizer()
nnoremap <expr> U '<C-u>' . Centerizer()
nnoremap <expr> L 'w' . Centerizer()
nnoremap <expr> H 'ge' . Centerizer()
nmap <expr> <leader>j '5j' . Centerizer()
nmap <expr> <leader>k '5k' . Centerizer()
nnoremap <expr> <C-j> '}' . Centerizer()
nnoremap <expr> <C-k> '{' . Centerizer()
nnoremap <expr> j 'j' . Centerizer()
nnoremap <expr> k 'k' . Centerizer()
nnoremap <expr> n 'n' . Centerizer()
nnoremap <expr> N 'N' . Centerizer()

nnoremap <leader>u J
nnoremap <leader>l $
nnoremap <leader>h _

" copy stuff
nnoremap <leader>y "+y
nnoremap <leader>yw viw"+y
nnoremap <leader>yy V"+y
nnoremap <leader>p "+p
nnoremap <leader>P "+P
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
nnoremap <C-space>j o<Esc>_C<Esc>
nnoremap <C-space>k O<Esc>_C<Esc>

" Insert remaps
inoremap  <Esc>
imap <C-l> <Esc>la
imap <C-h> <Esc>i
imap <C-space><C-l> <Esc>lxi
imap <C-space><C-h> <Esc>xi
inoremap <C-k> <Esc>ka
inoremap <C-j> <Esc>ja
inoremap <C-space>l <Esc>A
inoremap <C-space>h <Esc>I
inoremap <C-space>j <Esc>o<Esc>_C
inoremap <C-space>k <Esc>O<Esc>_C
inoremap <C-space>C <Esc>lC
inoremap <C-d>l <Esc>lC
inoremap <C-d>h <Esc>v_di
inoremap <C-d>j <Esc>jddkA
inoremap <C-d>k <Esc>kddjA

" Visual remaps
xmap <space> <leader>
xmap <space><space> <leader>
xnoremap < <gv
xnoremap > >gv
xnoremap <leader>l g_
xnoremap <leader>h _
xnoremap U J
xnoremap t<C-c> zz:call ToggleCenterizer()<CR>
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
" xnoremap <Esc> <Nop>
" xnoremap <Esc><Esc> <Esc>
xnoremap <leader>l $
xnoremap <leader>h _
xnoremap <expr> <C-d> '10j' . Centerizer()
xnoremap <expr> <C-u> '10k' . Centerizer()
xnoremap <expr> D '<C-d>' . Centerizer()
xnoremap <expr> U '<C-u>' . Centerizer()
xnoremap <expr> L 'e' . Centerizer()
xnoremap <expr> H 'b' . Centerizer()
xmap <expr> <leader>j '5j' . Centerizer()
xmap <expr> <leader>k '5k' . Centerizer()
xnoremap <expr> <C-j> '}' . Centerizer()
xnoremap <expr> <C-k> '{' . Centerizer()
xnoremap <expr> j 'j' . Centerizer()
xnoremap <expr> k 'k' . Centerizer()
xnoremap <expr> n 'n' . Centerizer()
xnoremap <expr> N 'N' . Centerizer()
