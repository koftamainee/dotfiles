local buf = vim.api.nvim_get_current_buf()
local opts = { buffer = buf, silent = true }

vim.keymap.set("n", "<leader>hh", function()
  vim.cmd.ClangdSwitchSourceHeader()
end, vim.tbl_extend("force", opts, { desc = "Switch source/header" }))

vim.keymap.set("n", "<leader>ht", function()
  vim.cmd.ClangdTypeHierarchy()
end, vim.tbl_extend("force", opts, { desc = "Type hierarchy" }))

vim.keymap.set("n", "<leader>hi", function()
  vim.cmd.ClangdSymbolInfo()
end, vim.tbl_extend("force", opts, { desc = "Symbol info" }))



