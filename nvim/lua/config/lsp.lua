-- Import Mason and Mason LSP Config
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "pyright", "clangd" }, -- Replace with your desired LSP servers
})

-- Import LSP Config
local lspconfig = require("lspconfig")

-- Automatically set up servers installed via Mason
require("mason-lspconfig").setup_handlers {
    function(server_name)
        lspconfig[server_name].setup({})
    end,
}

-- Include capabilities for nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Reuse the LSP server setup from before, but now pass the capabilities
require("mason-lspconfig").setup_handlers {
    function(server_name)
        require("lspconfig")[server_name].setup({
            capabilities = capabilities,  -- Enable autocompletion
        })
    end,
}

