return {
  "ray-x/go.nvim",
  dependencies = {
    "ray-x/guihua.lua",
  },
  event = { "BufReadPre *.go", "BufNewFile *.go" },
  config = function()
    require("go").setup {
      gofmt = "gofmt",
      max_line_len = 120,
      tag_transform = false,
      test_runner = "go",
      dap_debug = false,
      lsp_cfg = false,
      lsp_document_format = false,
      goimport = "gofumpt",
      gocoverage_sign = "~",
      comment_placeholder = "",
      lsp_keymaps = false,
    }
  end,
}
