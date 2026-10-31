local M = {}

-- deal with annoying unconceal logic from plugin
vim.g.enforce_conceal = 1
vim.opt.conceallevel = 0

local events = { "CursorMoved", "VimEnter", "BufEnter", "WinEnter", "TabEnter" }
local group = vim.api.nvim_create_augroup("ConcealEnforcement", { clear = false })

local function conceal_it()
    if vim.g.enforce_conceal ~= 0 and vim.wo.conceallevel > 0 then
        vim.opt.conceallevel = 0
    end
end

local function enforce()
    vim.api.nvim_create_autocmd(events, { group = group, callback = conceal_it })
end

enforce()

function M.toggle()
    if vim.wo.conceallevel == 0 then
        vim.opt.conceallevel = 2
        vim.b.enforce_conceal = 0
        vim.api.nvim_clear_autocmds({ group = group, event = events })
    else
        vim.opt.conceallevel = 0
        vim.b.enforce_conceal = 1
        enforce()
    end
end

return M
