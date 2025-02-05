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
Plug 'SmiteshP/nvim-navic'
Plug 'numToStr/Comment.nvim'
Plug 'SmiteshP/nvim-navbuddy'
Plug 'jpalardy/vim-slime'
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

function! CloseIt()
    if len(win_findbuf(bufnr('%'))) > 1
        return ':clo'
    else
        return ':silent! bd!'
    endif
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

" code block functions
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
let g:python_bin = substitute($MYVIMRC, "/init.vim", "", "") . '/venv/bin/'
let g:python_venv_dir = substitute($MYVIMRC, "/init.vim", "", "") . '/venv/'
let g:python3_host_prog = g:python_bin . 'python3'
let g:ipython3_host_prog = g:python_bin . 'ipython'
function! ActivateVenvCmd(venv_dir="")
    let dir = g:python_venv_dir
    if a:venv_dir != ""
        let dir = a:venv_dir
    endif
    let script = "activate"
    let source = "."
    if &shell == "fish"
        let script = "activate.fish"
    elseif &shell == "nu"
        let script = "activate.nu"
    endif
    return source . " " . dir . "bin/" . script
endfunction

function! ReplCommand()
    if &filetype == "python"
        if exists("g:ipython3_host_prog")
            if g:ipython3_host_prog != ""
                return g:ipython3_host_prog . " --no-autoindent"
            endif
        endif
        return "python3 -m ipython --no-autoindent"
    elseif &filetype == "rust"
        return "evcxr"
    elseif &filetype == "julia"
        return "julia"
    elseif &filetype == "fish"
        return "fish"
    elseif &filetype == "sh" || &filetype == "bash"
        return "bash"
    elseif &filetype == "go"
        return "gore"
    else
        let repl = input("Enter command to launch: ")
        return repl
    endif
endfunction

let g:slime_split = "bottom"
function! WezSlimeReplInitCmd(split=g:slime_split, cwd=getcwd())
    let wez_cli = "wezterm"
    if !empty($WSL_INTEROP) || has('windows') == 0
        let wez_cli = wez_cli . ".exe"
    endif
    let cmd = wez_cli . " cli split-pane --" . a:split . " --cwd " . a:cwd . " -- "
    return cmd . ReplCommand()
endfunction

function! WeztermSlimePane()
    let pane_id = system(WezSlimeReplInitCmd())
    let b:slime_config = {"pane_id": trim(pane_id)}
    let g:slime_default_config = {"pane_id": trim(pane_id)}
    let g:slime_dont_ask_default = 1
    let g:slime_cell_delimiter = CodeBlock()
endfunction

function! ResizePane(amount="-5")
    if winwidth(0) != &columns
        return ':vertical resize ' . a:amount
    else
        return ':resize ' . a:amount
    endif
endfunction

function! AdjustShowBreak()
    let real_numberwidth = strlen(line('$'))

    let &showbreak = repeat("\ ", max([&nuw, real_numberwidth]))
endfunction

"
" #variables ish
"

" #highlight ish
highlight SignColumn guibg=NONE
highlight LspInlayHint guifg=#ffffc5 gui=bold,underdotted
highlight QuickFixLine guifg=#f6cd61 gui=bold
highlight TabLineSel guifg=#f6cd61 gui=bold
highlight TabLineFill guifg=#f6cd61 gui=bold

" #settings ish"
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
let g:slime_cell_delimiter = CodeBlock()
let g:slime_target = "wezterm"
let g:conceallevel = 0

" let &t_EI = "\e[2 q"
" let &t_SI = "\e[5 q"

" #autcmd ish
autocmd BufRead,BufNewFile *.toml set filetype=toml
autocmd FileType toml setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType lua setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
autocmd FileType go setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
autocmd FileType haskell setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
autocmd FileType markdown setlocal shiftwidth=2 tabstop=2 softtabstop=2 conceallevel=0

" Copilot
let g:copilot_enabled = v:false
imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")
imap <C-]> <Plug>(copilot-next)
imap <C-[> <Plug>(copilot-previous)
imap <C-e> <Plug>(copilot-dismiss)
imap <C-s> <Plug>(copilot-suggest)

" slime stuff
nmap <C-c><C-n> :call WeztermSlimePane()<CR>
nmap <C-c><C-p> <Plug>SlimeParagraphSend
nmap <C-c><C-c> <Plug>SlimeSendCell
nmap <C-c><C-l> <Plug>SlimeLineSend
nmap <C-c><C-l> <Plug>SlimeLineSend
xmap <C-c><C-c> <Plug>SlimeRegionSend

" Telescope mappings
nnoremap <C-t>ff <cmd>Telescope find_files<cr>
nnoremap <C-t>fg <cmd>Telescope live_grep<cr>
nnoremap <C-t>fb <cmd>Telescope buffers<cr>
nnoremap <C-t>fh <cmd>Telescope help_tags<cr>
nnoremap <C-t>f/ <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <C-t>hm <cmd>lua require("harpoon.mark").add_file()<CR>
nnoremap <C-t>hh <cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap <C-t>h] <cmd>lua require("harpoon.ui").nav_next()<CR>
nnoremap <C-t>h[ <cmd>lua require("harpoon.ui").nav_prev()<CR>
nnoremap <C-t>h1 <cmd>lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <C-t>h2 <cmd>lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <C-t>h3 <cmd>lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <C-m>h <cmd>Telescope harpoon marks<CR>
nnoremap <leader>gm <cmd>MergetoolToggle<CR>
nnoremap <C-g> :Rg

" Terminal
tmap kj <C-\><C-n>
tmap <C-space> <c-\><c-n>
tmap <C-Space><C-Space> <c-\><c-n><C-w><C-w>
tmap <expr> <C-d> '<C-\><C-n>' . CloseIt() . '<CR>'
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert
nmap <leader><leader>t :call OpenTerm()<CR>

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

nnoremap <C-s> <cmd>Pounce<CR>
nnoremap <C-m>ls :MarksListBuf<CR>
nnoremap <C-m>la :MarksListGlobal<CR>
nnoremap <C-f><C-f> :set conceallevel=0<CR>
nnoremap t<C-c> zz:call ToggleCenterizer()<CR>
nnoremap t<C-a> :call CycleCodeBlockSuffix()<CR>
nnoremap t<C-t> :call UpdateCodeBlockSuffix()<CR>
nnoremap <expr> <C-i> "o<CR><Esc>_C" . CodeBlock() . '<CR><CR><Esc>'

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
xnoremap Sd <Esc>`<x`>hx`<v`>hh
