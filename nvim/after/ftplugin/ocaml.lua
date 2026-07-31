vim.bo.indentexpr = ""
vim.bo.autoindent = true

local buf = vim.api.nvim_get_current_buf()
local opts = { buffer = buf, silent = true }

vim.keymap.set("n", "<leader>oj", function()
  vim.cmd.OCamlJump()
end, vim.tbl_extend("force", opts, { desc = "Jump to parent expression" }))

vim.keymap.set("n", "<leader>oc", function()
  vim.cmd.OCamlConstruct()
end, vim.tbl_extend("force", opts, { desc = "Fill hole with construct" }))

vim.keymap.set("n", "<leader>oh", function()
  vim.cmd.OCamlJumpNextHole()
end, vim.tbl_extend("force", opts, { desc = "Jump to next hole" }))

vim.keymap.set("n", "<leader>oH", function()
  vim.cmd.OCamlJumpPrevHole()
end, vim.tbl_extend("force", opts, { desc = "Jump to previous hole" }))

vim.keymap.set("n", "<leader>on", function()
  vim.cmd.OCamlPhraseNext()
end, vim.tbl_extend("force", opts, { desc = "Next phrase" }))

vim.keymap.set("n", "<leader>op", function()
  vim.cmd.OCamlPhrasePrev()
end, vim.tbl_extend("force", opts, { desc = "Previous phrase" }))

vim.keymap.set("n", "<leader>oi", function()
  vim.cmd.OCamlInferIntf()
end, vim.tbl_extend("force", opts, { desc = "Infer interface" }))

vim.keymap.set("n", "<leader>os", function()
  vim.cmd.OCamlSwitchIntfImpl()
end, vim.tbl_extend("force", opts, { desc = "Switch .ml/.mli" }))

vim.keymap.set("n", "<leader>ot", function()
  vim.cmd.OCamlTypeEnclosing()
end, vim.tbl_extend("force", opts, { desc = "Type enclosing" }))
