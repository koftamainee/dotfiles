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
  vim.lsp.config[srv] = {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
    -- you can also inject server-specific overrides here
  }
end

vim.lsp.enable(servers)
