local M = {}

local function qf_is_open()
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.wo[win].buftype == "quickfix" then
      return true
    end
  end
  return false
end

M.toggle = function()
  if qf_is_open() then
    vim.cmd("cclose")
  else
    vim.cmd("copen")
    vim.cmd("wincmd p")
  end
end

local function count_valid(items)
  local n = 0
  for _, item in ipairs(items) do
    if item.valid == 1 then
      n = n + 1
    end
  end
  return n
end

local function after_make()
  local errors = vim.fn.getqflist()
  if count_valid(errors) == 0 then
    pcall(vim.cmd, "cclose")
    vim.fn.setqflist({}, "r")
    vim.api.nvim_echo({ { "build OK - 0 errors", "MoreMsg" } }, true, {})
  else
    vim.cmd("copen")
    vim.cmd("wincmd p")
    vim.api.nvim_echo({ { string.format("%d error(s) - see quickfix", #errors), "WarningMsg" } }, true, {})
  end
end

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  pattern = "make",
  group = vim.api.nvim_create_augroup("QFAfterMake", {}),
  callback = after_make,
})

vim.keymap.set("n", "<leader>mm", "<cmd>make<CR>", { desc = "Build project (compiler)" })
vim.keymap.set("n", "<leader>mq", M.toggle, { desc = "Toggle quickfix window" })
vim.keymap.set("n", "]e", "<cmd>cnext<CR>", { desc = "Next compiler error" })
vim.keymap.set("n", "[e", "<cmd>cprev<CR>", { desc = "Previous compiler error" })

return M
