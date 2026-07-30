local buf = vim.api.nvim_get_current_buf()
local opts = { buffer = buf, silent = true }

vim.keymap.set("n", "<leader>ra", function()
  vim.cmd.RustLsp "codeAction"
end, vim.tbl_extend("force", opts, { desc = "Code action" }))

vim.keymap.set("n", "<leader>rr", function()
  vim.cmd.RustLsp "runnables"
end, vim.tbl_extend("force", opts, { desc = "Runnables" }))

vim.keymap.set("n", "<leader>rt", function()
  vim.cmd.RustLsp "testables"
end, vim.tbl_extend("force", opts, { desc = "Testables" }))

vim.keymap.set("n", "<leader>rm", function()
  vim.cmd.RustLsp "expandMacro"
end, vim.tbl_extend("force", opts, { desc = "Expand macro" }))

vim.keymap.set("n", "<leader>ro", function()
  vim.cmd.RustLsp "openDocs"
end, vim.tbl_extend("force", opts, { desc = "Open docs.rs" }))

vim.keymap.set("n", "<leader>rc", function()
  vim.cmd.RustLsp "openCargo"
end, vim.tbl_extend("force", opts, { desc = "Open Cargo.toml" }))

vim.keymap.set("n", "<leader>re", function()
  vim.cmd.RustLsp "explainError"
end, vim.tbl_extend("force", opts, { desc = "Explain error" }))

vim.keymap.set("n", "<leader>rf", function()
  vim.cmd.RustLsp "flyCheck"
end, vim.tbl_extend("force", opts, { desc = "Fly check" }))

vim.keymap.set("n", "<leader>rj", function()
  vim.cmd.RustLsp "joinLines"
end, vim.tbl_extend("force", opts, { desc = "Join lines" }))

vim.keymap.set("n", "<leader>rs", function()
  vim.cmd.RustLsp "ssr"
end, vim.tbl_extend("force", opts, { desc = "Structural search/replace" }))

vim.keymap.set("n", "<leader>rv", function()
  vim.cmd.RustLsp "relatedDiagnostics"
end, vim.tbl_extend("force", opts, { desc = "Related diagnostics" }))

vim.keymap.set("n", "<leader>rp", function()
  vim.cmd.RustLsp "parentModule"
end, vim.tbl_extend("force", opts, { desc = "Parent module" }))

vim.keymap.set("n", "<leader>rg", function()
  vim.cmd.RustLsp "crateGraph"
end, vim.tbl_extend("force", opts, { desc = "Crate graph" }))
