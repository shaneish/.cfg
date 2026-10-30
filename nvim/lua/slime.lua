local codeblocks = require('codeblocks')
local M = {}

vim.g.term_choice = "fish"
vim.g.slime_split = "bottom"
vim.g.slime_target = "wezterm"
vim.g.repl_split = "bottom"

local repls = {
    python = { 'ipython --no-autoindent', 'python3', 'pypy3' },
    rust = { 'evcxr' },
    julia = { 'julia' },
    fish = { 'fish' },
    sh = { 'bash' },
    bash = { 'bash' },
    zsh = { 'zsh' },
    go = { 'gore' },
}

function M.repl_command()
    for _, cmd in ipairs(repls[vim.bo.filetype] or {}) do
        if vim.fn.executable(cmd:match('^%S+')) == 1 then return cmd end
    end
    return vim.g.term_choice
end

function M.wez_init_cmd(split, cwd, repl)
    split = split or vim.g.slime_split
    cwd = cwd or vim.fn.getcwd()
    local wez_cli = "wezterm"
    if vim.env.WSL_INTEROP ~= nil and vim.env.WSL_INTEROP ~= "" or vim.fn.has('windows') == 0 then
        wez_cli = wez_cli .. ".exe"
    end
    return wez_cli .. " cli split-pane --" .. split .. " --cwd " .. cwd .. " -- " .. (repl or "")
end

function M.wezterm_pane(infer)
    local repl_cmd = infer and M.repl_command() or "fish"
    local pane_id = vim.fn.system(M.wez_init_cmd("bottom", vim.fn.getcwd(), repl_cmd))
    print(pane_id)
    vim.b.slime_config = { pane_id = vim.trim(pane_id) }
    vim.g.slime_default_config = { pane_id = vim.trim(pane_id) }
    vim.g.slime_dont_ask_default = 1
    vim.g.slime_cell_delimiter = codeblocks.code_block()
end

-- colors for vim-slime-cells (read after the colorscheme has loaded)
local function hl_attr(group, attr)
    return vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(group)), attr)
end
vim.g.slime_cells_fg_gui = hl_attr("CursorLineNR", "fg#")
vim.g.slime_cells_bg_gui = hl_attr("CursorLine", "bg#")

-- mappings
vim.keymap.set('n', '<leader>ri', function() M.wezterm_pane(false) end)
vim.keymap.set('n', '<leader>rm', '<Plug>SlimeMotionSend', { remap = true })
vim.keymap.set('n', '<leader>rr', '<Plug>SlimeSendCell', { remap = true })
vim.keymap.set('n', '<leader>rs', '<Plug>SlimeConfig', { remap = true })
vim.keymap.set('n', '<leader>rn', '<Plug>SlimeCellsSendAndGoToNext', { remap = true })
vim.keymap.set('n', '<leader>rj', '<Plug>SlimeCellsNext', { remap = true })
vim.keymap.set('n', '<leader>rk', '<Plug>SlimeCellsPrev', { remap = true })
vim.keymap.set('x', '<leader>rr', '<Plug>SlimeRegionSend', { remap = true })

return M
