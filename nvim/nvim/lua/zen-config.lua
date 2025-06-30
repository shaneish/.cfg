local function on()
    vim.wo.wrap = false
    vim.wo.number = false
    vim.wo.rnu = false
    vim.opt.colorcolumn = "0"
    vim.wo.cursorline = false
    vim.fn['context#toggle'](1)
    vim.fn['sy#toggle']()
    vim.cmd [[ LspStop ]]
    vim.api.nvim_command('echo ""')
    vim.opt.guicursor = "v-c-sm:block,n-i-ci-ve:ver25,r-cr-o:hor20"
    vim.diagnostics.hide()
end

local function off()
    vim.wo.wrap = false
    vim.wo.number = true
    vim.wo.rnu = true
    vim.wo.cursorline = true
    vim.fn['context#toggle'](1)
    vim.fn['sy#toggle']()
    vim.cmd [[ LspStart ]]
    vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"
    vim.diagnostics.show()
end

vim.keymap.set("n", "<leader>zz", function()
    require("zen-mode").setup {
        window = {
            width = .8,
            height = .20,
            options = { }
        },
        on_open = function(win)
            on()
        end,
        on_close = function()
            off()
        end,
    }
    require("zen-mode").toggle()
end)

vim.keymap.set("n", "<leader>zx", function()
    require("zen-mode").setup {
        window = {
            width = .80,
            height = .50,
            options = { }
        },
        on_open = function(win)
            on()
        end,
        on_close = function()
            off()
        end,
    }
    require("zen-mode").toggle()
end)

vim.keymap.set("n", "<leader>zc", function()
    require("zen-mode").setup {
        window = {
            width = .80,
            height = .80,
            options = { }
        },
        on_open = function(win)
            on()
        end,
        on_close = function()
            off()
        end,
    }
    require("zen-mode").toggle()
end)

vim.keymap.set("n", "<leader>ZZ", function()
    require("zen-mode").setup {
        window = {
            width = .95,
            height = .20,
            options = { }
        },
        on_open = function(win)
            on()
        end,
        on_close = function()
            off()
        end,
    }
    require("zen-mode").toggle()
end)

vim.keymap.set("n", "<leader>ZX", function()
    require("zen-mode").setup {
        window = {
            width = .95,
            height = .50,
            options = { }
        },
        on_open = function(win)
            on()
        end,
        on_close = function()
            off()
        end,
    }
    require("zen-mode").toggle()
end)

vim.keymap.set("n", "<leader>ZC", function()
    require("zen-mode").setup {
        window = {
            width = .95,
            height = .80,
            options = { }
        },
        on_open = function(win)
            on()
        end,
        on_close = function()
            off()
        end,
    }
    require("zen-mode").toggle()
end)

vim.keymap.set("n", "<leader>zv", function()
    require("zen-mode").setup {
        window = {
            width = .80,
            height = .95,
            options = { }
        },
        on_open = function(win)
            on()
        end,
        on_close = function()
            off()
        end,
    }
    require("zen-mode").toggle()
end)

vim.keymap.set("n", "<leader>ZV", function()
    require("zen-mode").setup {
        window = {
            width = .95,
            height = .95,
            options = { }
        },
        on_open = function(win)
            on()
        end,
        on_close = function()
            off()
        end,
    }
    require("zen-mode").toggle()
end)

