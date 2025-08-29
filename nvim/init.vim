" GUI color definitions
let g:lsp = "#ffaa33"
let g:lsp_bright = "#934e00"

let nvim_config_dir = substitute($MYVIMRC, "/init.vim", "", "") . "/"
for additional_vim_sources in [".vimrc", "active_theme.vim"]
    let source_file = nvim_config_dir . additional_vim_sources
    if filereadable(source_file)
        execute 'source ' . source_file
    endif
endfor

" " below commented block has been deprecated and should be removed if above
" " loop works
" let vimrc = substitute($MYVIMRC, "/init.vim", "", "") . "/.vimrc"
" if filereadable(vimscript_source)
"     execute 'source ' . vimrc
" else
"     source $HOME/.vimrc
" endif
" let theme = substitute($MYVIMRC, "/init.vim", "", "") . "/active_theme.vim"
" if filereadable(theme)
"     execute 'source ' . theme
" endif

" plug-ish ish
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'SmiteshP/nvim-navic'
Plug 'SmiteshP/nvim-navbuddy'
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
" Plug 'tpope/vim-sensible'
" Plug 'tpope/vim-abolish'
Plug 'Yggdroot/indentLine'
Plug 'dkarter/bullets.vim'
Plug 'wellle/context.vim'
Plug 'hashivim/vim-terraform'
Plug 'rlane/pounce.nvim'
Plug 'ggandor/leap.nvim'
Plug 'ellisonleao/glow.nvim'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'rhysd/conflict-marker.vim'
Plug 'cameron-wags/rainbow_csv.nvim'
Plug 'hat0uma/csvview.nvim'
Plug 'github/copilot.vim'
Plug 'UnsafeOats/oatjump.nvim'
Plug 'folke/zen-mode.nvim'
Plug 'chentoast/marks.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'oatish/smartcolumn.nvim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'scalameta/nvim-metals'
Plug 'czheo/mojo.vim'
Plug 'stevearc/aerial.nvim' " navigate by code structure
Plug 'simrat39/symbols-outline.nvim' " view code structure
Plug 'romgrk/barbar.nvim'
Plug '3rd/image.nvim'
Plug 'numToStr/Comment.nvim'
Plug 'jpalardy/vim-slime'
Plug 'Klafyvel/vim-slime-cells'
Plug 'drybalka/tree-climber.nvim'
Plug 'milanglacier/yarepl.nvim' " https://github.com/milanglacier/yarepl.nvim
Plug 'meatballs/notebook.nvim'
Plug 'sindrets/diffview.nvim'
Plug 'aaronik/treewalker.nvim'
Plug 'jinh0/eyeliner.nvim'
Plug 'jake-stewart/multicursor.nvim'
" Plug 'rhysd/clever-f.vim'
Plug 'CopilotC-Nvim/CopilotChat.nvim'
Plug 'kaarmu/typst.vim'
Plug 'nathanaelkane/vim-indent-guides'
call plug#end()

" %%
" Lua-ish ish
lua << EOF
require('load-all')
EOF

" %%
" util functions
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

" %%
" code block stuff
let g:default_code_block_suffix = "%%"
let g:code_block_databricks_notebook_identifier = "COMMAND ----------"
let g:code_block_alt_file_types = ["md", "markdown", "rmd", "rmarkdown", "journal"]
let g:code_block_databricks_file_types = ["python"]
let g:code_block_type_annotation_priority = [g:default_code_block_suffix,  g:code_block_databricks_notebook_identifier]

function! InferCodeBlockSuffix()
    if index(g:code_block_alt_file_types, &filetype) >= 0
        return ""
    elseif index(g:code_block_databricks_file_types, &filetype) >= 0
        let search_result = search(g:code_block_databricks_notebook_identifier, "n")
        if search_result != 0
            return g:code_block_databricks_notebook_identifier
        endif
    endif
    return g:default_code_block_suffix
endfunction

let g:code_block_suffix = InferCodeBlockSuffix()

function! CodeBlock()
    if index(g:code_block_alt_file_types, &filetype) >= 0
        let g:code_block_comment = "```"
    else
        let g:code_block_comment = substitute(substitute(substitute(&commentstring, '%s', '', 'g'), '\s\+', '', 'g'), '**', '', 'g')
    endif
    let g:code_block_current = g:code_block_comment . ' ' . g:code_block_suffix
    let g:slime_cell_delimiter = g:code_block_current
    return g:code_block_current
endfunction

let g:code_block_current = CodeBlock()
let g:slime_cell_delimiter = CodeBlock()

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

" %%
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

" %%
" slime stuff
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

