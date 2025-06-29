-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

local servers = {
  "lua_ls",
  "clangd",
  "gopls",
  "pyright",
  "bashls",
  "texlab",
  "cmake",
  "dockerls",
  "sqlls",
  "hls",
}
vim.lsp.enable "nushell"
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end
