return {
  "saecki/crates.nvim",
  version = "v0.4.0",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = { "BufRead Cargo.toml", "BufNewFile Cargo.toml" },
  config = function()
    require("crates").setup {
      popup = {
        border = "rounded",
      },
    }
  end,
}
