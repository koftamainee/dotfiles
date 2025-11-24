return {
  {
    "wakatime/vim-wakatime",
    lazy = false,
    setup = function()
      vim.cmd [[packadd wakatime/vim-wakatime]]
    end,
  },
  {
    "iamkarasik/sonarqube.nvim",
    config = function()
      require("sonarqube").setup {}
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^6", -- Recommended
    lazy = false, -- This plugin is already lazy
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
    },
  },
  {
    "vyfor/cord.nvim",
    lazy = false,
    build = ":Cord update",
    -- opts = {}
  },

  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

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
        side = "right",
        number = true,
        relativenumber = true,
      },
    },
  },
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
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = { "cpp", "c", "python", "lua", "bash", "rust", "go", "javascript", "typescript", "nu" }, -- Здесь можно добавить все языки
        highlight = {
          enable = true,
          disable = {},
        },
        indent = {
          enable = true,
        },
        autotag = {
          enable = true,
        },
      }

      vim.filetype.add {
        extension = {
          tpp = "cpp",
        },
      }
    end,
  },
}