function! GitPermalink()
    let [_, l1, _, _] = getpos("'<")
    let [_, l2, _, _] = getpos("'>")
    let url = trim(system("gurl " . expand('%:p') . " -l " . l1 . ":" . l2))
    echo url
    let @+ = url
endfunction

function! SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction

" %%
" deal with annoying unconceal logic from plugin
let g:enforce_conceal = 1
set conceallevel=0
let g:indentLine_conceallevel = 2

function! ConcealIt()
    if g:enforce_conceal && (&conceallevel > 0)
        set conceallevel=0
        let g:indentLine_conceallevel=2
    endif
endfunction

augroup ConcealEnforcement
    autocmd CursorMoved,VimEnter,BufEnter,WinEnter,TabEnter * silent :call ConcealIt()
augroup END

function! ToggleConceal()
    if &conceallevel == 0
        set conceallevel=2
        let b:enforce_conceal = 0
        autocmd! ConcealEnforcement CursorMoved,VimEnter,BufEnter,WinEnter,TabEnter * silent
    else
        set conceallevel=0
        let b:enforce_conceal = 1
        autocmd! CursorMoved,VimEnter,BufEnter,WinEnter,TabEnter * silent :call ConcealIt()
    endif
    let g:indentLine_conceallevel=2
endfunction

" %%
" config stuff
let g:python_bin = substitute($MYVIMRC, "/init.vim", "", "") . '/venv/bin/'
let g:python_venv_dir = substitute($MYVIMRC, "/init.vim", "", "") . '/venv/'
let g:python3_host_prog = g:python_bin . 'python3'
let g:ipython3_host_prog = g:python_bin . 'ipython'
let g:indentLine_defaultGroup = 'NonText'
let g:indentLine_conceallevel=2
let g:vim_json_syntax_conceal = 0
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_folding_disabled = 0
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
let g:filetype_commands = {'python': g:ipython3_host_prog . " --no-autoindent" , 'rust': 'evcxr'}
let g:slime_target = "wezterm"
let g:slime_cell_delimiter = CodeBlock()
let g:slime_cells_fg_gui = synIDattr(synIDtrans(hlID("CursorLineNR")), "fg#")
let g:slime_cells_fg_gui = synIDattr(synIDtrans(hlID("CursorLineNR")), "fg#")
let g:slime_cells_bg_gui = synIDattr(synIDtrans(hlID("CursorLine")), "bg#")

augroup CheckEveryTime
    autocmd!
    autocmd VimEnter,BufEnter,WinEnter * highlight SignColumn guibg=NONE
    autocmd VimEnter,BufEnter,WinEnter * highlight LspInlayHint guifg=g:lsp gui=bold,underdotted
    autocmd VimEnter,BufEnter,WinEnter * highlight QuickFixLine guifg=g:cursor_bg gui=bold
    autocmd VimEnter,BufEnter,WinEnter * highlight TabLineSel guifg=g:cursor_bg gui=bold
    autocmd VimEnter,BufEnter,WinEnter * highlight TabLineFill guifg=g:cursor_bg gui=bold
    autocmd VimEnter,BufEnter,WinEnter * highlight BufferCurrent guifg=g:cursor_bg gui=bold
    autocmd VimEnter,BufEnter,WinEnter * highlight BufferCurrentCHANGED guifg=g:warning gui=bold
    autocmd VimEnter,BufEnter,WinEnter * let g:code_block_suffix = InferCodeBlockSuffix()
    autocmd VimEnter,BufEnter,WinEnter * let g:code_block_current = CodeBlock()
    autocmd VimEnter,BufEnter,WinEnter * let g:slime_cell_delimiter = CodeBlock()
    autocmd VimEnter,BufEnter,WinEnter *.txt,*.md,*.typ,*.typst set spell
augroup END


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
autocmd FileType csv nmap <leader>f :call ToggleMappings()<CR>
autocmd FileType tsv nmap <leader>f :call ToggleMappings()<CR>

" Copilot
let g:copilot_enabled = v:true
inoremap <silent><script><expr> <C-l> copilot#Accept("\<CR>")
inoremap <C-j> <Plug>(copilot-next)
inoremap <C-k> <Plug>(copilot-previous)
inoremap <C-h> <Plug>(copilot-dismiss)
inoremap <C-/> <Plug>(copilot-suggest)

" Terminal
nmap T :call OpenTerm()<CR>

" Buffers -barbar
nmap <leader><leader>b <cmd>BufferPick<CR>
nmap <leader><leader>g <cmd>BufferPick<CR>
nmap <leader>bp <cmd>BufferPin<CR>
nmap <leader>br <cmd>BufferRestore<CR>
nmap <leader>bo <cmd>BufferOrderByDirectory<CR>
nmap <silent> <Tab> <cmd>BufferNext<CR>
nmap <silent> <S-Tab> <cmd>BufferPrevious<CR>

