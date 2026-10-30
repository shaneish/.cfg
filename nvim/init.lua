vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- keep the vimscript config as is
local config_dir = vim.fn.stdpath("config") .. "/"
for _, file in ipairs({ ".vimrc", "theme.vim" }) do
    local source_file = config_dir .. file
    if vim.fn.filereadable(source_file) == 1 then
        vim.cmd.source(source_file)
    end
end

require('pack')
require('load-all')
require('codeblocks')
require('slime')
require('conceal')
require('misc')
require('keymaps')
