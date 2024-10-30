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


vim.keymap.set('n', '<leader><leader>D', function()
    toggle_diagnostics()
end)
