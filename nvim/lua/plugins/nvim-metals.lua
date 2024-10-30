{
  "scalameta/nvim-metals",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  ft = { "scala", "sbt", "java" },
  opts = function()
    local metals_config = require("metals").bare_config()
    metals_config.on_attach = function(client, bufnr)
      require("metals").setup_dap()
      -- LSP mappings
      map("n", "gd", vim.lsp.buf.definition)
      map("n", "gD", vim.lsp.buf.declaration)
      map("n", "gh", vim.lsp.buf.hover)
      map("n", "gi", vim.lsp.buf.implementation)
      map("n", "gr", vim.lsp.buf.references)
      map("n", "gds", vim.lsp.buf.document_symbol)
      map("n", "gws", vim.lsp.buf.workspace_symbol)
      map("n", "<C-space>cl", vim.lsp.codelens.run)
      map("n", "gs", vim.lsp.buf.signature_help)
      map("n", "<C-space>rn", vim.lsp.buf.rename)
      map("n", "<C-space>f", vim.lsp.buf.format)
      map("n", "<C-space>ca", vim.lsp.buf.code_action)
      map("n", "gws", function()
        require("metals").hover_worksheet()
      end)
    end
    return metals_config
  end,
  config = function(self, metals_config)
    local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = self.ft,
      callback = function()
        require("metals").initialize_or_attach(metals_config)
      end,
      group = nvim_metals_group,
    })
  end
}
