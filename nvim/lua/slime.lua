local codeblocks = require('codeblocks')
local M = {}

vim.g.term_choice = "fish"
vim.g.slime_split = "bottom"
vim.g.slime_target = "dtach"
vim.g.repl_split = "bottom"

function M.wez_init_cmd(split, cwd, repl)
    split = split or vim.g.slime_split
    cwd = cwd or vim.fn.getcwd()
    local wez_cli = "wezterm"
    if vim.env.WSL_INTEROP ~= nil and vim.env.WSL_INTEROP ~= "" or vim.fn.has('windows') == 0 then
        wez_cli = wez_cli .. ".exe"
    end
    return wez_cli .. " cli split-pane --" .. split .. " --cwd " .. cwd .. " -- " .. (repl or "")
end

-- every repl pane opened via wezterm_pane: { socket_path, pane_id, cmd, cwd }
M.panes = {}

local function use_pane(pane)
    vim.b.slime_config = { socket_path = pane.socket_path }
    vim.g.slime_default_config = { socket_path = pane.socket_path }
    vim.g.slime_dont_ask_default = 1
end

function M.wezterm_pane(infer)
    local repl_cmd = infer and M.repl_command() or "fish"
    local cwd = vim.fn.getcwd()
    local socket = vim.fn.tempname() .. ".sock"
    -- the new wezterm pane runs the repl inside a dtach session on `socket`;
    -- vim-slime's dtach target then sends text to that socket
    local pane_id = vim.fn.system(M.wez_init_cmd("bottom", cwd, "dtach -c " .. vim.fn.shellescape(socket) .. " " .. repl_cmd))
    vim.wait(2000, function() return vim.uv.fs_stat(socket) ~= nil end, 20)
    local pane = { socket_path = socket, pane_id = vim.trim(pane_id), cmd = repl_cmd, cwd = cwd }
    table.insert(M.panes, pane)
    use_pane(pane)
    vim.g.slime_cell_delimiter = codeblocks.code_block()
    print(socket)
end

-- spawn a repl pane; confirm first if one is already open
function M.open_repl(infer)
    M.panes = vim.tbl_filter(function(p) return vim.uv.fs_stat(p.socket_path) ~= nil end, M.panes)
    if #M.panes > 0 and vim.fn.confirm("Open an additional repl pane?", "&Yes\n&No", 2) ~= 1 then
        return
    end
    M.wezterm_pane(infer)
end

-- choose which repl pane slime sends to
function M.select_repl()
    -- drop panes whose dtach session is gone
    M.panes = vim.tbl_filter(function(p) return vim.uv.fs_stat(p.socket_path) ~= nil end, M.panes)
    if #M.panes == 0 then
        vim.notify("no repl panes open", vim.log.levels.WARN)
        return
    end
    local current = (vim.b.slime_config or {}).socket_path
    vim.ui.select(M.panes, {
        prompt = "slime repl:",
        format_item = function(p)
            return string.format("%s%s [pane %s] %s", p.socket_path == current and "* " or "", p.cmd, p.pane_id, p.cwd)
        end,
    }, function(pane)
        if pane then use_pane(pane) end
    end)
end

-- colors for vim-slime-cells (read after the colorscheme has loaded)
local function hl_attr(group, attr)
    return vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(group)), attr)
end
vim.g.slime_cells_fg_gui = hl_attr("CursorLineNR", "fg#")
vim.g.slime_cells_bg_gui = hl_attr("CursorLine", "bg#")

-- mappings
vim.keymap.set('n', '<leader>ri', function() M.open_repl() end)
vim.keymap.set('n', '<leader>rp', M.select_repl)
vim.keymap.set('n', '<leader>rm', '<Plug>SlimeMotionSend', { remap = true })
vim.keymap.set('n', '<leader>rr', '<Plug>SlimeSendCell', { remap = true })
vim.keymap.set('n', '<leader>rs', '<Plug>SlimeConfig', { remap = true })
vim.keymap.set('n', '<leader>rn', '<Plug>SlimeCellsSendAndGoToNext', { remap = true })
vim.keymap.set('n', '<leader>rj', '<Plug>SlimeCellsNext', { remap = true })
vim.keymap.set('n', '<leader>rk', '<Plug>SlimeCellsPrev', { remap = true })
vim.keymap.set('x', '<leader>rr', '<Plug>SlimeRegionSend', { remap = true })

return M
