local M = {}

vim.g.default_code_block_suffix = "%%"
vim.g.code_block_databricks_notebook_identifier = "COMMAND ----------"
vim.g.code_block_alt_file_types = { "md", "markdown", "rmd", "rmarkdown", "journal" }
vim.g.code_block_databricks_file_types = { "python" }
vim.g.code_block_type_annotation_priority = {
    vim.g.default_code_block_suffix,
    vim.g.code_block_databricks_notebook_identifier,
}

function M.infer_suffix()
    if vim.tbl_contains(vim.g.code_block_alt_file_types, vim.bo.filetype) then
        return ""
    elseif vim.tbl_contains(vim.g.code_block_databricks_file_types, vim.bo.filetype) then
        if vim.fn.search(vim.g.code_block_databricks_notebook_identifier, "n") ~= 0 then
            return vim.g.code_block_databricks_notebook_identifier
        end
    end
    return vim.g.default_code_block_suffix
end

vim.g.code_block_suffix = M.infer_suffix()

function M.code_block()
    if vim.tbl_contains(vim.g.code_block_alt_file_types, vim.bo.filetype) then
        vim.g.code_block_comment = "```"
    else
        local c = vim.bo.commentstring:gsub("%%s", ""):gsub("%s+", "")
        vim.g.code_block_comment = c
    end
    vim.g.code_block_current = vim.g.code_block_comment .. ' ' .. vim.g.code_block_suffix
    vim.g.slime_cell_delimiter = vim.g.code_block_current
    return vim.g.code_block_current
end

local function refresh()
    vim.g.code_block_current = M.code_block()
    vim.g.slime_cell_delimiter = M.code_block()
end

refresh()

function M.update_suffix()
    vim.g.code_block_suffix = vim.fn.input("Enter the code block type suffix: ")
    refresh()
end

function M.cycle_suffix()
    local prio = vim.g.code_block_type_annotation_priority
    local ind = -1
    for i, v in ipairs(prio) do
        if v == vim.g.code_block_suffix then ind = i - 1 end
    end
    if ind >= 0 then
        vim.g.code_block_suffix = prio[(ind + 1) % #prio + 1]
    else
        vim.g.code_block_type_annotation = prio[1]
    end
    refresh()
    vim.cmd([[silent call feedkeys("i \<Esc>x", "i")]])
    print("Selected: " .. vim.g.code_block_suffix)
end

local group = vim.api.nvim_create_augroup("CheckEveryTime", { clear = true })
vim.api.nvim_create_autocmd({ "VimEnter", "BufEnter", "WinEnter" }, {
    group = group,
    callback = function()
        vim.g.code_block_suffix = M.infer_suffix()
        refresh()
    end,
})
vim.api.nvim_create_autocmd({ "VimEnter", "BufEnter", "WinEnter" }, {
    group = group,
    pattern = { "*.txt", "*.md", "*.typ", "*.typst" },
    command = "set spell",
})

return M
