"
" plug-ish ish
"
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/playground'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'muniftanjim/nui.nvim'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'oatish/autoclose.nvim'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-abolish'
Plug 'scrooloose/nerdcommenter'
Plug 'Yggdroot/indentLine'
Plug 'dkarter/bullets.vim'
Plug 'wellle/context.vim'
Plug 'hashivim/vim-terraform'
Plug 'ThePrimeagen/harpoon'
Plug 'samoshkin/vim-mergetool'
Plug 'rlane/pounce.nvim'
Plug 'ggandor/leap.nvim'
Plug 'ellisonleao/glow.nvim'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'rhysd/conflict-marker.vim'
Plug 'cameron-wags/rainbow_csv.nvim'
Plug 'hat0uma/csvview.nvim'
Plug 'duane9/nvim-rg'
Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
Plug 'github/copilot.vim'
Plug 'UnsafeOats/oatjump.nvim'
Plug 'folke/zen-mode.nvim'
Plug 'chentoast/marks.nvim'
Plug 'psf/black', { 'branch': 'stable' }
Plug 'tjdevries/colorbuddy.vim'
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' }
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junegunn/limelight.vim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'oatish/smartcolumn.nvim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'jbyuki/venn.nvim'
Plug 'pappasam/nvim-repl'
Plug 'scalameta/nvim-metals'
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
Plug 'czheo/mojo.vim'
Plug 'stevearc/aerial.nvim' " navigate by code structure
Plug 'simrat39/symbols-outline.nvim' " view code structure
Plug 'romgrk/barbar.nvim'
Plug '3rd/image.nvim'
Plug 'benlubas/molten-nvim'
call plug#end()

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

"
" Lua-ish ish
"
lua << EOF
require('load-all')
EOF

"
" #functions ish
"

" Trim Whitespaces
function! TrimWhitespace()
    let l:save = winsaveview()
    %s/\\\@<!\s\+$//e
    call winrestview(l:save)
endfunction

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

" CSV-ish stuff
let s:mappingsState=1
command! TM call ToggleMappings()
function! ToggleMappings()
    if s:mappingsState
        :CsvViewEnable
    else
        :CsvViewDisable
    endif
    let s:mappingsState = !s:mappingsState
endfunction

function! CloseIt()
    if len(win_findbuf(bufnr('%'))) > 1
        return ':clo'
    else
        return ':silent! bd!'
    endif
endfunction

let g:code_block_comment = substitute(substitute(&commentstring, '%s', '', 'g'), '\s\+', '', 'g')
let g:code_block_suffix = "%%"
let g:code_block_alt_file_types = ["md", "markdown", "rmd", "rmarkdown", "journal"]
let g:code_block_databricks_notebook_identifier = "COMMAND ----------"
let g:code_block_type_annotation_priority = [g:code_block_suffix, "python", "sql", "console", g:code_block_databricks_notebook_identifier, "scala", "rust", "julia"]

function! CodeBlock()
    if index(g:code_block_alt_file_types, &filetype) >= 0
        let g:code_block_comment = "```"
    else
        let g:code_block_comment = substitute(substitute(&commentstring, '%s', '', 'g'), '\s\+', '', 'g')
    endif
    let g:code_block_current = g:code_block_comment . ' ' . g:code_block_suffix
    return g:code_block_current
endfunction
let g:code_block_current = CodeBlock()

function! UpdateCodeBlockSuffix()
    let g:code_block_suffix = input("Enter the code block type suffix: ")
endfunction

function! CycleCodeBlockSuffix()
    let ind = index(g:code_block_type_annotation_priority, g:code_block_suffix)
    if ind >= 0
        if ind == len(g:code_block_type_annotation_priority) - 1
            let g:code_block_suffix = g:code_block_type_annotation_priority[0]
        else
            let g:code_block_suffix = g:code_block_type_annotation_priority[ind + 1]
        endif
    else
        let g:code_block_type_annotation = g:code_block_type_annotation_priority[0]
    endif
    echo "Selected: " .. g:code_block_suffix
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

let g:python_format_on_save = 1
let g:python_bin = substitute($MYVIMRC, "/init.vim", "", "") . '/.venv/bin/'
let g:python3_host_prog = g:python_bin . 'python3'
let g:ipython3_host_prog = g:python_bin . 'ipython'
function! ToggleFormat()
    if g:python_format_on_save == 1
        let g:python_format_on_save = 0
        echo "Formatting disabled"
    else
        let g:python_format_on_save = 1
        echo "Formatting enabled"
    endif
endfunction

