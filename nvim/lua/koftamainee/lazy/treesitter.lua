return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",

    config = function()
      local parsers = {
        "vimdoc",
        "c",
        "cpp",
        "lua",
        "rust",
        "go",
        "python",
        "haskell",
        "bash",
        "dockerfile",
        "cmake",
        "latex",
        "elixir",
        "ocaml",
        "sql",
        "json",
        "yaml",
        "toml",
        "proto",
        "hcl",
        "markdown",
        "markdown_inline",
        "slang",
        "zig",
      }

      require("nvim-treesitter").install(parsers)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = parsers,
        callback = function(args)
          vim.treesitter.start(args.buf)

          local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
          if ok and stats and stats.size > 100 * 1024 then
            vim.treesitter.stop(args.buf)
          end
        end,
      })

      local indent_parsers = vim.deepcopy(parsers)
      for i = #indent_parsers, 1, -1 do
        if indent_parsers[i] == "ocaml" then
          table.remove(indent_parsers, i)
        end
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = indent_parsers,
        callback = function()
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesitter-context").setup {
        enable = true,
        multiwindow = false,
        max_lines = 0,
        min_window_height = 0,
        line_numbers = true,
        multiline_threshold = 20,
        trim_scope = "outer",
        mode = "cursor",
        separator = nil,
        zindex = 20,
        on_attach = nil,
      }
    end,
  },
}
