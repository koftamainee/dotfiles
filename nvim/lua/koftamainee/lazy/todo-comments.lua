return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = { "BufReadPost", "BufNewFile" },
  config = function(_, opts)
    local pal = require "tokyodark.palette"
    opts = vim.tbl_deep_extend("force", opts, {
      keywords = {
        FIX  = { color = pal.red },
        TODO = { color = pal.yellow },
        HACK = { color = pal.orange },
        WARN = { color = pal.orange },
        PERF = { color = pal.blue },
        NOTE = { color = pal.cyan },
        TEST = { color = pal.green },
      },
    })
    require("todo-comments").setup(opts)
  end,
}
