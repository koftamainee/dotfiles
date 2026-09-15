return {
  "pixelsandpointers/slang.nvim",
  -- This plugin is causing errors if loaded on startup and slang{c/d} is not found
  -- in path
  ft = "slang",
  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    -- slangd_path = '/path/to/vulkan-sdk/x86_64',
    auto_format = true,
    inlay_hints = true,
  },
}
