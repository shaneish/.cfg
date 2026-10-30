-- %% build hooks (must be registered before vim.pack.add)
vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if kind ~= 'install' and kind ~= 'update' then return end
        if name == 'telescope-fzf-native.nvim' then
            vim.system({ 'make' }, { cwd = ev.data.path }):wait()
        elseif name == 'nvim-treesitter' then
            if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
            vim.cmd('TSUpdate')
        end
    end,
})

-- %% plugins
local gh = function(path) return 'https://github.com/' .. path end

vim.pack.add({
    gh('SmiteshP/nvim-navic'),
    gh('SmiteshP/nvim-navbuddy'),
    gh('nvim-treesitter/nvim-treesitter'),
    gh('neovim/nvim-lspconfig'),
    gh('hrsh7th/cmp-nvim-lsp'),
    gh('hrsh7th/cmp-buffer'),
    gh('hrsh7th/cmp-path'),
    gh('hrsh7th/cmp-cmdline'),
    gh('hrsh7th/nvim-cmp'),
    gh('hrsh7th/cmp-vsnip'),
    gh('hrsh7th/vim-vsnip'),
    gh('hrsh7th/cmp-nvim-lsp-signature-help'),
    gh('hrsh7th/cmp-nvim-lua'),
    gh('nvim-lua/plenary.nvim'),
    gh('nvim-telescope/telescope.nvim'),
    gh('nvim-telescope/telescope-fzf-native.nvim'),
    gh('muniftanjim/nui.nvim'),
    gh('wellle/context.vim'),
    gh('hashivim/vim-terraform'), -- terraform
    gh('rlane/pounce.nvim'), -- movement
    'https://codeberg.org/andyg/leap.nvim', -- movement (moved off GitHub)
    gh('ellisonleao/glow.nvim'), -- markdown preview - deprecate in favor of mdcat
    gh('williamboman/mason.nvim'),
    gh('williamboman/mason-lspconfig.nvim'),
    gh('rhysd/conflict-marker.vim'),
    gh('hat0uma/csvview.nvim'),
    gh('github/copilot.vim'),
    gh('chentoast/marks.nvim'),
    gh('kyazdani42/nvim-web-devicons'),
    gh('oatish/smartcolumn.nvim'),
    gh('norcalli/nvim-colorizer.lua'),
    gh('romgrk/barbar.nvim'),
    gh('jpalardy/vim-slime'),
    gh('Klafyvel/vim-slime-cells'),
    gh('drybalka/tree-climber.nvim'),
    gh('sindrets/diffview.nvim'),
    gh('aaronik/treewalker.nvim'),
    gh('jinh0/eyeliner.nvim'),
    gh('CopilotC-Nvim/CopilotChat.nvim'),
    gh('kaarmu/typst.vim'),
    gh('nathanaelkane/vim-indent-guides'),
    gh('samoshkin/vim-mergetool'),
    { src = gh('nvim-mini/mini.files'), version = 'stable' },
    -- gh('chrisgrieser/nvim-origami'),
}, { confirm = false })
