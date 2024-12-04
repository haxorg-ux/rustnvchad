-- local fn = vim.fn

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- General Settings
local general = augroup("General", { clear = true })

autocmd("BufEnter", {
  callback = function()
    vim.bo.formatoptions = vim.bo.formatoptions:gsub("[cro]", "")
  end,
  group = general,
  desc = "Disable New Line Comment",
})