function! PyFormat()
    if g:python_format_on_save == 1
        execute "!" . g:python3_host_prog . " -m ruff %"
        execute "e!"
    endif
endfunction

let g:mini_jump_val = '5'
let g:large_jump_val = '30'
let g:section_filetypes = ['python']
function! Sections(big=0, forward=1, context=1)
    let out = ''
    if a:context == 1
        if index(g:section_filetypes, &filetype) >= 0
            if a:big == 1
                if a:forward == 1
                    let out = ']]'
                else
                    let out = '[]'
                endif
            else
                if a:forward == 1
                    let out = ']m'
                else
                    let out = '[m'
                endif
            endif
        else
            if a:big == 1
                if a:forward == 1
                    let out = ']m'
                else
                    let out = '[m'
                endif
            else
                if a:forward == 1
                    let out = '}'
                else
                    let out = '{'
                endif
            endif
        endif
    else
        echo "no context"
        if a:big == 0
            echo "not big"
            if a:forward == 1
                echo "forward"
                let out = g:mini_jump_val . 'j'
            else
                echo "backwards"
                let out = g:mini_jump_val . 'k'
            endif
        else
            echo "big"
            if a:forward == 1
                echo "forward"
                let out = g:large_jump_val . 'j'
            else
                echo "backwards"
                let out = g:large_jump_val . 'k'
            endif
        endif
    endif
    return out . Centerizer()
endfunction

function! ResizePane(amount="-5")
    if winwidth(0) != &columns
        return ':vertical resize ' . a:amount
    else
        return ':resize ' . a:amount
    endif
endfunction

function! MovePane(direction=1)
    if winwidth(0) != &columns
        if a:direction == 1
            return '<C-w>l<CR>'
        else
            return '<C-w>h<CR>'
        endif
    else
        if a:direction == 1
            return '<C-w>k<CR>'
        else
            return '<C-w>j<CR>'
        endif
    endif
endfunction

function! WindowProportion(prop=0.2)
    let window_size = line('w$') - line('w0')
    let jump_size = window_size * a:prop
    return float2nr(jump_size)
endfunction

function! AdjustShowBreak()
    let real_numberwidth = strlen(line('$'))
    let &showbreak = repeat("\ ", max([&nuw, real_numberwidth]))
endfunction

"
" #variables ish
"

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
set guifont=JetBrains\ Mono\ 13
set fillchars+=vert:\│
set completeopt=menu,menuone,noselect
set shell=fish
set splitright
set conceallevel=0
set signcolumn=yes:1
set guicursor+=i:blinkon1,v:blinkon1
set cpoptions+=n
set showbreak=...

" #globalvars ish
let g:indentLine_char = '▏'
let g:indentLine_defaultGroup = 'NonText'
let g:vim_json_syntax_conceal = 0
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_folding_disabled = 0
let g:conceallevel = 0
let g:python3_host_prog = g:python3_host_prog
let g:pydocstring_enable_mapping = 0
let g:copilot_no_tab_map = v:true
let g:signify_sign_add = '│'
let g:signify_sign_delete = '│'
let g:signify_sign_change = '│'
let g:indentLine_char = '▏'
let g:indentLine_defaultGroup = 'NonText'
let g:vim_json_syntax_conceal = 0
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_folding_disabled = 0
let g:conceallevel = 0
let g:cursorhold_updatetime = 100
let g:context_nvim_no_redraw = 1
let g:mergetool_layout = 'mr'
let g:mergetool_prefer_revision = 'local'
let g:rbql_with_headers = 1
let g:terraform_fmt_on_save = 1
let g:terraform_align = 1
let g:repl_split = 'bottom'
let g:repl_filetype_commands = {'python': g:ipython3_host_prog . " --no-autoindent" , 'rust': 'evcxr'}
let g:big_jump = 0.25
let g:small_jump = 0.1

