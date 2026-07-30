return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local wk_ok, wk = pcall(require, "which-key")
    if wk_ok then
      wk.add { { "<leader>h", group = "git/hunks" } }
    end

    require("gitsigns").setup {
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local opts = { buffer = bufnr }

        vim.keymap.set("n", "]h", function()
          gs.nav_hunk "next"
        end, vim.tbl_extend("force", opts, { desc = "Next hunk" }))
        vim.keymap.set("n", "[h", function()
          gs.nav_hunk "prev"
        end, vim.tbl_extend("force", opts, { desc = "Prev hunk" }))
        vim.keymap.set("n", "<leader>hs", gs.stage_hunk, vim.tbl_extend("force", opts, { desc = "Stage hunk" }))
        vim.keymap.set("n", "<leader>hr", gs.reset_hunk, vim.tbl_extend("force", opts, { desc = "Reset hunk" }))
        vim.keymap.set("n", "<leader>hp", gs.preview_hunk, vim.tbl_extend("force", opts, { desc = "Preview hunk" }))
      end,
    }
  end,
}
