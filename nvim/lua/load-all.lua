-- %% simple deps
require('telescope')
require('telescope').load_extension('harpoon')
require('csvview').setup()
require('rainbow_csv').setup()
require('colorizer').setup()
local navbuddy = require("nvim-navbuddy")

-- %% modularly defined deps
require('nvim-cmp-config')
require('zen-config')

-- %% leap
require('leap').add_default_mappings()
vim.api.nvim_create_autocmd( { 'BufEnter', 'VimEnter' }, {
    pattern = "*",
    callback = function(event)
      vim.keymap.set({'n', 'x', 'o'}, 's',  '<Plug>(leap-forward)')
    end,
})
vim.api.nvim_create_autocmd( { 'BufEnter', 'VimEnter' }, {
    pattern = "*",
    callback = function(event)
      vim.keymap.set({'n', 'x', 'o'}, 'S',  '<Plug>(leap-backward)')
    end,
})
require('leap.user').set_repeat_keys('<enter>', '<backspace>')

-- %% treesitter
require('nvim-treesitter.configs').setup {
    ensure_installed = {
        'python',
        'comment',
        'lua',
        'rust',
        'go',
        'cpp',
        'lua',
        'typescript',
        'javascript',
        'vim',
        'vimdoc',
        'query',
        'markdown',
        'markdown_inline',
        'nim',
        'terraform',
        'zig',
        'bash',
        'fish'
    },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

-- %% nvim-tree
require'nvim-tree'.setup {
    git = {
        enable = true,
        ignore = false,
        timeout = 400,
    },
}

-- %% treewalker
require('treewalker').setup({ highlight = true, highlight_duration = 250, highlight_group = 'CursorLine' })
-- movement
vim.keymap.set({ 'n', 'v' }, '<C-k>', '<cmd>Treewalker Up<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<C-j>', '<cmd>Treewalker Down<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<C-h>', '<cmd>Treewalker Left<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<C-l>', '<cmd>Treewalker Right<cr>', { silent = true })

-- swapping
vim.keymap.set('n', '<C-S-k>', '<cmd>Treewalker SwapUp<cr>', { silent = true })
vim.keymap.set('n', '<C-S-j>', '<cmd>Treewalker SwapDown<cr>', { silent = true })
vim.keymap.set('n', '<C-S-h>', '<cmd>Treewalker SwapLeft<cr>', { silent = true })
vim.keymap.set('n', '<C-S-l>', '<cmd>Treewalker SwapRight<cr>', { silent = true })

-- %% notebook
require('notebook').setup {
    insert_blank_line = true,
    show_index = true,
    show_cell_type = true,
    virtual_text_style = { fg = "#ffd700", italic = true },
}

-- %% eyeliner
require('eyeliner').setup({ forward = true})
vim.g.clever_f_not_overwrites_standard_mappings = 1
vim.keymap.set(
  {"n", "x", "o"},
  "f",
  function() 
    require("eyeliner").highlight({ forward = true })
    return "<Plug>(clever-f-f)"
  end,
  {expr = true}
)

-- %% symbols outline
require("symbols-outline").setup()
vim.keymap.set("n", "<leader>s", "<cmd>SymbolsOutline<CR>")

-- %% glow
require('glow').setup({
    width = 240,
    height = 240,
    style = "dark",
    width_ration = 0.95,
    height_ration = 0.95,
    install_path = '/usr/bin/glow'
})

-- %% marks
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
  mappings = {
    set_next = "<C-f><C-n>",
    toggle = "<C-f><C-f>",
    next = "<C-f><C-j>",
    prev = "<C-f><C-k>",
    preview = "<C-f>p",
    annotate = "<C-f>o",
    next_bookmark = "<C-f><C-l>",
    prev_bookmark = "<C-f><C-h>",
    delete_line = "<C-f><C-d>",
    delete_buf = "<C-f><C-c>",
    delete_bookmark = "<C-f>x",
    set_bookmark0 = "<C-f>0",
    set_bookmark1 = "<C-f>1",
    set_bookmark2 = "<C-f>2",
    set_bookmark3 = "<C-f>3",
    set_bookmark4 = "<C-f>4",
    set_bookmark5 = "<C-f>5",
    set_bookmark6 = "<C-f>6",
    set_bookmark7 = "<C-f>7",
    set_bookmark8 = "<C-f>8",
    set_bookmark9 = "<C-f>9",
  }
})
vim.keymap.set("n", "<C-f>lb", "<cmd>MarksListBuf<CR>")
vim.keymap.set("n", "<C-f>lg", "<cmd>MarksListGlobal<CR>")
vim.keymap.set("n", "<C-f>ls", "<cmd>MarksListAll<CR>")
vim.keymap.set("n", "<C-f>ll", "<cmd>BookmarksListAll<CR>")

