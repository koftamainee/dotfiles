-- Import Mason and Mason LSP Config
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "pyright", "clangd" }, -- Replace with your desired LSP servers
})

local lspconfig = require('lspconfig')


-- clangd (for C/C++)
require('lspconfig').clangd.setup({
  on_attach = function(client, bufnr)
    -- Enable auto-formatting
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>f', '<cmd>lua vim.lsp.buf.format()<CR>', { noremap = true, silent = true })
  end,
  settings = {
    clangd = {
      format = true
    }
  }
})

-- gopls (for Go)
require('lspconfig').gopls.setup({
  on_attach = function(client, bufnr)
    -- Enable auto-formatting
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>f', '<cmd>lua vim.lsp.buf.format()<CR>', { noremap = true, silent = true })
  end,
  settings = {
    gopls = {
      format = true
    }
  }
})

-- rust-analyzer (for Rust)
require('lspconfig').rust_analyzer.setup({
  on_attach = function(client, bufnr)
    -- Enable auto-formatting
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>f', '<cmd>lua vim.lsp.buf.format()<CR>', { noremap = true, silent = true })
  end,
  settings = {
    ['rust-analyzer'] = {
      assist = { importGranularity = 'module' },
      cargo = { loadOutDirsFromCheck = true },
      procMacro = { enable = true }
    }
  }
})

-- Optional: Set up auto-format on save using autocmd
vim.cmd([[
  augroup LspAutocommands
    autocmd!
    autocmd BufWritePre * lua vim.lsp.buf.format()
  augroup END
]])


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

