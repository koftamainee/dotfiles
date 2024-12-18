return {
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "kyazdani42/nvim-tree.lua",
    opts = {
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
      view = {
        -- width = vim.o.columns, -- Set width to full screen
        side = "left",         -- You can also set "right" if preferred
        number = false,        -- Optional: Disable line numbers
        relativenumber = false -- Optional: Disable relative numbers
      }
    }
  },
  {
    {
      "christoomey/vim-tmux-navigator",
      event = "VeryLazy",
      cmd = {
        "TmuxNavigateLeft",
        "TmuxNavigateDown",
        "TmuxNavigateUp",
        "TmuxNavigateRight",
        "TmuxNavigatePrevious",
      },
      keys = {
        { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
        { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
        { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
        { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
        { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
      },
    },
  },
  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