" #autcmd ish
autocmd FileType * set formatoptions-=ro
autocmd BufRead,BufNewFile *.hcl set filetype=hcl
autocmd BufRead,BufNewFile *.tf,*.tfvars set filetype=terraform
autocmd BufRead,BufNewFile *.tfstate,*.tfstate.backup set filetype=json
autocmd BufRead,BufNewFile .terraformrc,terraform.rc set filetype=hcl
autocmd Filetype terraform setlocal ts=2 sw=2 expandtab
autocmd Filetype hcl setlocal ts=2 sw=2 expandtab
autocmd BufWritePre *.tfvars lua vim.lsp.buf.format()
autocmd BufWritePre *.tf lua vim.lsp.buf.format()
autocmd BufRead,BufNewFile *.csv.txt set filetype=csv
autocmd BufRead,BufNewFile *.tsv.txt set filetype=tsv
autocmd BufRead,BufNewFile *.toml set filetype=toml
autocmd FileType csv nmap <C-f> :call ToggleMappings()<CR>
autocmd FileType tsv nmap <C-f> :call ToggleMappings()<CR>
autocmd FileType python nmap <leader><C-f> :call PyFormat()<CR>
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType css setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType xml setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType toml setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType lua setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType htmldjango inoremap {% {%  %}<left><left><left>
autocmd FileType markdown setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType journal setlocal shiftwidth=2 tabstop=2 softtabstop=2
command! BW :bn|:bd#

" #highlight ish
highlight SignColumn guibg=NONE
highlight LspInlayHint guifg=#ffffc5 gui=bold,underdotted
highlight QuickFixLine guifg=#f6cd61 gui=bold
highlight TabLineSel guifg=#f6cd61 gui=bold
highlight TabLineFill guifg=#f6cd61 gui=bold

" Copilot
let g:copilot_enabled = v:false
imap <silent><script><expr> <C-c> copilot#Accept("\<CR>")
imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")
imap <C-]> <Plug>(copilot-next)
imap <C-[> <Plug>(copilot-previous)
imap <C-e> <Plug>(copilot-dismiss)
imap <C-s> <Plug>(copilot-suggest)

" Terminal
tmap kj <C-\><C-n>
tmap <Esc><Esc> <c-\><c-n>
tmap <C-Space><C-Space> <c-\><c-n><C-w><C-w>
tmap <C-q> <C-\><C-n>:q!<CR>
tmap <expr> <C-d> '<C-\><C-n>' . CloseIt() . '<CR>'
tmap <C-w><C-w> <C-\><C-n><C-w><C-w>
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert
nmap <expr> <space><C-t> ":cd %:p:h<CR><Esc><C-t>"
nmap <leader><leader>t :call OpenTerm()<CR>

" Core
inoremap <S-CR> <Esc>
nmap \ :NvimTreeFindFileToggle<CR>:set number<CR>:set nowrap<CR>
nmap <leader><leader>r :so ~/.config/nvim/init.vim<CR>
nmap <leader><leader><leader>t :call TrimWhitespace()<CR>
nmap <silent> <leader><leader><leader>h :noh<CR>
nmap <expr> <leader><leader>d CloseIt() . '<CR>'
xmap <expr> <leader><leader>d CloseIt() . '<CR>'
nmap <leader><leader>w <cmd>w!<CR>
nmap <leader><leader>q <cmd>q!<CR>
nmap <C-q> <cmd>q!<CR>
nmap <C-]> :cnext<CR>
nmap <C-[> :cprevious<CR>
nmap <silent> <leader><Tab> <cmd>BufferPick<CR>
nmap <Tab> :BufferNext<CR>
nmap <S-Tab> :BufferPrevious<CR>
xmap <leader><leader>w <cmd>w!<CR>
xmap <leader><leader>q <cmd>q!<CR>

" Telescope mappings
nnoremap <C-space>ff <cmd>Telescope find_files<cr>
noremap <C-space>fg <cmd>Telescope live_grep<cr>
nnoremap <C-space>fb <cmd>Telescope buffers<cr>
nnoremap <C-space>fh <cmd>Telescope help_tags<cr>
nnoremap <C-space>f/ <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <C-space>hm <cmd>lua require("harpoon.mark").add_file()<CR>
nnoremap <C-space>hh <cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap <C-space>h] <cmd>lua require("harpoon.ui").nav_next()<CR>
nnoremap <C-space>h[ <cmd>lua require("harpoon.ui").nav_prev()<CR>
nnoremap <C-space>h1 <cmd>lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <C-space>h2 <cmd>lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <C-space>h3 <cmd>lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <C-m>h <cmd>Telescope harpoon marks<CR>
nnoremap <leader>gm <cmd>MergetoolToggle<CR>

"
" Python repl mappings
"
nnoremap <Leader>rt <Cmd>ReplToggle<CR>
nmap <Leader>rc <Plug>ReplSendCell
nmap <Leader>rr <Plug>ReplSendLine
xmap <Leader>r  <Plug>ReplSendVisual

""
" Normal remaps
"
nnoremap <Esc> <Nop>
nmap <space> <leader>
nmap <space><space> <leader>

" window stuff
nmap W <C-w><C-w>
nmap <Esc><Esc><Esc> <C-w><C-w>
nmap <leader>w <C-w><C-w>
nmap <C-Space><C-Space> <C-w><C-w>
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
" nnoremap <expr> J 'J' . Centerizer()
" nnoremap <expr> K 'K' . Centerizer()
nnoremap <expr> D '}' . Centerizer()
nnoremap <expr> U '{' . Centerizer()
nnoremap <expr> <C-d> '<C-d>' . Centerizer()
nnoremap <expr> <C-u> '<C-u>' . Centerizer()
nnoremap <expr> L 'w' . Centerizer()
nnoremap <expr> H 'ge' . Centerizer()
nmap <expr> <leader>j WindowProportion(g:small_jump) . 'j' . Centerizer()
nmap <expr> <leader>k WindowProportion(g:small_jump) . 'k' . Centerizer()
nmap <expr> <C-j> WindowProportion(g:big_jump) . 'j' . Centerizer()
nmap <expr> <C-k> WindowProportion(g:big_jump) . 'k' . Centerizer()
nnoremap <expr> j 'j' . Centerizer()
nnoremap <expr> k 'k' . Centerizer()
nnoremap <expr> n 'n' . Centerizer()
nnoremap <expr> N 'N' . Centerizer()

nnoremap <leader>u J
nnoremap <leader>l g_
nnoremap <leader>h _
nnoremap <C-g> J

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
nnoremap <C-s> <cmd>Pounce<CR>

nnoremap <C-space>j o<Esc>_C<Esc>
nnoremap <C-space>k O<Esc>_C<Esc>
nnoremap <C-m>ls :MarksListBuf<CR>
nnoremap <leader>B <cmd>call Toggle_Venn()<CR>
nnoremap <C-m>la :MarksListGlobal<CR>
nmap <C-f> :set conceallevel=0<CR>
nnoremap t<C-c> zz:call ToggleCenterizer()<CR>
nnoremap t<C-a> :call CycleCodeBlockSuffix()<CR>
nnoremap t<C-t> :call UpdateCodeBlockSuffix()<CR>
nnoremap <expr> <C-i> "o<Esc>_C" . CodeBlock() . '<CR><Esc>'
nnoremap <expr> <C-b> "a" . CodeBlock() . ' '

" time stuff
nmap <expr> <leader>dt 'a' . strftime("%Y-%m-%d") . '<Esc>'
nmap <expr> <leader>ts 'a' . strftime("%Y-%m-%d:%H:%M") . '<Esc>'
nmap <expr> <leader>fts 'a' . strftime("%Y-%m-%d %H:%M %a %b") . '<Esc>'
nmap <expr> <leader>day 'a' . strftime("%a %b %d %Y %H:%M") . '<Esc>'

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
inoremap <expr> <C-i> "<Esc>o<Esc>_C" . CodeBlock() . '<CR>'
inoremap <expr> <C-b> CodeBlock() . ' '

" Visual remaps
xmap <space> <leader>
xmap <space><space> <leader>
xnoremap < <gv
xnoremap > >gv
xnoremap <leader>l g_
xnoremap <leader>h _
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
xnoremap <leader>l g_
xnoremap <leader>h _
xnoremap <expr> <C-i> "o" . CodeBlock() . '<CR><Esc>'
xnoremap <expr> <C-b> "a" . CodeBlock() . '<Esc>'

xnoremap <expr> j 'j' . Centerizer()
xnoremap <expr> k 'k' . Centerizer()
xnoremap <expr> n 'n' . Centerizer()
xnoremap <expr> N 'N' . Centerizer()
xnoremap <expr> D '}' . Centerizer()
xnoremap <expr> U '{' . Centerizer()
xnoremap <expr> <C-d> '<C-d>' . Centerizer()
xnoremap <expr> <C-u> '<C-u>' . Centerizer()
xnoremap <expr> L 'w' . Centerizer()
xnoremap <expr> H 'ge' . Centerizer()
xnoremap <expr> j 'j' . Centerizer()
xnoremap <expr> k 'k' . Centerizer()
xnoremap <expr> n 'n' . Centerizer()
xnoremap <expr> N 'N' . Centerizer()
xmap <expr> <leader>j WindowProportion(g:small_jump) . 'j' . Centerizer()
xmap <expr> <leader>k WindowProportion(g:small_jump) . 'k' . Centerizer()
xmap <expr> <C-j> WindowProportion(g:big_jump) . 'j' . Centerizer()
xmap <expr> <C-k> WindowProportion(g:big_jump) . 'k' . Centerizer()
