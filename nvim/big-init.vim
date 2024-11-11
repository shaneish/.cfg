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
" Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
" Plug 'tpope/vim-repeat'
" Plug 'daisuzu/autorepeat.vim'
Plug 'oatish/autoclose.nvim'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-abolish'
Plug 'scrooloose/nerdcommenter'
Plug 'Yggdroot/indentLine'
Plug 'chrisbra/Colorizer'
Plug 'dkarter/bullets.vim'
Plug 'wellle/context.vim'
Plug 'hashivim/vim-terraform'
Plug 'ThePrimeagen/harpoon'
Plug 'samoshkin/vim-mergetool'
Plug 'rlane/pounce.nvim'
Plug 'ggandor/leap.nvim'
Plug 'booperlv/nvim-gomove'
Plug 'ellisonleao/glow.nvim'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
" Plug 'VonHeikemen/lsp-zero.nvim'
Plug 'rhysd/conflict-marker.vim'
Plug 'cameron-wags/rainbow_csv.nvim'
Plug 'hat0uma/csvview.nvim'
Plug 'SmiteshP/nvim-navic'
Plug 'duane9/nvim-rg'
Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
Plug 'github/copilot.vim'
Plug 'UnsafeOats/oatjump.nvim'
Plug 'folke/zen-mode.nvim'
Plug 'chentoast/marks.nvim'
Plug 'ziglang/zig.vim'
Plug 'psf/black', { 'branch': 'stable' }
Plug 'tjdevries/colorbuddy.vim'
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' }
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junegunn/limelight.vim'
" Plug 'junegunn/vim-journal'
Plug 'kyazdani42/nvim-web-devicons'
" Plug 'romgrk/barbar.nvim'
Plug 'oatish/smartcolumn.nvim'
" Plug 'akinsho/bufferline.nvim'
" Plug 'mikesmithgh/kitty-scrollback.nvim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'jbyuki/venn.nvim'
Plug 'pappasam/nvim-repl'
Plug 'scalameta/nvim-metals'
call plug#end()

filetype plugin indent on
filetype plugin on
let mapleader=" "
let maplocalleader="\\"
source $HOME/.config/nvim/theme.vim
syntax on

"
" Lua-ish ish
"
lua << EOF
servers = { "terraformls", "pyright", "lua_ls", "vimls", "rust_analyzer", "zls", "tflint" }
require('treesitter-config')
require('nvim-cmp-config')
require('lspconfig-config')
require('telescope-config')
require('lualine-config')
require('nvim-tree-config')
require('diagnostics')
require('telescope').load_extension('harpoon')
require('repl-block-highlight').setup({
  default_highlight_group = "DiffDelete"
})
require("autoclose").setup({
   options = {
      disabled_filetypes = { "text" },
      disable_when_touch = false,
      touch_regex = "[%w(%[{]",
      bidirectional_disable_when_touch = true,
      pair_spaces = false,
      auto_indent = true,
      disable_command_mode = false,
   },
disabled = false,
})
require("gomove").setup({
  map_defaults = false,
  reindent = true,
  undojoin = true,
  move_past_end_col = false,
})
require('glow').setup({
    width = 120,
    height = 140,
    install_path = '/usr/bin/glow'
})
require('mason').setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
require('mason-lspconfig').setup {
    ensure_installed = servers
}
require('leap').add_default_mappings()
require('csvview').setup()
require('rainbow_csv').setup()
require('marks').setup({
  default_mappings = true,
  builtin_marks = { ".", "<", ">", "^" },
  cyclic = true,
  force_write_shada = false,
  refresh_interval = 250,
  sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
  excluded_filetypes = {},
  bookmark_0 = {
      sign = "⚑",
      virt_text = "bookmarks",
      annotate = false,
  },
  mappings = {}
})
require('oatjump').setup()
require("smartcolumn").setup({
    colorcolumn = 140,
    limit_to_window = true,
})
require('colorizer').setup()
vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = false
        })
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<c-space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<c-space>q', vim.diagnostic.setloclist, opts)
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gh', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'hi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gwa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', 'gwr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', 'gwl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<C-space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<C-space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<C-space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local metals_config = require("metals").bare_config()
metals_config.on_attach = function(client, bufnr)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
  vim.keymap.set("n", "gh", vim.lsp.buf.hover)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
  vim.keymap.set("n", "gr", vim.lsp.buf.references)
  vim.keymap.set("n", "gds", vim.lsp.buf.document_symbol)
  vim.keymap.set("n", "gws", vim.lsp.buf.workspace_symbol)
  vim.keymap.set("n", "<C-space>cl", vim.lsp.codelens.run)
  vim.keymap.set("n", "gs", vim.lsp.buf.signature_help)
  vim.keymap.set("n", "<C-space>rn", vim.lsp.buf.rename)
  vim.keymap.set("n", "<C-space>f", vim.lsp.buf.format)
  vim.keymap.set("n", "<C-space>ca", vim.lsp.buf.code_action)
  vim.keymap.set("n", "gws", function()
    require("metals").hover_worksheet()
  end)