-- %% smartcolumn
require("smartcolumn").setup({
    colorcolumn = 110,
    limit_to_window = true,
})

-- %% multicursor
local mc = require("multicursor-nvim")
mc.setup()
vim.keymap.set({"n", "x"}, "<up>", function() mc.lineAddCursor(-1) end)
vim.keymap.set({"n", "x"}, "<down>", function() mc.lineAddCursor(1) end)
vim.keymap.set({"n", "x"}, "<leader><up>", function() mc.lineSkipCursor(-1) end)
vim.keymap.set({"n", "x"}, "<leader><down>", function() mc.lineSkipCursor(1) end)
vim.keymap.set({"n", "x"}, "<leader>n", function() mc.matchAddCursor(1) end)
vim.keymap.set({"n", "x"}, "<leader>s", function() mc.matchSkipCursor(1) end)
vim.keymap.set({"n", "x"}, "<leader>N", function() mc.matchAddCursor(-1) end)
vim.keymap.set({"n", "x"}, "<leader>S", function() mc.matchSkipCursor(-1) end)
vim.keymap.set("n", "<c-leftmouse>", mc.handleMouse)
vim.keymap.set("n", "<c-leftdrag>", mc.handleMouseDrag)
vim.keymap.set("n", "<c-leftrelease>", mc.handleMouseRelease)
vim.keymap.set({"n", "x"}, "<leader>m", mc.toggleCursor)
-- Pressing `gaip` will add a cursor on each line of a paragraph.
vim.keymap.set("n", "ga", mc.addCursorOperator)
-- Clone every cursor and disable the originals.
vim.keymap.set({"n", "x"}, "<leader>mdc", mc.duplicateCursors)
-- Align cursor columns.
vim.keymap.set("n", "<leader>ma", mc.alignCursors)
-- Split visual selections by regex.
vim.keymap.set("x", "<leader>ms", mc.splitCursors)
-- match new cursors within visual selections by regex.
vim.keymap.set("x", "M", mc.matchCursors)
-- bring back cursors if you accidentally clear them
vim.keymap.set("n", "<leader>mgv", mc.restoreCursors)
-- Add a cursor for all matches of cursor word/selection in the document.
vim.keymap.set({"n", "x"}, "<leader>mA", mc.matchAllAddCursors)
-- Rotate the text contained in each visual selection between cursors.
vim.keymap.set("x", "<leader>mt", function() mc.transposeCursors(4) end)
vim.keymap.set("x", "<leader>mT", function() mc.transposeCursors(2) end)
-- Append/insert for each line of visual selections.
-- Similar to block selection insertion.
vim.keymap.set("x", "I", mc.insertVisual)
vim.keymap.set("x", "A", mc.appendVisual)
-- Increment/decrement sequences, treating all cursors as one sequence.
vim.keymap.set({"n", "x"}, "<leader>mi", mc.sequenceIncrement)
vim.keymap.set({"n", "x"}, "<leader>md", mc.sequenceDecrement)
-- Add a cursor and jump to the next/previous search result.
vim.keymap.set("n", "<leader>/n", function() mc.searchAddCursor(1) end)
vim.keymap.set("n", "<leader>/N", function() mc.searchAddCursor(-1) end)
-- Jump to the next/previous search result without adding a cursor.
vim.keymap.set("n", "<leader>/s", function() mc.searchSkipCursor(1) end)
vim.keymap.set("n", "<leader>/S", function() mc.searchSkipCursor(-1) end)
-- Add a cursor to every search result in the buffer.
vim.keymap.set("n", "<leader>m/A", mc.searchAllAddCursors)
-- Pressing `<leader>miwap` will create a cursor in every match of the
-- string captured by `iw` inside range `ap`.
-- This action is highly customizable, see `:h multicursor-operator`.
vim.keymap.set({"n", "x"}, "<leader><leader>m", mc.operator)
-- Mappings defined in a keymap layer only apply when there are
-- multiple cursors. This lets you have overlapping mappings.
mc.addKeymapLayer(function(layerSet)

    -- Select a different cursor as the main one.
    layerSet({"n", "x"}, "<left>", mc.prevCursor)
    layerSet({"n", "x"}, "<right>", mc.nextCursor)

    -- Delete the main cursor.
    layerSet({"n", "x"}, "<leader>x", mc.deleteCursor)

    -- Enable and clear cursors using escape.
    layerSet("n", "<esc>", function()
        if not mc.cursorsEnabled() then
            mc.enableCursors()
        else
            mc.clearCursors()
        end
    end)
end)


