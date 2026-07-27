return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("gitsigns").setup {
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        vim.keymap.set("n", "]h", function()
          gs.nav_hunk "next"
        end, { buffer = bufnr })
        vim.keymap.set("n", "[h", function()
          gs.nav_hunk "prev"
        end, { buffer = bufnr })
        vim.keymap.set("n", "<leader>hs", gs.stage_hunk, { buffer = bufnr })
        vim.keymap.set("n", "<leader>hr", gs.reset_hunk, { buffer = bufnr })
        vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { buffer = bufnr })
      end,
    }
  end,
}
