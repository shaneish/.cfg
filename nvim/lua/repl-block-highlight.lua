local smartcolumn = {}

local max_sign_nr = 0
local config = {
   repl_sign = {
     python = "# %%",
     lua = "-- %%",
     markdown = "```",
     md = "```",
     vim = '" %%',
   },
   default_highlight_group = "CursorLine",
   -- example highlight group: custom_highlight_group = { fg = "#222222", bg = "#fad5a5", bold = true },
   custom_highlight_group = { },
   symbol = ">>",
   disabled_filetypes = { 'txt', 'text', 'vim' },
}

local function not_disabled()
   local current_filetype = vim.api.nvim_buf_get_option(0, "filetype")
   for _, filetype in pairs(config.disabled_filetypes) do
      if filetype == current_filetype then
         return false
      end
   end
   return true
end

local function get_line(line_nr)
  local sgns = vim.fn.sign_getplaced(vim.fn.bufname("%"), { group = 'cbsg' })[1].signs
  if sgns ~= nil then
    for _, s in pairs(vim.fn.sign_getplaced(vim.fn.bufname("%"), { group = 'cbsg' })[1].signs) do
      if s.lnum == line_nr then
        return s.id
      end
    end
  end
  return -1
end

local function new_sign_id()
  local curr_max = 0
  local sgns = vim.fn.sign_getplaced(vim.fn.bufname("%"), { group = 'cbsg' })[1].signs
  local sign_id = 0
  if sgns ~= nil then
    for _, s in pairs(vim.fn.sign_getplaced(vim.fn.bufname("%"), { group = 'cbsg' })[1].signs) do
      if s.id > curr_max then
        curr_max = s.id
      end
    end
  end
  return curr_max + 1
end

local function scan_buffer()
   local lines = vim.api.nvim_buf_get_lines(0, 0, -1, true)
   for line_nr, line in pairs(lines) do
    if config.repl_sign[vim.bo.filetype] ~= nil then
      if line:find('^' .. config.repl_sign[vim.bo.filetype]) ~= nil then
        vim.cmd('sign place ' .. new_sign_id() .. ' group=cbsg line=' .. line_nr .. ' name=ReplCodeSeparator')
      end
    end
   end
end

local function detect()
  local line = vim.fn.getline('.')
  local line_nr = vim.fn.line('.')
  local curr_marked = get_line(line_nr)
  if config.repl_sign[vim.bo.filetype] ~= nil then
    if line:find('^' .. config.repl_sign[vim.bo.filetype]) ~= nil then
      if curr_marked == -1 then
        vim.cmd('sign place ' .. new_sign_id() .. ' group=cbsg line=' .. line_nr .. ' name=ReplCodeSeparator')
      end
    elseif curr_marked > -1 then
      vim.cmd('sign unplace ' .. curr_marked .. ' group=cbsg')
    end
  end
end

function smartcolumn.setup(user_config)
   user_config = user_config or {}

   for option, value in pairs(user_config) do
      config[option] = value
   end
   -- highlight ReplCodeBlocks guifg=#ffffff guibg=#fad5a5
   if not_disabled() then
     if next(config.custom_highlight_group) == nil then
       config["highlight_group"] = config.default_highlight_group
     else
       vim.api.nvim_set_hl(0, 'ReplCodeBlocks', config.custom_highlight_group)
       config["highlight_group"] = "ReplCodeBlocks"
     end
     vim.cmd('sign define ReplCodeSeparator text=' .. config.symbol .. ' linehl=' .. config.highlight_group)
     vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "InsertLeave" },
        { callback = detect })
     vim.api.nvim_create_autocmd({ "BufEnter" }, { callback = scan_buffer })
   end
end

return smartcolumn
