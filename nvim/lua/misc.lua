local M = {}

-- %% util functions
function M.move_pane(direction)
    direction = direction or 1
    if vim.fn.winwidth(0) ~= vim.o.columns then
        return direction == 1 and '<C-w>l<CR>' or '<C-w>h<CR>'
    end
    return direction == 1 and '<C-w>k<CR>' or '<C-w>j<CR>'
end

function M.git_permalink()
    local l1 = vim.fn.getpos("'<")[2]
    local l2 = vim.fn.getpos("'>")[2]
    local url = vim.trim(vim.fn.system("gurl " .. vim.fn.expand('%:p') .. " -l " .. l1 .. ":" .. l2))
    print(url)
    vim.fn.setreg('+', url)
end

function M.syn_stack()
    if vim.fn.exists("*synstack") == 0 then return end
    local names = vim.tbl_map(function(id) return vim.fn.synIDattr(id, "name") end,
        vim.fn.synstack(vim.fn.line('.'), vim.fn.col('.')))
    print(vim.inspect(names))
end

-- %% config stuff
local config = vim.fn.stdpath("config")
vim.g.python_bin = config .. '/venv/bin/'
vim.g.python_venv_dir = config .. '/venv/'
vim.g.python3_host_prog = vim.g.python_bin .. 'python3'
vim.g.ipython3_host_prog = vim.g.python_bin .. 'ipython'

vim.g.vim_json_syntax_conceal = 0
vim.g.copilot_no_tab_map = true
vim.g.copilot_enabled = true
vim.g.conceallevel = 0
vim.g.mergetool_layout = 'mr'
vim.g.mergetool_prefer_revision = 'local'

-- %% filetypes
vim.api.nvim_create_autocmd('FileType', {
    pattern = '*',
    command = 'set formatoptions-=ro',
})

local function ft(pattern, filetype)
    vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
        pattern = pattern,
        callback = function() vim.bo.filetype = filetype end,
    })
end
ft('*.hcl', 'hcl')
ft({ '*.tf', '*.tfvars' }, 'terraform')
ft({ '*.tfstate', '*.tfstate.backup' }, 'json')
ft({ '.terraformrc', 'terraform.rc' }, 'hcl')
ft('*.csv.txt', 'csv')
ft('*.tsv.txt', 'tsv')
ft('*.toml', 'toml')

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'terraform', 'hcl' },
    command = 'setlocal ts=2 sw=2 expandtab',
})
vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = { '*.tf', '*.tfvars' },
    callback = function() vim.lsp.buf.format() end,
})

-- toggle conceal level
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'csv', 'tsv' },
    callback = function()
        vim.keymap.set('n', '<leader>f', ':call ToggleMappings()<CR>', { remap = true, buffer = true })
    end,
})

return M