end
local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt", "java" },
  callback = function()
    require("metals").initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})
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

let g:venn_enabled = 0
function! Toggle_Venn()
    if g:venn_enabled
        let g:venn_enabled = 0
        set ve=
    else
        set ve=all
        let g:venn_enabled = 1
    endif
endfunction

function! CloseIt()
    if len(win_findbuf(bufnr('%'))) > 1
        return ':clo'
    else
        return ':silent! bd!'
    endif
endfunction

" comment comment_suffix_separator suffix type_separator (type_annotation)
let g:jump_pattern = "\(\s\+\|_\|-\|.\|'\|\^\|\$\)\w"
let g:code_block_comment = substitute(substitute(&commentstring, '%s', '', 'g'), '\s\+', '', 'g')
let g:code_block_comment_alt = "```"
let g:code_block_comment_suffix_separator = " "
let g:code_block_comment_suffix_separator_alt = ""
let g:code_block_suffix = "%%"
let g:code_block_suffix_alt = ""
let g:code_block_active_alt = 0
let g:code_block_suffix_type_separator = " "
let g:code_block_inferred = 1
let g:code_block_type_annotation = ""
let g:code_block_type_annotation_priority = ["", "python", "sql", "json", "rust", "scala", "lua", "sh", "vim", "r", "console", "toml", "yaml"]
let g:code_block_non_comment_file_types = ["md", "markdown", "rmd", "rmarkdown", "journal"]
let g:code_block_is_databricks_notebook = 0
let g:code_block_no_end = 0
let g:code_block_databricks_notebook = 0
let g:code_block_databricks_notebook_suffix = "COMMAND ----------"
let g:code_block_databricks_notebook_suffix_sep = "\n%"
let g:code_block_current = g:code_block_comment . g:code_block_comment_suffix_separator . g:code_block_suffix

function! GetCodeBlockSuffix()
    if g:code_block_databricks_notebook == 1
        return g:code_block_databricks_notebook_suffix
    end
    if g:code_block_active_alt == 0
        return g:code_block_suffix
    else
        return g:code_block_suffix_alt
    endif
endfunction

function! ToggleCodeBlockAlt()
    if g:code_block_active_alt == 0
        let g:code_block_active_alt = 1
    else
        let g:code_block_active_alt = 0
    endif
endfunction

function! GetCodeBlockTypeSeparator()
    if g:code_block_databricks_notebook == 1
        return g:code_block_databricks_notebook_suffix_sep
    end
    return g:code_block_suffix_type_separator
endfunction

function! GetCodeBlockSuffixSeparator()
    if g:code_block_databricks_notebook == 1
        return " "
    end
    if g:code_block_active_alt == 0
        return g:code_block_comment_suffix_separator
    else
        return g:code_block_comment_suffix_separator_alt
    endif
