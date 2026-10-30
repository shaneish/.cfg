local codeblocks = require('codeblocks')
local misc = require('misc')
local map = vim.keymap.set

-- Copilot
map('i', '<C-h><C-h>', 'copilot#Accept("\\<CR>")', { expr = true, silent = true, replace_keycodes = false })
map('i', '<C-h><C-l>', '<Plug>(copilot-accept-word)')
map('i', '<C-h><C-a>', '<Plug>(copilot-accept-line)')
map('i', '<C-h><C-j>', '<Plug>(copilot-next)')
map('i', '<C-h><C-k>', '<Plug>(copilot-previous)')
map('i', '<C-h><C-e>', '<Plug>(copilot-dismiss)')
map('i', '<C-h><C-/>', '<Plug>(copilot-suggest)')

-- Buffers -barbar
map('n', '<leader><leader>b', '<cmd>BufferPick<CR>', { remap = true })
map('n', '<leader><leader>g', '<cmd>BufferPick<CR>', { remap = true })
map('n', '<leader>bp', '<cmd>BufferPin<CR>', { remap = true })
map('n', '<leader>br', '<cmd>BufferRestore<CR>', { remap = true })
map('n', '<leader>bo', '<cmd>BufferOrderByDirectory<CR>', { remap = true })
map('n', '<C-]>', '<cmd>BufferMoveNext<CR>', { remap = true })
map('n', '<C-[>', '<cmd>BufferMovePrevious<CR>', { remap = true })
map('n', '<Tab>', '<cmd>BufferNext<CR>', { remap = true, silent = true })
map('n', '<S-Tab>', '<cmd>BufferPrevious<CR>', { remap = true, silent = true })

-- Plugin mappings
map('n', '<leader>tf', '<cmd>Telescope find_files<cr>')
map('n', '<leader>tg', '<cmd>Telescope live_grep<cr>')
map('n', '<leader>tb', '<cmd>Telescope buffers<cr>')
map('n', '<leader>tt', '<cmd>Telescope current_buffer_fuzzy_find<cr>')
map('n', '<leader>gm', '<cmd>MergetoolToggle<CR>')

-- tree climber
local tc_opts = "{highlight = true, timeout = 250, skip_comments = true}"
local function tc(fn) return ":lua require('tree-climber')." .. fn .. "(" .. tc_opts .. ")<CR>" end
local select_node = ":lua require('tree-climber').select_node()<CR>"
vim.api.nvim_create_autocmd({ 'VimEnter', 'BufEnter', 'WinEnter' }, {
    group = vim.api.nvim_create_augroup('TreeClimber', { clear = true }),
    callback = function()
        local o = { silent = true }
        map('n', 'H', tc('goto_parent') .. 'zz', o)
        map('n', 'L', tc('goto_child') .. 'zz', o)
        map('n', 'K', tc('goto_prev') .. 'zz', o)
        map('n', 'J', tc('goto_next') .. 'zz', o)
        map('x', 'H', tc('goto_parent') .. 'zzv' .. select_node, o)
        map('x', 'L', tc('goto_child') .. 'zzv' .. select_node, o)
        map('x', 'J', tc('goto_next') .. 'zzv' .. select_node, o)
        map('x', 'K', tc('goto_prev') .. 'zzv' .. select_node, o)
        map('n', '<C-s><C-j>', ":lua require('tree-climber').swap_next()<CR>zz", o)
        map('n', '<C-s><C-k>', ":lua require('tree-climber').swap_prev()<CR>zz", o)
        map('n', '<leader>v', 'v' .. select_node, o)
        map('n', '<C-y>', 'J', o)
    end,
})

map('n', '<C-s>', '<cmd>Pounce<CR>')
map('n', 'csv', '<cmd>CSVViewToggle<CR>')

-- code blocks
map('n', '<C-t><C-t>', function()
    codeblocks.cycle_suffix()
    print("Cell delimiter: " .. vim.g.code_block_current)
end)
map('n', '<C-t><C-n>', codeblocks.update_suffix)
map('n', '<C-t><C-b>', function() return "0C" .. codeblocks.code_block() .. '<Esc>' end, { expr = true })
map('n', '<C-t><C-j>', function() return "o<Esc>0C" .. codeblocks.code_block() .. '<Esc>k' end, { expr = true })
map('n', '<C-t><C-k>', function() return "O<Esc>0C" .. codeblocks.code_block() .. '<Esc>j' end, { expr = true })

map('n', '<leader><leader>r', '<cmd>source $MYVIMRC<CR>')
map('x', 'gp', function()
    vim.cmd('normal! \27')
    misc.git_permalink()
end)
