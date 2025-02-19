servers = { "lua_ls", "vimls", "rust_analyzer", "zls", "pyright", "gopls", "ruff" }
-- mason_servers = { "terraformls", "pyright", "lua_ls", "vimls", "rust_analyzer", "zls", "tflint", "ruff_lsp" }
require('treesitter-config')
require('nvim-cmp-config')
require('lspconfig-config')
require('telescope-config')
require('nvim-tree-config')
require('diagnostics')
require('telescope').load_extension('harpoon')
require('nvim-navbuddy')
-- require('image').setup()
require("aerial").setup({
  on_attach = function(bufnr)
    vim.keymap.set("n", "K", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    vim.keymap.set("n", "J", "<cmd>AerialNext<CR>", { buffer = bufnr })
    vim.api.nvim_set_hl(0, 'AerialLineClass', { fg = "#f6cd61", bold = true })
    vim.api.nvim_set_hl(0, 'AerialLineFunction', { fg = "#f6cd61", bold = true })
    vim.api.nvim_set_hl(0, 'AerialLineNormal', { fg = "#f6cd61", bold = true })
    vim.api.nvim_set_hl(0, 'AerialLine', { fg = "#f6cd61", bold = true })
    vim.api.nvim_set_hl(0, 'AerialLineNC', { fg = "#222222", bg = "#f6cd61", bold = true })
  end,
  highlight_on_hover = true,
  highlight_on_jump = 300,
  show_guides = true,
})
vim.api.nvim_set_hl(0, 'ArialLine', { fg = "#f6cd61", bold = true })
vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
vim.keymap.set("n", "<leader><leader>a", "<cmd>AerialNavToggle<CR>")
-- require('repl-block-highlight').setup({
--   default_highlight_group = "Visual",
--   custom_highlight_group = { fg = "#000000", bg = "#7f7f7f", bold = true },
--})
require("symbols-outline").setup()
vim.keymap.set("n", "<leader>s", "<cmd>SymbolsOutline<CR>")
require("toggleterm").setup()
-- require("autoclose").setup({
--    options = {
--       disabled_filetypes = { "text" },
--       disable_when_touch = false,
--       touch_regex = "[%w(%[{]",
--       bidirectional_disable_when_touch = true,
--       pair_spaces = false,
--       auto_indent = true,
--       disable_command_mode = false,
--    },
-- disabled = false,
-- })
require('glow').setup({
    width = 240,
    height = 240,
    style = "dark",
    width_ration = 0.95,
    height_ration = 0.95,
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
-- require('oatjump').setup()
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
vim.keymap.set('n', '<c-t>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<c-t>q', vim.diagnostic.setloclist, opts)
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gh', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gwa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', 'gwr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', 'gwl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<C-t>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<C-t>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<C-t>f', function() vim.lsp.buf.format { async = true } end, bufopts)
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
  vim.keymap.set("n", "<C-t>cl", vim.lsp.codelens.run)
  vim.keymap.set("n", "gs", vim.lsp.buf.signature_help)
  vim.keymap.set("n", "<C-t>rn", vim.lsp.buf.rename)
  vim.keymap.set("n", "<C-t>f", vim.lsp.buf.format)
  vim.keymap.set("n", "<C-t>ca", vim.lsp.buf.code_action)
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

