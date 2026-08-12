local function set_compiler(name, makeprg)
  vim.cmd("compiler " .. name)
  if makeprg then
    vim.bo.makeprg = makeprg
  end
end

local M = {}

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function()
    set_compiler("gcc", "make")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    set_compiler("go")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function()
    set_compiler("cargo", "cargo check")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "ocaml",
  callback = function()
    set_compiler("ocaml", "dune build")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "odin",
  callback = function()
    vim.bo.errorformat = "%f(%l:%c) Error:%*\\s%m,%f(%l:%c) Warning:%*\\s%m"
    vim.bo.makeprg = "odin build ."
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "elixir",
  callback = function()
    vim.bo.errorformat = "** (CompileError) %f:%l:%c: %m,%f:%l:%c: %m"
    vim.bo.makeprg = "mix compile"
  end,
})

return M
