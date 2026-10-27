# Neovim Plugin Dependency Analysis

Entry point: `init.vim` → sources `.vimrc` and `theme.vim`, declares plugins via **vim-plug**, then loads `lua/load-all.lua`.

Plugin manager: [junegunn/vim-plug](https://github.com/junegunn/vim-plug) — works with both Vim and Neovim.

**Legend**

| Compatibility | Meaning |
|---|---|
| **Neovim only** | Requires Neovim (Lua API, LSP client, treesitter, etc.) |
| **Vim + Neovim** | Traditional Vimscript plugin; works in both editors |

---

## Plugin Manager

| Plugin | Compatibility | Purpose in this config |
|---|---|---|
| [junegunn/vim-plug](https://github.com/junegunn/vim-plug) | Vim + Neovim | Installs and loads all third-party plugins declared in `init.vim`. Auto-bootstraps from `stdpath('data')/site/autoload/plug.vim` if missing. |

---

## LSP, Completion, and Snippets

| Plugin | Compatibility | Purpose in this config |
|---|---|---|
| [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | Neovim only | Configures LSP clients (`lua_ls`, `pyright`, `rust_analyzer`, `gopls`, `terraformls`, `tinymist`, etc.) with shared `on_attach` keymaps and navbuddy integration. |
| [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim) | Neovim only | UI for installing/managing external tools (language servers, linters, formatters). |
| [williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) | Neovim only | Bridges Mason with lspconfig; `ensure_installed` matches the server list in `load-all.lua`. |
| [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Neovim only | Autocompletion engine; configured in `lua/nvim-cmp-config.lua`. |
| [hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) | Neovim only | LSP completion source for nvim-cmp; also supplies `default_capabilities()`. |
| [hrsh7th/cmp-buffer](https://github.com/hrsh7th/cmp-buffer) | Neovim only | Buffer text completion source (secondary cmp source). |
| [hrsh7th/cmp-path](https://github.com/hrsh7th/cmp-path) | Neovim only | File-path completion source for insert mode. |
| [hrsh7th/cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline) | Neovim only | Cmdline completion source — **installed but cmdline setup is commented out** in `nvim-cmp-config.lua`. |
| [hrsh7th/cmp-nvim-lsp-signature-help](https://github.com/hrsh7th/cmp-nvim-lsp-signature-help) | Neovim only | Inline signature help while typing function calls. |
| [hrsh7th/cmp-nvim-lua](https://github.com/hrsh7th/cmp-nvim-lua) | Neovim only | Lua API completion source — **installed but not listed in cmp sources**. |
| [hrsh7th/cmp-vsnip](https://github.com/hrsh7th/cmp-vsnip) | Neovim only | Bridges vim-vsnip snippets into nvim-cmp. |
| [hrsh7th/vim-vsnip](https://github.com/hrsh7th/vim-vsnip) | Vim + Neovim | Snippet engine; expanded via cmp Tab mappings in `nvim-cmp-config.lua`. |

---

## Treesitter and Syntax

| Plugin | Compatibility | Purpose in this config |
|---|---|---|
| [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Neovim only | Tree-sitter parsers for many languages; highlighting, folds, and `auto_install` enabled in `load-all.lua`. |
| [nvim-treesitter/playground](https://github.com/nvim-treesitter/playground) | Neovim only | Interactive treesitter inspection UI — **installed, no explicit setup** (available via `:TSPlaygroundToggle` etc.). |
| [hashivim/vim-terraform](https://github.com/hashivim/vim-terraform) | Vim + Neovim | Terraform/HCL syntax, alignment, and `terraform_fmt_on_save` / `terraform_align` settings in `init.vim`. |
| [kaarmu/typst.vim](https://github.com/kaarmu/typst.vim) | Vim + Neovim | Typst filetype detection and syntax highlighting for `.typ` / `.typst` files. |
| [rhysd/conflict-marker.vim](https://github.com/rhysd/conflict-marker.vim) | Vim + Neovim | Highlights Git merge conflict markers (`<<<<<<<`, etc.) — loads automatically. |

---

## Navigation, Movement, and UI Chrome

| Plugin | Compatibility | Purpose in this config |
|---|---|---|
| [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Neovim only | Fuzzy finder — `find_files`, `live_grep`, `buffers`, `current_buffer_fuzzy_find` via `<leader>t*` mappings. |
| [nvim-telescope/telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim) | Neovim only | Native FZF sorter for faster Telescope matching (built via `make` post-install). |
| [nvim-mini/mini.files](https://github.com/nvim-mini/mini.files) | Neovim only | Minimal file explorer toggled with `\` in `load-all.lua`. |
| [romgrk/barbar.nvim](https://github.com/romgrk/barbar.nvim) | Neovim only | Buffer tabline; buffer pick, pin, reorder, and Tab/S-Tab navigation mappings in `init.vim`. |
| [SmiteshP/nvim-navic](https://github.com/SmiteshP/nvim-navic) | Neovim only | Breadcrumb / context display for current symbol — dependency of navbuddy; `navic_silence` set in `load-all.lua`. |
| [SmiteshP/nvim-navbuddy](https://github.com/SmiteshP/nvim-navbuddy) | Neovim only | Symbol outline popup; attached on LSP `on_attach` when document symbols are available. |
| [wellle/context.vim](https://github.com/wellle/context.vim) | Vim + Neovim | Shows surrounding function/class context as a sticky header line — toggled from `lua/zen-config.lua` (that file is **not loaded** by `init.vim`). |
| [ggandor/leap.nvim](https://github.com/ggandor/leap.nvim) | Neovim only | Fast motion to visible targets; `s` / `S` remapped in `load-all.lua`. |
| [rlane/pounce.nvim](https://github.com/rlane/pounce.nvim) | Neovim only | Smart jump to best match for cursor word — mapped to `<C-s>`. |
| [drybalka/tree-climber.nvim](https://github.com/drybalka/tree-climber.nvim) | Neovim only | Treesitter-based structural navigation (`H/J/K/L`), node selection, and swap — heavy remapping in `init.vim` augroup `TreeClimber`. |
| [aaronik/treewalker.nvim](https://github.com/aaronik/treewalker.nvim) | Neovim only | Alternative tree-aware movement — **installed; setup and keymaps are commented out** in `load-all.lua`. |
| [jinh0/eyeliner.nvim](https://github.com/jinh0/eyeliner.nvim) | Neovim only | Highlights same-character targets for `f`/`t` motions with dimming; configured in `load-all.lua`. |
| [nathanaelkane/vim-indent-guides](https://github.com/nathanaelkane/vim-indent-guides) | Vim + Neovim | Visual indent guides — **installed**; note `init.vim` sets `g:indentLine_*` variables which belong to a different plugin (`indentLine.vim`), not indent-guides. |

---

## Git, Diff, and Merge

| Plugin | Compatibility | Purpose in this config |
|---|---|---|
| [sindrets/diffview.nvim](https://github.com/sindrets/diffview.nvim) | Neovim only | Git diff/merge UI — **installed, no explicit `setup()`** in active config. |
| [samoshkin/vim-mergetool](https://github.com/samoshkin/vim-mergetool) | Vim + Neovim | 3-way merge layout — `<leader>gm` maps to `MergetoolToggle`; layout `mr`, prefers local revision. |

---

## REPL, Notebooks, and Code Cells

| Plugin | Compatibility | Purpose in this config |
|---|---|---|
| [jpalardy/vim-slime](https://github.com/jpalardy/vim-slime) | Vim + Neovim | Send code to a REPL in an external terminal; configured for **WezTerm** (`g:slime_target = "wezterm"`) with custom `WeztermSlimePane()`. |
| [Klafyvel/vim-slime-cells](https://github.com/Klafyvel/vim-slime-cells) | Vim + Neovim | Cell-based sending for notebook-style `# %%` blocks; integrates with custom `CodeBlock()` / delimiter logic in `init.vim`. |

---

## AI Assistants

| Plugin | Compatibility | Purpose in this config |
|---|---|---|
| [github/copilot.vim](https://github.com/github/copilot.vim) | Vim + Neovim | Inline Copilot suggestions; `<C-h><C-h>` accept, word/line accept, cycle, dismiss mappings in `init.vim`. |
| [CopilotC-Nvim/CopilotChat.nvim](https://github.com/CopilotC-Nvim/CopilotChat.nvim) | Neovim only | Chat UI for Copilot — `CopilotChatToggle` on `<leader><leader>c`. |
| [xTacobaco/cursor-agent.nvim](https://github.com/xTacobaco/cursor-agent.nvim) | Neovim only | Integrates Cursor agent CLI with workspace args in `load-all.lua`. |

---

## Marks, Highlights, and Small Utilities

| Plugin | Compatibility | Purpose in this config |
|---|---|---|
| [chentoast/marks.nvim](https://github.com/chentoast/marks.nvim) | Neovim only | Enhanced mark/bookmark signs and lists; extensive `<C-f>*` mappings in `load-all.lua`. |
| [oatish/smartcolumn.nvim](https://github.com/oatish/smartcolumn.nvim) | Neovim only | Highlights colorcolumn at 110 chars (window-limited). |
| [norcalli/nvim-colorizer.lua](https://github.com/norcalli/nvim-colorizer.lua) | Neovim only | Highlights `#RGB` / CSS color values inline. |
| [hat0uma/csvview.nvim](https://github.com/hat0uma/csvview.nvim) | Neovim only | Table view for CSV/TSV — `CSVViewToggle` on `csv` mapping; filetypes `csv`/`tsv` set from `*.csv.txt` / `*.tsv.txt`. |
| [ellisonleao/glow.nvim](https://github.com/ellisonleao/glow.nvim) | Neovim only | Markdown preview via external `glow` binary — configured in `load-all.lua` (comment in `init.vim` notes possible deprecation). |
| [kyazdani42/nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons) | Neovim only | Icon glyphs for barbar, Telescope, and other UI plugins. |

---

## Shared Dependencies (not user-facing)

| Plugin | Compatibility | Purpose in this config |
|---|---|---|
| [nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim) | Neovim only | Lua utility library required by Telescope, CopilotChat, and many other Neovim plugins. |
| [muniftanjim/nui.nvim](https://github.com/muniftanjim/nui.nvim) | Neovim only | UI component library — dependency for CopilotChat and other floating-window plugins. |

---

## Built-in Vim/Neovim Features (not vim-plug plugins)

| Feature | Compatibility | Purpose in this config |
|---|---|---|
| **netrw** | Vim + Neovim | Built-in file explorer — `ToggleNetrw()` / `\` mapping in `.vimrc` (overlaps with mini.files on `\` only in Neovim path via `load-all.lua`). |
| **vim.lsp / diagnostics** | Neovim only | Native LSP client and diagnostic UI — custom signs, toggle, and navigation in `load-all.lua` (`<C-e>*` mappings). |
| **Custom colorschemes** | Vim + Neovim | Local themes in `theme.vim`, `active_theme.vim`, `theme__default-*.vim` — `.vimrc` sets `colorscheme quiet` (built-in). |

---

## Referenced in Config but Not Declared in `init.vim`

These appear in settings or Lua files but are **not** listed in the `plug#begin()` block. They may be dead configuration, manually installed elsewhere, or leftover from an alternate setup.

| Reference | Where | Notes |
|---|---|---|
| **vim-signify** (`g:signify_sign_*`) | `init.vim` | Git diff signs in the sign column — no `Plug` entry; settings are inactive unless signify is installed separately. |
| **nvim-metals** (`require("metals")`) | `load-all.lua`, `lua/plugins/nvim-metals.lua` | Scala/Java LSP — called in `load-all.lua` but plugin not in vim-plug; `lua/plugins/nvim-metals.lua` looks like a **lazy.nvim** spec and is not loaded. |
| **cmp-treesitter** | `nvim-cmp-config.lua` | Cmp source `{ name = 'treesitter' }` listed but matching plugin not in vim-plug. |
| **lazy.nvim** | `lua/config/lazy.lua` | Alternate plugin manager bootstrap — **not sourced** by `init.vim`. |
| **zen-mode.nvim** | `lua/zen-config.lua` | Distraction-free writing mode — file exists but is **not required** anywhere in the active entry path. |
| **repl-block-highlight** | `lua/repl-block-highlight.lua` | Local Lua module for REPL cell signs — **not required** in active config. |

---

## Commented-Out / Not Installed (historical references)

Found in `init.vim` or `load-all.lua` comments only:

| Plugin | Notes |
|---|---|
| `chrisgrieser/nvim-origami` | Fold management — commented `Plug` in `init.vim`. |
| `stevearc/*` (incomplete comment) | Likely `aerial.nvim` — referenced in commented `load-all.lua` block. |
| `nvim-lualine/lualine.nvim` | Status line — commented setup in `load-all.lua`. |
| `smoka7/multicursor-nvim` | Multi-cursor — commented setup in `load-all.lua`. |
| `simrat39/symbols-outline.nvim` | Document symbols sidebar — commented in `load-all.lua`. |
| `ThePrimeagen/harpoon` | Telescope extension — commented in `load-all.lua`. |

---

## Summary Counts

| Category | Count |
|---|---|
| Plugins declared in `init.vim` (vim-plug) | **45** |
| Neovim-only plugins | **~35** |
| Vim + Neovim compatible plugins | **~10** |
| Shared dependency plugins (plenary, nui, nvim-web-devicons) | **3** |

---

*Generated from analysis of `init.vim`, `.vimrc`, `theme.vim`, and `lua/*.lua` in this directory.*
