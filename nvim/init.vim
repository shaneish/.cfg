let vimrc = substitute($MYVIMRC, "/init.vim", "", "") . "/.vimrc"
let theme = substitute($MYVIMRC, "/init.vim", "", "") . "/theme.vim"
if filereadable(vimrc)
    if has('win64')
        source $HOME/AppData/Local/nvim/.vimrc
    else
        source $HOME/.config/nvim/.vimrc
    endif
else
    source $HOME/.vimrc
endif
if filereadable(theme)
    if has("win64")
        source $HOME/AppData/Local/nvim/theme.vim
    else
        source $HOME/.config/nvim/theme.vim
    endif
endif

" plug-ish ish
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
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-abolish'
Plug 'scrooloose/nerdcommenter'
Plug 'Yggdroot/indentLine'
Plug 'dkarter/bullets.vim'
Plug 'wellle/context.vim'
Plug 'hashivim/vim-terraform'
Plug 'ThePrimeagen/harpoon'
Plug 'rlane/pounce.nvim'
Plug 'ggandor/leap.nvim'
Plug 'ellisonleao/glow.nvim'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'rhysd/conflict-marker.vim'
Plug 'cameron-wags/rainbow_csv.nvim'
Plug 'hat0uma/csvview.nvim'
Plug 'duane9/nvim-rg'
Plug 'github/copilot.vim'
Plug 'UnsafeOats/oatjump.nvim'
Plug 'folke/zen-mode.nvim'
Plug 'chentoast/marks.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'oatish/smartcolumn.nvim'
Plug 'norcalli/nvim-colorizer.lua'
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
Plug 'Klafyvel/vim-slime-cells'
call plug#end()

" Lua-ish ish
lua << EOF
require('load-all')
EOF

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

let g:code_block_comment = substitute(substitute(&commentstring, '%s', '', 'g'), '\s\+', '', 'g')
let g:code_block_suffix = "%%"
let g:code_block_databricks_notebook_identifier = "COMMAND ----------"
let g:code_block_alt_file_types = ["md", "markdown", "rmd", "rmarkdown", "journal"]
let g:code_block_type_annotation_priority = [g:code_block_suffix,  g:code_block_databricks_notebook_identifier]

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
    let g:code_block_current = CodeBlock()
    let g:slime_cell_delimiter = CodeBlock()
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
    let g:code_block_current = CodeBlock()
    let g:slime_cell_delimiter = CodeBlock()
    silent call feedkeys("i \<Esc>x", "i")
    echo "Selected: " .. g:code_block_suffix
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

let g:python_bin = substitute($MYVIMRC, "/init.vim", "", "") . '/venv/bin/'
let g:python_venv_dir = substitute($MYVIMRC, "/init.vim", "", "") . '/venv/'
let g:python3_host_prog = g:python_bin . 'python3'
let g:ipython3_host_prog = g:python_bin . 'ipython'
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
let g:slime_cells_fg_gui = synIDattr(synIDtrans(hlID("CursorLineNR")), "fg#")
let g:slime_cells_bg_gui = synIDattr(synIDtrans(hlID("CursorLine")), "bg#")

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
autocmd FileType csv nmap <C-f><C-f> :call ToggleMappings()<CR>
autocmd FileType tsv nmap <C-f><C-f> :call ToggleMappings()<CR>

" Copilot
let g:copilot_enabled = v:false
imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")
imap <C-]> <Plug>(copilot-next)
imap <C-[> <Plug>(copilot-previous)
imap <C-e> <Plug>(copilot-dismiss)
imap <C-s> <Plug>(copilot-suggest)

" Terminal
nmap <leader><leader>t :call OpenTerm()<CR>

" Maps
nmap \ :NvimTreeFindFileToggle<CR>:set number<CR>:set nowrap<CR>
nmap <silent> <leader><Tab> <cmd>BufferPick<CR>
nnoremap <C-f><C-f> :lua vim.lsp.buf.formatting()<CR>

" Plugin mappings
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

" slime stuff
nmap <C-c><C-n> :call WeztermSlimePane()<CR>
nmap <C-c><C-p> <Plug>SlimeParagraphSend
nmap <C-c><C-c> <Plug>SlimeSendCell
nmap <C-c><C-l> <Plug>SlimeLineSend
nmap <C-c><C-s> <Plug>SlimeConfig
nmap <c-c><c-m> <Plug>SlimeCellsSendAndGoToNext
nmap <c-c><c-j> <Plug>SlimeCellsNext
nmap <c-c><c-k> <Plug>SlimeCellsPrev
xmap <C-c><C-c> <Plug>SlimeRegionSend

nnoremap <C-s> <cmd>Pounce<CR>
nnoremap <C-m>ls :MarksListBuf<CR>
nnoremap <C-m>la :MarksListGlobal<CR>
nnoremap <C-t><C-t> :call CycleCodeBlockSuffix()<CR>:echo "Cell delimiter: " . g:code_block_current<CR>
nnoremap <C-t><C-n> :call UpdateCodeBlockSuffix()<CR>
nnoremap <expr> <C-t><C-b> "A" . CodeBlock() . '<Esc>'
nnoremap <expr> <C-t><C-j> "o" . CodeBlock() . '<Esc>'
nnoremap <expr> <C-t><C-k> "O" . CodeBlock() . '<Esc>'
nnoremap <expr> <C-t><C-j><C-j> "o" . CodeBlock() . '<CR>'
nnoremap <expr> <C-t><C-k><C-k> "O" . CodeBlock() . '<Esc>O'

" if has('win64')
"     source $HOME/AppData/Local/nvim/theme.vim
" else
"     source $HOME/.config/nvim/theme.vim
" endif

