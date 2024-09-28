-- lua/plugins/init.lua or wherever you configure your plugins
return {
    -- LSP configuration
    { "neovim/nvim-lspconfig" },  -- LSP support
    { "williamboman/mason.nvim", config = true }, -- Mason for LSP server management
    { "williamboman/mason-lspconfig.nvim", config = true }, -- Integration between mason and lspconfig

    -- Autocompletion plugins
    { "hrsh7th/nvim-cmp" }, -- Completion engine
    { "hrsh7th/cmp-nvim-lsp" }, -- LSP completion source for nvim-cmp
    { "hrsh7th/cmp-buffer" }, -- Buffer completion source
    { "hrsh7th/cmp-path" }, -- File path completion source
    { "hrsh7th/cmp-cmdline" }, -- Command line completion
    { "L3MON4D3/LuaSnip" }, -- Snippet engine
    { "saadparwaiz1/cmp_luasnip" }, -- Snippet completion source
}