endfunction

function! GetCodeBlockComment()
    if g:code_block_inferred == 1
        if index(g:code_block_non_comment_file_types, &filetype) >= 0
            let g:code_block_active_alt = 1
        else
            let g:code_block_comment = substitute(substitute(&commentstring, '%s', '', 'g'), '\s\+', '', 'g')
        endif
        let g:code_block_inferred = 0
    endif
    if g:code_block_active_alt == 0
        return g:code_block_comment
    else
        return g:code_block_comment_alt
    endif
endfunction

function! GetBaseBlockIdentifier()
    let block = GetCodeBlockComment() . GetCodeBlockSuffixSeparator() . GetCodeBlockSuffix()
    let g:code_block_current = block
    return block
endfunction

function! GetBlockIdentifier(append=0)
    let block = GetBaseBlockIdentifier()
    if a:append == 1
        return block . GetCodeBlockTypeSeparator() . g:code_block_type_annotation
    endif
    return block
endfunction

function! UpdateCodeBlockSuffix()
    let g:code_block_suffix = input("Enter the code block suffix: ")
    let g:code_block_comment = substitute(substitute(&commentstring, '%s', ' ', 'g'), '\s\+', ' ', 'g')
    let g:code_block_identifier = g:code_block_comment . g:code_block_suffix
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
    echo g:code_block_type_annotation
endfunction

function! ToggleDatabricksNotebook()
    if g:code_block_databricks_notebook == 1
        let g:code_block_databricks_notebook = 0
    else
        let g:code_block_databricks_notebook = 1
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
    if bufnr != ""
        execute "buffer " . bufnr
    endif
endfunction

" Terminal-ish stuff
let g:term_proportion_default = 2.5
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

let g:term_toggle_window_id = 1000
let g:term_toggle_og_window_id = win_getid()
let g:term_toggle_status = 0
let g:term_toggle_is_vertical = 0
let g:term_toggle_window_size_default = OpenTermSize()
let g:term_toggle_new_term_null_toggle = 1
let g:term_toggle_proportional_resize = 1
function! ToggleTerm()
    if winnr('$') > 1
        let g:term_toggle_is_vertical = winwidth(0) != &columns
        if g:term_toggle_status == 0
            let g:term_toggle_status = 1
            let g:term_toggle_window_id = win_getid()
            if g:term_toggle_is_vertical
                let g:term_toggle_window_size = winwidth(g:term_toggle_window_id)
                execute "vertical resize 1"
            else
                let g:term_toggle_window_size = winheight(g:term_toggle_window_id)
                execute "resize 1"
            endif
            execute "call win_gotoid(" . g:term_toggle_og_window_id . ")"
        else
            let g:term_toggle_status = 0
            let g:term_toggle_og_window_id = win_getid()
            execute "call win_gotoid(" . g:term_toggle_window_id . ")"
            if g:term_toggle_is_vertical == 1
                execute "vertical resize " . g:term_toggle_window_size
            else
                execute "resize " . g:term_toggle_window_size
            endif
        endif
    else
        if g:term_toggle_new_term_null_toggle == 1
            let g:term_toggle_og_window_id = win_getid()
            if g:term_toggle_proportional_resize == 1
                execute "belowright split +term"
                execute "resize " . OpenTermSize()
                execute "startinsert"
            else
                execute "belowright split +term"
                execute "startinsert"
            endif
        else
            echo "No other windows to toggle"
        endif
    endif
endfunction

" TODO: use below function to update terminal toggle logic above
" function! s:win_by_bufname(bufname)
"     let bufmap = map(range(1, winnr('$')), '[bufname(winbufnr(v:val)), v:val]')
"     let thewindow = filter(bufmap, 'v:val[0] =~ a:bufname')[0][1]
"     execute thewindow 'wincmd w'
" endfunction

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