" toggle conceal level
nmap <C-f><C-t> :call ToggleConcealLevel()<CR>
imap <C-f><C-t> :call ToggleConcealLevel()<CR>

" Plugin mappings
nnoremap <leader>tf <cmd>Telescope find_files<cr>
nnoremap <leader>tg <cmd>Telescope live_grep<cr>
nnoremap <leader>tb <cmd>Telescope buffers<cr>
nnoremap <leader>tt <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>gm <cmd>MergetoolToggle<CR>

" slime stuff
nmap <C-c><C-n> :call WeztermSlimePane()<CR>
nmap <C-c><C-p> <Plug>SlimeParagraphSend
nmap <C-c><C-c> <Plug>SlimeSendCell
nmap <C-c><C-s> <Plug>SlimeConfig
nmap <C-c><C-m> <Plug>SlimeCellsSendAndGoToNext
nmap <C-c><leader> <Plug>SlimeCellsSendAndGoToNext
nmap <C-c><C-j> <Plug>SlimeCellsNext
nmap <C-c><C-k> <Plug>SlimeCellsPrev
xmap <C-c><C-c> <Plug>SlimeRegionSend

" tree climber
augroup TreeClimber
    autocmd!
    autocmd VimEnter,BufEnter,WinEnter * nnoremap <silent> H :lua require('tree-climber').goto_parent({highlight = true, timeout = 250, skip_comments = true})<CR>zz
    autocmd VimEnter,BufEnter,WinEnter * nnoremap <silent> L :lua require('tree-climber').goto_child({highlight = true, timeout = 250, skip_comments = true})<CR>zz
    autocmd VimEnter,BufEnter,WinEnter * nnoremap <silent> K :lua require('tree-climber').goto_prev({highlight = true, timeout = 250, skip_comments = true})<CR>zz
    autocmd VimEnter,BufEnter,WinEnter * nnoremap <silent> J :lua require('tree-climber').goto_next({highlight = true, timeout = 250, skip_comments = true})<CR>zz
    autocmd VimEnter,BufEnter,WinEnter * xnoremap <silent> H :lua require('tree-climber').goto_parent({highlight = true, timeout = 250, skip_comments = true})<CR>zzv:lua require('tree-climber').select_node()<CR>
    autocmd VimEnter,BufEnter,WinEnter * xnoremap <silent> L :lua require('tree-climber').goto_child({highlight = true, timeout = 250, skip_comments = true})<CR>zzv:lua require('tree-climber').select_node()<CR>
    autocmd VimEnter,BufEnter,WinEnter * xnoremap <silent> J :lua require('tree-climber').goto_next({highlight = true, timeout = 250, skip_comments = true})<CR>zzv:lua require('tree-climber').select_node()<CR>
    autocmd VimEnter,BufEnter,WinEnter * xnoremap <silent> K :lua require('tree-climber').goto_prev({highlight = true, timeout = 250, skip_comments = true})<CR>zzv:lua require('tree-climber').select_node()<CR>
    autocmd VimEnter,BufEnter,WinEnter * nnoremap <silent> <C-s><C-k> :lua require('tree-climber').swap_prev()<CR>zz
    autocmd VimEnter,BufEnter,WinEnter * nnoremap <silent> <C-s><C-j> :lua require('tree-climber').swap_next()<CR>zz
    autocmd VimEnter,BufEnter,WinEnter * nnoremap <silent> <leader>v v:lua require('tree-climber').select_node()<CR>
    autocmd VimEnter,BufEnter,WinEnter * nnoremap <silent> <C-i> J
augroup END

nnoremap <C-s> <cmd>Pounce<CR>
nnoremap <C-t><C-t> :call CycleCodeBlockSuffix()<CR>:echo "Cell delimiter: " . g:code_block_current<CR>
nnoremap <C-t><C-n> :call UpdateCodeBlockSuffix()<CR>
nnoremap <expr> <C-t><C-b> "A" . CodeBlock() . '<Esc>'
nnoremap <expr> <C-t><C-j> "o<Esc>0C" . CodeBlock() . '<Esc>k'
nnoremap <expr> <C-t><C-k> "O<Esc>0C" . CodeBlock() . '<Esc>j'

nmap \ :NvimTreeFindFileToggle<CR>:set number<CR>:set nowrap<CR>
nnoremap <leader><leader>r :source $MYVIMRC<CR>
xnoremap gp <Esc>:call GitPermalink()<CR>

