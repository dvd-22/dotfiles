-- Force C indentation to 4 spaces; loaded after other ftplugins
vim.bo.shiftwidth = 4
vim.bo.tabstop = 4
vim.bo.softtabstop = 4
vim.bo.expandtab = true
vim.bo.autoindent = true
vim.bo.cindent = false
vim.bo.smartindent = false

-- Prevent LSP or other plugins from changing local options later
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.c",
  callback = function()
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4
    vim.bo.softtabstop = 4
    vim.bo.expandtab = true
  end,
})
