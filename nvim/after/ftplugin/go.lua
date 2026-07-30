local buf = vim.api.nvim_get_current_buf()
local opts = { buffer = buf, silent = true }

vim.keymap.set("n", "<leader>gt", function()
  vim.cmd.GoTestFunc()
end, vim.tbl_extend("force", opts, { desc = "Test function under cursor" }))

vim.keymap.set("n", "<leader>gT", function()
  vim.cmd.GoTestPkg()
end, vim.tbl_extend("force", opts, { desc = "Test all package" }))

vim.keymap.set("n", "<leader>ga", function()
  vim.cmd.GoAlt()
end, vim.tbl_extend("force", opts, { desc = "Toggle source/test file" }))


vim.keymap.set("n", "<leader>gi", function()
  vim.cmd.GoImplements()
end, vim.tbl_extend("force", opts, { desc = "Implements" }))

vim.keymap.set("n", "<leader>gs", function()
  vim.cmd.GoAddTag()
end, vim.tbl_extend("force", opts, { desc = "Add struct tags" }))

vim.keymap.set("n", "<leader>gS", function()
  vim.cmd.GoRmTag()
end, vim.tbl_extend("force", opts, { desc = "Remove struct tags" }))
