return {
  "pixelsandpointers/slang.nvim",
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