let g:mini_jump_val = '10'
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
        return 'vertical resize ' . a:amount
    else
        return 'resize ' . a:amount
    endif
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

" #highlight ish
highlight SignColumn guibg=NONE
highlight LspInlayHint guifg=#ffffc5 gui=bold

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
tmap <Esc> <C-\><C-n>
tmap <C-q> <C-\><C-n>:q!<CR>
tmap <C-d> <Esc><cmd>bd!<CR>
tmap <leader><leader>d <cmd>clo<CR>
tmap <leader><leader>c <cmd>silent! bd!<CR>
tmap <C-c> <Esc><Esc>:clo<CR>
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert
nmap <expr> <space><C-t> ":cd %:p:h<CR><Esc><C-t>"
nmap <C-t> :call ToggleTerm()<CR>
tmap <C-t> <Esc><Esc>:call ToggleTerm()<CR>

" Core
inoremap <S-CR> <Esc>
nmap \ :NvimTreeFindFileToggle<CR>:set number<CR>:set nowrap<CR>
nmap <leader><leader>r :so ~/.config/nvim/init.vim<CR>
nmap <leader><leader><leader>t :call TrimWhitespace()<CR>
nmap <silent> <leader><leader>h :noh<CR>
nmap <expr> <leader><leader>d CloseIt() . '<CR>'
xmap <expr> <leader><leader>d CloseIt() . '<CR>'
nmap <leader><leader>w <cmd>w!<CR>
nmap <leader><leader>q <cmd>q!<CR>
nmap <C-]> :cnext<CR>
nmap <C-[> :cprevious<CR>
nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprevious<CR>
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
nmap <expr> <leader>- ResizePane("-5")
nmap <expr> <leader>= ResizePane("+5")
nmap <space> <leader>
nmap <space><space> <leader>
nmap W <C-w><C-w>
nmap <leader>cw :clo<Cr><C-w><C-w>
nmap <leader>co <C-w><C-w>:clo<CR>
nnoremap <leader>c <C-w>c
nnoremap <leader>s <C-w>s
nnoremap <C-o> O<Esc>jo<Esc>k
nnoremap O O<Esc>_C
nnoremap o o<Esc>_C
nnoremap <expr><C-d> '<C-d>' . Centerizer()
nnoremap <expr><C-u> '<C-u>' . Centerizer()
nnoremap <expr> <A-C-j> ']]' . Centerizer()
nnoremap <expr> <A-C-k> '[[' . Centerizer()
nnoremap <expr> ) ']m' . Centerizer()
nnoremap <expr> ( '[m' . Centerizer()
nnoremap <expr> <C-0> ']M' . Centerizer()
nnoremap <expr> <C-9> '[M' . Centerizer()
nnoremap <expr> } '}' . Centerizer()
nnoremap <expr> { '{' . Centerizer()
nnoremap <expr> <C-]> ')' . Centerizer()
nnoremap <expr> <C-[> '(' . Centerizer()
nnoremap <expr> J Sections(0, 1, 1)
nnoremap <expr> K Sections(0, 0, 1)
nnoremap <expr> <C-j> Sections(0, 1, 0)
nnoremap <expr> <C-k> Sections(0, 0, 0)
nnoremap <expr> <leader>J Sections(1, 1, 0)
nnoremap <expr> <leader>K Sections(1, 0, 0)
nnoremap <expr> <leader>j Sections(1, 1, 1)
nnoremap <expr> <leader>k Sections(1, 0, 1)
nnoremap <expr> j 'j' . Centerizer()
nnoremap <expr> k 'k' . Centerizer()
nnoremap <expr> n 'n' . Centerizer()
nnoremap <expr> N 'N' . Centerizer()
nnoremap <leader>l g_
nnoremap <leader>h _
nnoremap <leader>y "+y
nnoremap <leader>yw BvE"+y
nnoremap <leader>yy ^vg_"+y
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
nnoremap U J
nnoremap <C-space>j o<Esc>_C<Esc>
nnoremap <C-space>k O<Esc>_C<Esc>
nnoremap <C-m>ls :MarksListBuf<CR>
nnoremap <leader>B <cmd>call Toggle_Venn()<CR>
nnoremap <C-m>la :MarksListGlobal<CR>
nmap <C-f> :set conceallevel=0<CR>
nmap <C-.> <C-W>l
nmap <C-,> <C-W>h
nmap <C-.> <C-W>l
nmap <C-,> <C-W>h
nmap <expr> L g:venn_enabled ? '<C-v>l:VBox<CR>' : 'L'
nmap <expr> H g:venn_enabled ? '<C-v>h:VBox<CR>' : 'H'
nmap <expr> J g:venn_enabled ? '<C-v>j:VBox<CR>' : Sections(0, 1, 1)
nmap <expr> K g:venn_enabled ? '<C-v>k:VBox<CR>' : Sections(0, 0, 1)
nmap <expr> F g:venn_enabled ? '`<hk<C-v>`>lj:VBox<CR>' : 'F'
nmap <expr> <C-space>j g:venn_enabled ? '8J' : '<C-space>j'
nmap <expr> <C-space>k g:venn_enabled ? '8K' : '<C-space>k'
nmap <expr> <C-space>l g:venn_enabled ? '8L' : '<C-space>l'
nmap <expr> <C-space>h g:venn_enabled ? '8H' : '<C-space>h'
nnoremap <leader>o o<Esc>k
nnoremap <leader>O O<Esc>j
nnoremap <leader><leader>o o<Esc>0C
nnoremap <C-space><C-space><C-o> O<Esc>0C
nnoremap <leader>th :/```<CR>NjVnk:noh<CR>
nnoremap <leader>tk :/```<CR>N:noh<CR>
nnoremap <leader>tj :/```<CR>n:noh<CR>
nnoremap t<C-c> zz:call ToggleCenterizer()<CR>
nnoremap t<C-a> :call CycleCodeBlockTypeAnnotation()<CR>
nnoremap t<C-t> :call UpdateCodeBlockTypeSuffix()<CR>
nnoremap t<C-s> :call UpdateCodeBlockSuffix()<CR>
nnoremap t<C-b> :call UpdateCodeBlockComment<CR>
nnoremap t<C-d> :call ToggleDatabricksNotebook()<CR>
nnoremap <expr> <C-space><C-b> CheckLine("C", "o<Esc>o<Esc>_C") . GetBlockIdentifier(1) . '<Esc>o<Esc>_C' . GetBlockIdentifier() . '<Esc>ko<Esc>_C'
nnoremap <expr> <C-space><C-i> CheckLine("C", "o<Esc>o<Esc>_C") . GetBlockIdentifier() . '<Esc>o<Esc>_C' . GetBlockIdentifier() . '<Esc>kA '
nnoremap <expr> <C-i> "o" . GetBlockIdentifier() . '<CR><Esc>'
nnoremap <expr> <C-b> "a" . GetBlockIdentifier(1) . '<Esc>'

" Insert remaps
inoremap  <Esc>
imap <C-l> <Esc>lxi
imap <C-h> <Esc>xha
inoremap <C-k> <Esc>ka
inoremap <C-j> <Esc>ja
inoremap <C-space>l <Esc>A
inoremap <C-space>h <Esc>I
inoremap <C-;> <Esc>A
inoremap <C-h> <Esc>I
inoremap <C-space>j <Esc>o<Esc>_C
inoremap <C-space>k <Esc>O<Esc>_C
inoremap <C-space>C <Esc>lC
inoremap <C-d>l <Esc>lC
inoremap <C-d>h <Esc>v_di
inoremap <C-d>j <Esc>jddkA
inoremap <C-d>k <Esc>kddjA
inoremap <expr> <C-b> CheckLine('', '<Esc>o<Esc>_C') . GetBlockIdentifier(1) . '<Esc>o<Esc>_C' . GetBlockIdentifier() . '<Esc>ko<Esc>_C'
inoremap <expr> <C-i> CheckLine('', '<Esc>o<Esc>_C') . GetBlockIdentifier() . '<Esc>o<Esc>_C' . GetBlockIdentifier() . '<Esc>kA '
inoremap <expr> <C-space><C-b> GetBlockIdentifier(1)
inoremap <expr> <C-space><C-i> GetBlockIdentifier()

" Visual remaps
xmap <space> <leader>
xmap <space><space> <leader>
xnoremap < <gv
xnoremap > >gv
xnoremap <leader>k g_
xnoremap <leader>j _
xnoremap U J
xnoremap <expr> j 'j' . Centerizer()
xnoremap <expr> k 'k' . Centerizer()
xnoremap <expr> n 'n' . Centerizer()
xnoremap <expr> N 'N' . Centerizer()
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
xnoremap <expr> <C-space>V mode() ==# "v" ? "v" : "<C-v>"
xnoremap gg gg0
xnoremap G G$
xnoremap <expr> f g:venn_enabled ? ':VBox<CR>' : 'f'
xmap <expr> F g:venn_enabled ? '<Esc>F' : 'F'
xnoremap <expr> <space>h g:venn_enabled ? '8h' : '<C-h>'
xnoremap <expr> <space>l g:venn_enabled ? '9l' : '<C-l>'
xmap <expr> <A-h> g:venn_enabled ? '<Plug>GoVSMLeft' : '[Mzz'
xmap <expr> <A-j> g:venn_enabled ? '<Plug>GoVSMDown' : ']mzz' . Centerizer()
xmap <expr> <A-k> g:venn_enabled ? '<Plug>GoVSMUp' : '[mzz' . Centerizer()
xmap <expr> <A-l> g:venn_enabled ? '<Plug>GoVSMRight' : ']Mzz'
xnoremap <leader>` <Esc>`<O```<Esc>`>o```<Esc>
xnoremap <C-s> <cmd>Pounce<CR>
xnoremap <Esc> <Nop>
xnoremap <Esc><Esc> <Esc>
xnoremap <expr> <C-b> '<Esc><Esc>`<O<Esc>_C' . GetBlockIdentifier(1) . '<Esc>`><Esc>o' . GetBlockIdentifier() . '<Esc>`<kA '
xnoremap <expr> <C-i> '<Esc><Esc>`<O<Esc>_C' . GetBlockIdentifier() . '<Esc>`><Esc>o' . GetBlockIdentifier() . '<Esc>`>jo<Esc>_C'
xnoremap <leader>l g_l
xnoremap <leader>h _
xnoremap <expr> <A-C-j> ']]' . Centerizer()
xnoremap <expr> <A-C-k> '[[' . Centerizer()
xnoremap <expr> ) ']m' . Centerizer()
xnoremap <expr> ( '[m' . Centerizer()
xnoremap <expr> <C-0> ']M' . Centerizer()
xnoremap <expr> <C-9> '[M' . Centerizer()
xnoremap <expr> } '}' . Centerizer()
xnoremap <expr> { '{' . Centerizer()
xnoremap <expr> <C-]> ')' . Centerizer()
xnoremap <expr> <C-[> '(' . Centerizer()
xnoremap <expr> J Sections(0, 1, 0)
xnoremap <expr> K Sections(0, 0, 0)
xnoremap <expr> <C-j> Sections(0, 1, 1)
xnoremap <expr> <C-k> Sections(0, 0, 1)
xnoremap <expr> <leader>J Sections(1, 1, 0)
xnoremap <expr> <leader>K Sections(1, 0, 0)
xnoremap <expr> <leader>j Sections(1, 1, 1)
xnoremap <expr> <leader>k Sections(1, 0, 1)
