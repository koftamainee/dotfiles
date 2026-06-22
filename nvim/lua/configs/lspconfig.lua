require("nvchad.configs.lspconfig").defaults()

local nvlsp = require "nvchad.configs.lspconfig"

local servers = {
  "lua_ls",
  "clangd",
  "gopls",
  "pyright",
  "bashls",
  "texlab",
  "cmake",
  "dockerls",
  "sqls",
  "hls",
}

for _, srv in ipairs(servers) do
  local opts = {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }

  if srv == "clangd" then
    opts.cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--completion-style=detailed",
      "--header-insertion=iwyu",
      "--pch-storage=memory",
      -- "--compile-commands-dir=build",
    }
  end

  if srv == "slangd" then
    opts.cmd = { "slangd", "--stdio" }
    opts.settings = {
      slang = {
        predefinedMacros = {}, -- fill as needed
      },
    }
  end

  vim.lsp.config[srv] = opts
end

vim.lsp.enable(servers)