-- %% diagnostics
local signs = { Error = "✘", Warn = "", Hint = "•", Info = "" }
local diagnostics_active = true

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
    virtual_text = {
        prefix = '●', -- Could be '●', '▎', 'x'
    }
})

local function toggle_diagnostics()
  diagnostics_active = not diagnostics_active
  if diagnostics_active then
    vim.diagnostic.show()
  else
    vim.diagnostic.hide()
  end
end

vim.keymap.set('n', '<C-e><C-h>', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.keymap.set('n', '<C-e><C-k>', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.keymap.set('n', '<C-e><C-j>', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.keymap.set('n', '<C-e><C-l>', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
vim.keymap.set('n', '<C-e><C-t>', function()
    toggle_diagnostics()
end)

-- %% lsp
local servers = { "lua_ls", "vimls", "rust_analyzer", "zls", "pyright", "gopls", "ruff", "terraformls", "tflint", "sqlls" }
local opts = { noremap=true, silent=true }
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local lspconfig = require('lspconfig')
local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gfa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gfr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gfl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gc', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gR', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader><leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    navbuddy.attach(client, bufnr)
end

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = false
      }
    )

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

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        capabilities = capabilities,
        on_attach = on_attach,
    }
end

-- %% aerial
require("aerial").setup({
  on_attach = function(bufnr)
    vim.keymap.set("n", "U", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    vim.keymap.set("n", "D", "<cmd>AerialNext<CR>", { buffer = bufnr })
    vim.api.nvim_set_hl(0, 'AerialLineClass', { fg = "#ffd700", bold = true })
    vim.api.nvim_set_hl(0, 'AerialLineFunction', { fg = "#ffd700", bold = true })
    vim.api.nvim_set_hl(0, 'AerialLineNormal', { fg = "#ffd700", bold = true })
    vim.api.nvim_set_hl(0, 'AerialLine', { fg = "#ffd700", bold = true })
    vim.api.nvim_set_hl(0, 'AerialLineNC', { fg = "#222222", bg = "#ffd700", bold = true })
  end,
  highlight_on_hover = true,
  highlight_on_jump = 300,
  show_guides = true,
})
vim.api.nvim_set_hl(0, 'ArialLine', { fg = "#ffd700", bold = true })
vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
vim.keymap.set("n", "<leader><leader>a", "<cmd>AerialNavToggle<CR>")

-- %% metals lsp
local function jvmish(on_attach_params)
  local metals_config = require("metals").bare_config()
  local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
  metals_config.on_attach = on_attach_params
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "scala", "sbt", "java" },
    callback = function()
      require("metals").initialize_or_attach(metals_config)
    end,
    group = nvim_metals_group,
  })
end

-- %% archived

-- %% lualine
-- require('lualine').setup {
--     options = {
--         icons_enabled = true,
--         theme = 'auto',
--         component_separators = { left = '', right = ''},
--         --component_separators = { left = '╲', right = '╱' },
--         section_separators = { left = '', right = ''},
--         --section_separators = { left = '', right = '' },
--         disabled_filetypes = { 'NvimTree' },
--         always_divide_middle = true,
--         globalstatus = false,
--     },
--     sections = {
--         lualine_a = {'mode'},
--         lualine_b = {'branch', 'diff', 'diagnostics'},
--         lualine_c = {'filename'},
--         lualine_x = {'encoding', 'fileformat'},
--         lualine_y = {'filetype'},
--     },
--     inactive_sections = {
--         lualine_a = {},
--         lualine_b = {},
--         lualine_c = {'filename'},
--         lualine_x = {'filetype'},
--         lualine_y = {},
--         lualine_z = {}
--     },
--     tabline = {},
--     extensions = {}
-- }
